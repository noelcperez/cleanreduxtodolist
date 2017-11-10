//
//  TodoListListener.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

public class TodoListListener: TodoListListenerProtocol {
    fileprivate var todoListListenerProtocol: TodoListListenerProtocol!
    
    init(todoListListenerProtocol: TodoListListenerProtocol) {
        self.todoListListenerProtocol = todoListListenerProtocol
    }
    
    
}


protocol TodoListListenerProtocol {
    
}
