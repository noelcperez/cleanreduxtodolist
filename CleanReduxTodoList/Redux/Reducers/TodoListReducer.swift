//
//  TodoListReducer.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit
import ReSwift

func todo_list_reducer(state: [Todo]?, action: Action) -> [Todo]{
    var state = state ?? []
    
    switch action {
    case let the_action as SetTodosAction:
        state = the_action.todos
    case let the_action as AddTodoAction:
        state.append(the_action.todo)
    case let the_action as UpdateTodo:
        if let todo_index = state.index(where: { (todo) -> Bool in
            return todo.key == the_action.todo.key
        }){
            state[todo_index] = the_action.todo
        }
    default:
        break
    }
    
    return state
}
