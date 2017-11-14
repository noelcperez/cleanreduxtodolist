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
        case todo = 0
        case done = 1
    }
    
    var key: String!
    var title: String
    var done: DoneStatus
    var create_date: Date
    var done_date: Date
    
    fileprivate enum CodingKeys: String, CodingKey{
        case title
        case done
        case create_date
        case done_date
        
    }
}
extension Todo {
    init(from decoder: Decoder) throws {
        let todo = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try todo.decode(String.self, forKey: .title)
        self.done = try todo.decode(DoneStatus.self, forKey: .done)
        self.create_date = try todo.decode(Date.self, forKey: .create_date)
        self.done_date = try todo.decode(Date.self, forKey: .done_date)
    }
}
