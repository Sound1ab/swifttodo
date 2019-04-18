//
//  TodoModel.swift
//  ScrollView
//
//  Created by Phillip Parker on 17/04/2019.
//  Copyright © 2019 Seventeenstates. All rights reserved.
//

import Foundation

struct Todo {
    var id: UUID
    var description: String
    var isDone: Bool
    var createdAt: Date
    var updatedAt: Date
}
