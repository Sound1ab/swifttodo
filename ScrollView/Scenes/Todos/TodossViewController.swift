//
//  CounterViewController.swift
//  AwesomeApp
//
//  Created by Phillip Parker on 17/04/2019.
//  Copyright © 2019 AwesomeCompany. All rights reserved.
//

import UIKit
import ReSwift
import ReRxSwift

class TodoViewController: UIViewController {
    
    let connection = Connection(
        store: store,
        mapStateToProps: mapStateToProps,
        mapDispatchToActions: mapDispatchToActions
    )

    
    override func viewDidLoad() {
        super.viewDidLoad()
        connection.connect()
        connection.bind(\Props.text, to: label.rx.text)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        connection.disconnect()
    }
    
}

extension TodoViewController: Connectable {
    struct Props {
        let todos: [Todo]
    }
    struct Actions {
        let addTodo: (Todo) -> Void
        let removeTodo: (Todo) -> Void
        let updateTodo: (Todo) -> Void
    }
}

private let mapStateToProps = { (appState: AppState) in
    return TodoViewController.Props(
        todos: (appState as AppState).todoState.todos
    )
}

private let mapDispatchToActions = { (dispatch: @escaping DispatchFunction) in
    return TodoViewController.Actions(
        addTodo: { todo in dispatch(AddTodo(todo: todo)) },
        removeTodo: { todo in dispatch(RemoveTodo(todo: todo)) },
        updateTodo: { todo in dispatch(UpdateTodo(todo: todo)) }
    )
}

