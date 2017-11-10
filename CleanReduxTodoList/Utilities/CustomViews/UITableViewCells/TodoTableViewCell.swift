//
//  TodoTableViewCell.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit
import Reusable

class TodoTableViewCell: UITableViewCell, Reusable {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(view_model: ListTodos.FetchTodos.TodosViewModel.DisplayedTodo){
        
        self.textLabel?.text = view_model.title
        
    }

}
