//
//  Seeds.swift
//  CleanReduxTodoListTests
//
//  Created by Noel Perez on 11/15/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

@testable import CleanReduxTodoList
import UIKit

struct Seeds {
    struct Todos{
        static let todo1 = Todo(key: "lirgejbfv", title: "Go Shopping", done: Todo.DoneStatus.todo, create_date: Date(), done_date: Date())
        static let todo2 = Todo(key: "wrtnwetn", title: "Buy groceries", done: Todo.DoneStatus.todo, create_date: Date(), done_date: Date())
        static let todo3 = Todo(key: "etmeryertyj", title: "Work out", done: Todo.DoneStatus.todo, create_date: Date(), done_date: Date())
    }
}
