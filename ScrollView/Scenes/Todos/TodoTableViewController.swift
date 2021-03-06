//
//  TodoTableViewController.swift
//  ScrollView
//
//  Created by Phillip Parker on 18/04/2019.
//  Copyright © 2019 Seventeenstates. All rights reserved.
//

import UIKit
import ReSwift

class TodoTableViewController: UITableViewController {
    
    var todos: [Todo] = [] {
        didSet(oldValue) {
            if oldValue.count > todos.count { return }
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        store.subscribe(self) { subcription in
            subcription.select { state in state.todoState.todos }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender else { return }
        guard (sender as? Todo)?.id != nil else { return }
        
        let todoDetailViewController = segue.destination as! TodoDetailViewController
        todoDetailViewController.selectedTodo = (sender as! Todo)
    }

}

extension TodoTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    // Configure cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.description
        cell.showsReorderControl = true
        
        return cell
    }
    
    // Delete row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        removeTodo(todo)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    // Reorder row
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        reOrderTodos(fromIndexPath.row, to.row)
        tableView.reloadData()
    }
    
    // Row tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do something with the selected row
        let todo = todos[indexPath.row]
        performSegue(withIdentifier: "TodoDetailSegue", sender: todo)
    }
}

extension TodoTableViewController: StoreSubscriber {
    func newState(state: [Todo]) {
        todos = state
    }
}

extension TodoTableViewController {
    var removeTodo: (Todo?) -> () {
        return { todo in
            store.dispatch(RemoveTodo(todo: todo))
        }
    }
    var reOrderTodos: (Int, Int) -> () {
        return { (fromIndexPath, toIndexPath) in
            store.dispatch(ReOrderTodos(fromIndexPath: fromIndexPath, toIndexPath: toIndexPath))
        }
    }
}
