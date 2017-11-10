//
//  AddTodoRouter.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol AddTodoRoutingLogic {
    func routeTodoList()
}

class AddTodoRouter: NSObject, AddTodoRoutingLogic {
    
    weak var view_controller: AddTodoViewController?
    
    func routeTodoList() {
        self.view_controller?.navigationController?.popViewController(animated: true)
    }
}
