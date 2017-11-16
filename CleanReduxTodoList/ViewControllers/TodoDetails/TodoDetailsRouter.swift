//
//  TodoDetailsRouter.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/14/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol TodoDetailsRoutingLogic {
    func routeToTodoList()
}

protocol TodoDetailsDataPassing{
    var data_source: TodoDetailsDataSource? { get }
}

class TodoDetailsRouter: NSObject, TodoDetailsRoutingLogic, TodoDetailsDataPassing {
    
    weak var view_controller: TodoDetailsViewController?
    var data_source: TodoDetailsDataSource?
    
    func routeToTodoList() {
        self.view_controller?.navigationController?.popViewController(animated: true)
    }
}
