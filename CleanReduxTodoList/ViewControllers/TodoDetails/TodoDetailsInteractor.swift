//
//  TodoDetailsInteractor.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/14/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol TodoDetailsBusinessProtocol: Listener {
    func show_todo(todo: TodoDetail.ShowTodo.Request)
    func update_todo(todo: CreateTodo.Update.Request)
}

protocol TodoDetailsDataSource {
    var todo: Todo! { get set }
}

class TodoDetailsInteractor: BaseInteractor, TodoDetailsBusinessProtocol, TodoDetailsDataSource {
    
    var todo: Todo!
    
    var view_model: TodoDetailsPresentationLogic?
    
    //MARK: TodoDetailsBusinessProtocol implementation
    func show_todo(todo: TodoDetail.ShowTodo.Request) {
        self.view_model?.show_todo(response: TodoDetail.ShowTodo.Response(todo: self.todo))
    }
    
    func update_todo(todo: CreateTodo.Update.Request) {
        let todo_to_update = self.build_todo_from_fields(todo: todo.todo_from_fields)
        self.todo_list_worker.update_todo(todo: todo_to_update) { (todo, error) in
            if let the_error = error{
                self.view_model?.present_error(error: the_error)
            }
            else{
                self.view_model?.todo_updated(response: CreateTodo.Update.Response())
            }
        }
    }
    
    //MARK: TodoDetailsDataSource implementation
    func listen() {
        self.todo_list_worker.listen_to_todo(todo: self.todo) { (todo) in
            self.todo = todo
            //GlobalStore.store.dispatch(UpdateTodo(todo: todo))
            self.view_model?.show_todo(response: TodoDetail.ShowTodo.Response(todo: self.todo))
        }
    }
    
    func stop_listening() {
        self.todo_list_worker.stop_listening_todo()
    }
    
    //MARK: Utilities functions
    fileprivate func build_todo_from_fields(todo: CreateTodo.TodoFromFields) -> Todo{
        return Todo(key: self.todo.key, title: todo.title, done: todo.done, create_date: self.todo.create_date, done_date: Date())
    }
}
