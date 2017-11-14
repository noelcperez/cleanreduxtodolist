//
//  TodoTableViewCell.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit
import Reusable

class TodoTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet var todoTitle: UILabel!
    @IBOutlet var doneStatusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.doneStatusView.layer.cornerRadius = self.doneStatusView.bounds.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(view_model: ListTodos.FetchTodos.TodosViewModel.DisplayedTodo){
        self.todoTitle.text = view_model.title
        self.doneStatusView.backgroundColor = view_model.is_done ? UIColor.green : UIColor.red
    }

}
