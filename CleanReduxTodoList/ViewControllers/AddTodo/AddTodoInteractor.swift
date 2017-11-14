//
//  AddTodoInteractor.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol AddTodoBusinessProtocol {
    func add_todo(todo: CreateTodo.Create.Request)
}

protocol AddTodoDataSource {
    var todo: Todo? { get set }
}

class AddTodoInteractor: AddTodoBusinessProtocol, AddTodoDataSource {
    
    var todo: Todo?
    
    var view_model: AddTodoPresentationLogic?
    fileprivate let todo_worker = TodoListWorker(todoListServiceProtocol: FirebaseService())
    
    func add_todo(todo: CreateTodo.Create.Request) {
        let todo_to_create = self.build_todo_from_fields(todo: todo.todo_from_fields)
        
        todo_worker.add_todo(todo: todo_to_create) { (todo, error) in
            if let _ = error{
                //Show error
            }
            else if let the_todo = todo{
                self.todo = the_todo
                //If I wasn't using Firebase I must call the Redux AddTodo Action like this
                //GlobalStore.store.dispatch(AddTodoAction(todo: todo))
                //Call the todo added
                self.view_model?.todo_created(response: CreateTodo.Create.Response(todo: the_todo))
            }
        }
    }
    
    fileprivate func build_todo_from_fields(todo: CreateTodo.TodoFromFields) -> Todo{
        return Todo(key: "", title: todo.title, done: todo.done, create_date: Date(), done_date: Date())
    }
}
