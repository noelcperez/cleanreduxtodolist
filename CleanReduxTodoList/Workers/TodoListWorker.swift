//
//  TodoListWorker.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

public class TodoListWorker {
    fileprivate var todoListServiceProtocol: TodoListServiceProtocol!
    
    init(todoListServiceProtocol: TodoListServiceProtocol) {
        self.todoListServiceProtocol = todoListServiceProtocol
    }
    
    func fetch_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void) {
        self.todoListServiceProtocol.fetch_all_todos(completionHandler: completionHandler)
    }
}

protocol TodoListServiceProtocol {
    func fetch_all_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void)
}

enum TodoListError: Error{
    case somethingHappened(error: String)
}
