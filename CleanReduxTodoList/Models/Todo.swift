//
//  Todo.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

struct Todo: Codable {
    enum DoneStatus: Int, Codable {
        case notdone = 0
        case done = 1
        case forLater = 2
    }
    
    var key: String
    var title: String
    var done: DoneStatus
    var create_date: Date
    var done_date: Date
}
