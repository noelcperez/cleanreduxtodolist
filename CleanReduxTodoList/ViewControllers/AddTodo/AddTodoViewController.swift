//
//  AddTodoViewController.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol AddTodoDisplayProtocol: DisplaysError {
    func todo_created(view_model: CreateTodo.Create.ViewModel)
}

class AddTodoViewController: UIViewController, AddTodoDisplayProtocol {
    
    @IBOutlet var titleTextField: UITextField!
    
    var interactor: AddTodoBusinessProtocol?
    var router: (NSObjectProtocol & AddTodoRoutingLogic)?
    
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
        let interactor = AddTodoInteractor()
        let view_model = AddTodoViewModel()
        let router = AddTodoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.view_model = view_model
        view_model.view_controller = viewController
        router.view_controller = viewController
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Todo"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddTodoViewController.add_todo))
        
        self.titleTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - My Functions
    @objc fileprivate func add_todo(){
        self.interactor?.add_todo(todo: CreateTodo.Create.Request(todo_from_fields: CreateTodo.TodoFromFields(title: self.titleTextField.text!, done: .todo, key: "")))
    }

    //MARK: - Display protocol
    func todo_created(view_model: CreateTodo.Create.ViewModel) {
        self.router?.routeTodoList()
    }
    
}
