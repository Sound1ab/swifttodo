//
//  TodoReducer.swift
//  ScrollView
//
//  Created by Phillip Parker on 18/04/2019.
//  Copyright © 2019 Seventeenstates. All rights reserved.
//

import Foundation
import ReSwift

struct TextState: StateType {
    var text: String = ""
}

func textReducer(action: Action, state: TextState?) -> TextState {
    var state = state ?? TextState()
    
    switch action {
    case let action as UpdateText:
        state.text = action.text
    default:
        break
    }
    
    return state
}
