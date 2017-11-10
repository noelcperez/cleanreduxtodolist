//
//  AddTodoModels.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

enum CreateTodo{
    struct TodoFromFields {
        var title: String
    }
    enum Create {
        struct Request {
            var todo_from_fields: TodoFromFields
        }
        struct Response {
            var todo: Todo
        }
        struct ViewModel {
            
        }
    }
}
