//
//  TodoDetailViewController.swift
//  ScrollView
//
//  Created by Phillip Parker on 18/04/2019.
//  Copyright © 2019 Seventeenstates. All rights reserved.
//

import UIKit
import ReSwift

class TodoDetailViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    
    var selectedTodo: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let selectedTodo = selectedTodo else { return }
        textField.text = selectedTodo.description
    }
    
    func createTodo(todo: Todo?) -> Todo {
        let uuid = todo != nil ? todo!.id : UUID.init()
        let description = textField.text ?? ""
        let timeNow = Date(timeIntervalSinceNow: TimeInterval.init())
        let createdAt = todo != nil ? todo!.createdAt : timeNow
        
        return Todo(
            id: uuid,
            description: description,
            isDone: false,
            createdAt: createdAt,
            updatedAt: timeNow
        )
    }
    
    func handleFinishEditing() {
        if selectedTodo != nil {
            let todo = createTodo(todo: selectedTodo)
            updateTodo(todo)
        } else {
            let todo = createTodo(todo: nil)
            addTodo(todo)
        }
        self.dismiss(animated: true)
    }
}

extension TodoDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ field: UITextField) -> Bool {
        if field == textField {
            field.resignFirstResponder()
            handleFinishEditing()
            return false
        }
        return true
    }
}

extension TodoDetailViewController {
    var addTodo: (Todo?) -> () {
        return { todo in
            store.dispatch(AddTodo(todo: todo))
        }
    }
    var updateTodo: (Todo?) -> () {
        return { todo in
            store.dispatch(UpdateTodo(todo: todo))
        }
    }
}
