//
//  Interactor.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/16/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

class BaseInteractor {
    var todo_list_worker = TodoListWorker(todoListServiceProtocol: FirebaseService())
}
