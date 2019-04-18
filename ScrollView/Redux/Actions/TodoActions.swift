//
//  TodoActions.swift
//  ScrollView
//
//  Created by Phillip Parker on 18/04/2019.
//  Copyright © 2019 Seventeenstates. All rights reserved.
//

import Foundation
import ReSwift

struct AddTodo: Action {
    let todo: Todo?
}

struct RemoveTodo: Action {
    let todo: Todo?
}

struct UpdateTodo: Action {
    let todo: Todo?
}

struct ReOrderTodos: Action {
    let fromIndexPath: Int
    let toIndexPath: Int
}
