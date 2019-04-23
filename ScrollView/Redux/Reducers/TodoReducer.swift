//
//  TodoReducer.swift
//  ScrollView
//
//  Created by Phillip Parker on 18/04/2019.
//  Copyright © 2019 Seventeenstates. All rights reserved.
//

import Foundation
import ReSwift

let  testTodo = Todo(id: UUID.init(), description: "Make coffee", isDone: false, createdAt: Date(timeIntervalSinceNow: TimeInterval.init()), updatedAt: Date(timeIntervalSinceNow: TimeInterval.init()))

struct TodoState: StateType {
    var todos: [Todo] = [testTodo]
}

func todoReducer(action: Action, state: TodoState?) -> TodoState {
    var state = state ?? TodoState()
    
    switch action {
    case let action as AddTodo:
        guard let todo = action.todo else { break }
        state.todos = state.todos + [todo]
    case let action as RemoveTodo:
        guard let todo = action.todo else { break }
        state.todos = state.todos.filter {(savedTodo: Todo) -> Bool in
            return savedTodo.id != todo.id
        }
    case let action as ReOrderTodos:
        var todosCopy = state.todos
        let removedTodo = todosCopy.remove(at: action.fromIndexPath)
        todosCopy.insert(removedTodo, at: action.toIndexPath)
        state.todos = todosCopy
    case let action as UpdateTodo:
        guard let todo = action.todo else { break }
        state.todos = state.todos.map { (savedTodo:Todo) -> Todo in 
            return savedTodo.id == todo.id ? todo : savedTodo
        }
    default:
        break
    }
    
    return state
}
