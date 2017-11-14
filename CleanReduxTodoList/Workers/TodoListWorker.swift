//
//  TodoListWorker.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

public class TodoListWorker {
    fileprivate var todoListServiceProtocol: TodoListServiceProtocol & TodoListListenerProtocol & TodoListenerProtocol
    
    init(todoListServiceProtocol: TodoListServiceProtocol & TodoListListenerProtocol & TodoListenerProtocol) {
        self.todoListServiceProtocol = todoListServiceProtocol
    }
    
    //Create
    func add_todo(todo: Todo, completionHandlers: (Todo?, String?) -> Void){
        self.todoListServiceProtocol.add_todo(todo: todo, completionHandlers: completionHandlers)
    }
    
    //Update
    func update_todo(todo: Todo, completionHandlers: (String?) -> ()){
        self.todoListServiceProtocol.update_todo(todo: todo, completionHandlers: completionHandlers)
    }
    
    //Remove
    func remove_todo(todo: Todo, completionHandler: () -> ()){
        self.todoListServiceProtocol.remove_todo(todo: todo, completionHandler: completionHandler)
    }
    
    //List
    func fetch_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void) {
        self.todoListServiceProtocol.fetch_all_todos(completionHandler: completionHandler)
    }
    
    //Listen to all todos
    func listen_to_todos(completionHandlers: @escaping ([Todo]) -> Void){
        self.todoListServiceProtocol.listen_to_todos(completionHandler: completionHandlers)
    }
    
    func stop_listening_todos(){
        self.todoListServiceProtocol.stop_listening_todos()
    }
    
    //Listen to one todo
    func listen_to_todo(todo: Todo, completionHandler: @escaping (Todo) -> Void){
        self.todoListServiceProtocol.listen_to_todo(todo: todo, completionHandler: completionHandler)
    }
    
    func stop_listening_todo(){
        self.todoListServiceProtocol.stop_listening_todo()
    }
}

protocol TodoListServiceProtocol {
    func fetch_all_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void)
    func add_todo(todo: Todo, completionHandlers: (Todo?, String?) -> Void)
    func update_todo(todo: Todo, completionHandlers: (String?) -> ())
    func remove_todo(todo: Todo, completionHandler: () -> ())
}


protocol TodoListListenerProtocol {
    func listen_to_todos( completionHandler: @escaping ([Todo]) -> Void)
    func stop_listening_todos()
}

protocol TodoListenerProtocol {
    func listen_to_todo(todo: Todo, completionHandler: @escaping (Todo) -> Void)
    func stop_listening_todo()
}

enum TodoListError: Error{
    case somethingHappened(error: String)
}
