//
//  TodoDetailsModels.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/14/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

enum TodoDetail {
    enum ShowTodo {
        struct Request {
            
        }
        struct Response {
            var todo: Todo
        }
        struct TodoViewModel {
            struct DisplayedTodo {
                var title: String
                var is_done: Bool
                var create_date: String
                var done_date: String
            }
            var displayed_todo: DisplayedTodo
        }
    }
}
