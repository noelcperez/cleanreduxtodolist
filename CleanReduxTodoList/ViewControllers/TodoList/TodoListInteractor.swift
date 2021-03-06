//
//  TodoListInteractor.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit
import ReSwift

protocol ListTodosBusinessLogic: Listener {
    func fetch_todos(request: ListTodos.FetchTodos.Request)
    func remove_todo(request: CreateTodo.Delete.Request)
}

protocol ListTodosDataSource {
    var todos: [Todo]! { get }
    var selected_index: Int { get set }
}

final class TodoListInteractor: BaseInteractor, ListTodosBusinessLogic, ListTodosDataSource, StoreSubscriber {
    
    typealias StoreSubscriberStateType = TodoListState
    
    var todos: [Todo]!
    var selected_index: Int = 0
    
    var view_model: ListTodosPresentationLogic?
    
    override init() {
        super.init()
        
        GlobalStore.store.subscribe(self)
    }
    
    //MARK: Listener protocol implementation
    func listen() {
        self.todo_list_worker.listen_to_todos { (todos) in
            GlobalStore.store.dispatch(SetTodosAction(todos: todos))
        }
    }
    
    func stop_listening() {
        self.todo_list_worker.stop_listening_todos()
    }
    
    //MARK: ListTodosBusinessLogic protocol implementation
    func fetch_todos(request: ListTodos.FetchTodos.Request) {
        self.todo_list_worker.fetch_todos { [unowned self] (todos, error) in
            if let the_error = error?.localizedDescription{
                self.view_model?.present_error(error: the_error)
            }
            else{
                GlobalStore.store.dispatch(SetTodosAction(todos: todos))
            }
        }
    }
    
    func remove_todo(request: CreateTodo.Delete.Request) {
        let todo_to_remove = self.build_todo_from_fields(todo: request.todo_from_fields)
        self.todo_list_worker.remove_todo(todo: todo_to_remove) { [unowned self] in
            self.present_fetch_todo_list()
        }
    }
    
    //MARK: Redux StoreSubscriber callback
    func newState(state: TodoListState) {
        self.todos = state.todos
        self.present_fetch_todo_list()
    }
    
    //MARK: Utilities functions
    fileprivate func build_todo_from_fields(todo: CreateTodo.TodoFromFields) -> Todo{
        return Todo(key: todo.key, title: todo.title, done: todo.done, create_date: Date(), done_date: Date())
    }
    
    fileprivate func present_fetch_todo_list(){
        self.view_model?.present_fetch_todo_list(response: ListTodos.FetchTodos.Response(todos: self.todos))
    }
}
