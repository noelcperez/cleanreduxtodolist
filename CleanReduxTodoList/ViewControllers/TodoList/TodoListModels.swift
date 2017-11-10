//
//  TodoListModels.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

enum ListTodos {
    enum FetchTodos {
        struct Request {
            
        }
        struct Response {
            var todos: [Todo]
        }
        struct TodosViewModel {
            struct DisplayedTodo {
                var title: String
                var is_done: Bool
                var create_date: String
                var done_date: String
            }
            var displayed_todos: [DisplayedTodo]
        }
    }
}
