//
//  TodoListViewModel.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol ListTodosPresentationLogic {
    func present_fetch_todo_list(response: ListTodos.FetchTodos.Response)
}

class TodoListViewModel: ListTodosPresentationLogic {
    
    var view_controller: TodoListDisplayLogic?
    
    fileprivate let date_formatter: DateFormatter = {
       let date_formatter = DateFormatter()
        date_formatter.dateStyle = .short
        date_formatter.timeStyle = .short
        return date_formatter
    }()
    
    func present_fetch_todo_list(response: ListTodos.FetchTodos.Response) {
        //Format todos to be presented
        var displayed_todos: [ListTodos.FetchTodos.TodosViewModel.DisplayedTodo] = []
        for todo in response.todos{
            let title = todo.title
            let is_done = todo.done == .done
            let created_date = self.date_formatter.string(from: todo.create_date)
            let done_date = self.date_formatter.string(from: todo.done_date)
            
            displayed_todos.append(ListTodos.FetchTodos.TodosViewModel.DisplayedTodo(title: title, is_done: is_done, create_date: created_date, done_date: done_date))
        }
        
        let view_model = ListTodos.FetchTodos.TodosViewModel(displayed_todos: displayed_todos)
        view_controller?.display_fetched_todolist(view_model: view_model)
    }
}
