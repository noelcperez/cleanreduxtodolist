//
//  TodoDetailsViewModel.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/14/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol TodoDetailsPresentationLogic {
    func show_todo(response: TodoDetail.ShowTodo.Response)
    func todo_updated(response: CreateTodo.Update.Response)
}

class TodoDetailsViewModel: TodoDetailsPresentationLogic {
    
    fileprivate let date_formatter: DateFormatter = {
        let date_formatter = DateFormatter()
        date_formatter.dateStyle = .short
        date_formatter.timeStyle = .short
        return date_formatter
    }()
    
    var view_controller: TodoDetailsDisplayProtocol?
    
    func show_todo(response: TodoDetail.ShowTodo.Response) {
        let title = response.todo.title
        let is_done = response.todo.done == .done
        let created_date = self.date_formatter.string(from: response.todo.create_date)
        let done_date = self.date_formatter.string(from: response.todo.done_date)
        
        let displayed_todo = TodoDetail.ShowTodo.TodoViewModel.DisplayedTodo(title: title, is_done: is_done, create_date: created_date, done_date: done_date)
        self.view_controller?.show_todo(view_model: TodoDetail.ShowTodo.TodoViewModel(displayed_todo: displayed_todo))
    }
    
    func todo_updated(response: CreateTodo.Update.Response) {
        self.view_controller?.todo_updated(view_model: CreateTodo.Update.ViewModel())
    }
}
