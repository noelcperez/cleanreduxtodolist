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
    func routeAddTodo()
}

protocol TodoListDataPassing {
    var data_store: ListTodosDataSource? { get }
}

class TodoListRouter: NSObject, TodoListRoutingLogic, TodoListDataPassing {
    
    var data_store: ListTodosDataSource?
    weak var view_controller: TodoListViewController?
    
    func routeToShowTodoDetails() {
        let showDetailsViewController = StoryboardScene.Main.todoDetailsViewController.instantiate()
        self.view_controller?.navigationController?.pushViewController(showDetailsViewController, animated: true)
    }
    
    func routeAddTodo() {
        let addTodoViewController = StoryboardScene.Main.addTodoViewController.instantiate()
        self.view_controller?.navigationController?.pushViewController(addTodoViewController, animated: true)
    }
}
