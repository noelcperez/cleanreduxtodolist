//
//  TodoDetailsViewController.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol TodoDetailsDisplayProtocol: DisplaysError {
    func show_todo(view_model: TodoDetail.ShowTodo.TodoViewModel)
    func todo_updated(view_model: CreateTodo.Update.ViewModel)
}

class TodoDetailsViewController: UIViewController, TodoDetailsDisplayProtocol{
    
    @IBOutlet var todoTitle: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    var interactor: TodoDetailsBusinessProtocol?
    var router: (NSObjectProtocol & TodoDetailsRoutingLogic & TodoDetailsDataPassing)?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: Setup
    private func setup(){
        let viewController = self
        let interactor = TodoDetailsInteractor()
        let view_model = TodoDetailsViewModel()
        let router = TodoDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.view_model = view_model
        view_model.view_controller = viewController
        router.view_controller = viewController
        router.data_source = interactor
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor?.show_todo(todo: TodoDetail.ShowTodo.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.interactor?.listen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.interactor?.stop_listening()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Actions
    @IBAction func doneButtonTouchUpInside(_ sender: UIButton) {
        self.interactor?.update_todo(todo: CreateTodo.Update.Request(todo_from_fields: CreateTodo.TodoFromFields(title: self.todoTitle.text!, done: .done, key: "")))
    }
    
    //MARK: - Todo Details Display protocol
    func show_todo(view_model: TodoDetail.ShowTodo.TodoViewModel) {
        self.todoTitle.text = view_model.displayed_todo.title
        self.doneButton.isEnabled = !view_model.displayed_todo.is_done
        
        if view_model.displayed_todo.is_done{
            self.doneButton.setTitle("Done!", for: .normal)
        }
        else{
            self.doneButton.setTitle("Done", for: .normal)
        }
        
    }
    
    func todo_updated(view_model: CreateTodo.Update.ViewModel) {
        self.router?.routeToTodoList()
    }
    
}
