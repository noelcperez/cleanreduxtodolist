//
//  TodoListRouter.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol TodoListRoutingLogic {
    func routeToShowTodoDetails()
    func routeToAddTodo()
}

protocol TodoListDataPassing {
    var data_store: ListTodosDataSource? { get set }
}

class TodoListRouter: NSObject, TodoListRoutingLogic, TodoListDataPassing {
    
    var data_store: ListTodosDataSource?
    weak var view_controller: TodoListViewController?
    
    func routeToShowTodoDetails() {
        if let todos = self.data_store?.todos, let selected_index = self.data_store?.selected_index{
            let showDetailsViewController = StoryboardScene.Main.todoDetailsViewController.instantiate()
            var data_source = showDetailsViewController.router?.data_source
            data_source?.todo = todos[selected_index]
            self.view_controller?.navigationController?.pushViewController(showDetailsViewController, animated: true)
        }
    }
    
    func routeToAddTodo() {
        let addTodoViewController = StoryboardScene.Main.addTodoViewController.instantiate()
        self.view_controller?.navigationController?.pushViewController(addTodoViewController, animated: true)
    }
}
