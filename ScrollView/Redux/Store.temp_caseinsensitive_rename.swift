//
//  store.swift
//  ScrollView
//
//  Created by Phillip Parker on 17/04/2019.
//  Copyright © 2019 Seventeenstates. All rights reserved.
//

import Foundation

//
//  Store.swift
//  AwesomeApp
//
//  Created by Phillip Parker on 17/04/2019.
//  Copyright © 2019 AwesomeCompany. All rights reserved.
//

import Foundation
import ReSwift

struct CounterActionIncrease: Action {}
struct CounterActionDecrease: Action {}

func counterReducer(action: Action, state: AppState?) -> AppState {
    // if no state has been provided, create the default state
    var state = state ?? AppState()
    
    switch action {
    case _ as CounterActionIncrease:
        state.counter += 1
    case _ as CounterActionDecrease:
        state.counter -= 1
    default:
        break
    }
    
    return state
}

struct AppState: StateType {
    var counter: Int = 0
}

