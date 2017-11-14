//
//  TodoListActions.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit
import ReSwift

struct SetTodosAction: Action {
    let todos: [Todo]
}

struct AddTodoAction: Action {
    let todo: Todo
}

struct UpdateTodo: Action {
    let todo: Todo
}
