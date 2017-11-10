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
}

protocol ListTodosDataSource {
    var todos: [Todo]? { get }
}

class TodoListInteractor: ListTodosBusinessLogic, ListTodosDataSource, StoreSubscriber {
    
    typealias StoreSubscriberStateType = TodoListState
    
    var todos: [Todo]?
    
    var view_model: TodoListViewModel?
    var todo_list_worker = TodoListWorker(todoListServiceProtocol: FirebaseService())
    
    init() {
        GlobalStore.store.subscribe(self)
    }
    
    func fetch_todos(request: ListTodos.FetchTodos.Request) {
        self.todo_list_worker.fetch_todos { (todos, error) in
            if let _ = error{
                //Show error
            }
            else{
                self.todos = todos
                GlobalStore.store.dispatch(SetTodosAction(todos: todos))
            }
        }
    }
    
    func listen() {
        self.todo_list_worker.listen_to_todos { (todos) in
            self.todos = todos
            GlobalStore.store.dispatch(SetTodosAction(todos: todos))
        }
    }
    
    func stop_listening() {
        self.todo_list_worker.stop_listening_todos()
    }
    
    //MARK: Redux StoreSubscriber callback
    func newState(state: TodoListState) {
        self.view_model?.present_fetch_todo_list(response: ListTodos.FetchTodos.Response(todos: state.todos))
    }
}
