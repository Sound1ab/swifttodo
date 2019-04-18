//
//  Store.swift
//  AwesomeApp
//
//  Created by Phillip Parker on 17/04/2019.
//  Copyright © 2019 AwesomeCompany. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var todoState: TodoState = TodoState()
}

func AppReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        todoState: todoReducer(action: action, state: state?.todoState)
    )
}

var store: Store<AppState> = Store<AppState>(
    reducer: AppReducer,
    state: nil
)
