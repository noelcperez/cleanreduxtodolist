//
//  AddTodoViewModel.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol AddTodoPresentationLogic: PresentsError {
    func todo_created(response: CreateTodo.Create.Response)
}

class AddTodoViewModel: AddTodoPresentationLogic {
    
    var view_controller: AddTodoDisplayProtocol?
    
    func todo_created(response: CreateTodo.Create.Response) {
        self.view_controller?.todo_created(view_model: CreateTodo.Create.ViewModel())
    }
    
    func present_error(error: String) {
        self.view_controller?.display_error(error: error)
    }
    
}
