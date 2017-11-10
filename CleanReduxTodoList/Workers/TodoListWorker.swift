//
//  TodoListWorker.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

public class TodoListWorker {
    fileprivate var todoListServiceProtocol: TodoListServiceProtocol & TodoListListenerProtocol
    
    init(todoListServiceProtocol: TodoListServiceProtocol & TodoListListenerProtocol) {
        self.todoListServiceProtocol = todoListServiceProtocol
    }
    
    //Create
    func add_todo(todo: Todo, completionHandlers: (Todo, String?) -> Void){
        self.todoListServiceProtocol.add_todo(todo: todo, completionHandlers: completionHandlers)
    }
    
    //List
    func fetch_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void) {
        self.todoListServiceProtocol.fetch_all_todos(completionHandler: completionHandler)
    }
    
    func listen_to_todos(completionHandlers: @escaping ([Todo]) -> Void){
        self.todoListServiceProtocol.listen_to_todos(completionHandler: completionHandlers)
    }
    
    func stop_listening_todos(){
        self.todoListServiceProtocol.stop_listening_todos()
    }
}

protocol TodoListServiceProtocol {
    func fetch_all_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void)
    func add_todo(todo: Todo, completionHandlers: (Todo, String?) -> Void)
}


protocol TodoListListenerProtocol {
    func listen_to_todos(completionHandler: @escaping ([Todo]) -> Void)
    func stop_listening_todos()
}

enum TodoListError: Error{
    case somethingHappened(error: String)
}
