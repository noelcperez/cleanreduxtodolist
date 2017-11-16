//
//  AppReducer.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit
import ReSwift

func appReducer(action: Action, state: TodoListState?) -> TodoListState{
    return TodoListState(
        todos: todo_list_reducer(state: state?.todos, action: action)
    )
}
