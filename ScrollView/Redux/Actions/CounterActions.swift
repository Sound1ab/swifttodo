//
//  TodoActions.swift
//  ScrollView
//
//  Created by Phillip Parker on 18/04/2019.
//  Copyright © 2019 Seventeenstates. All rights reserved.
//

import Foundation
import ReSwift

struct DecreaseCounter: Action {
    let todo: Todo?
}

struct SetTodos: Action {
    let todos: [Todo]?
}
