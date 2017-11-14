//
//  ViewController.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol TodoListDisplayLogic: class {
    func display_fetched_todolist(view_model: ListTodos.FetchTodos.TodosViewModel)
}

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TodoListDisplayLogic {
    
    @IBOutlet var tableView: UITableView!
    
    var interactor: ListTodosBusinessLogic?
    var router: (NSObjectProtocol & TodoListRoutingLogic & TodoListDataPassing)?
    fileprivate var displayed_todos: [ListTodos.FetchTodos.TodosViewModel.DisplayedTodo] = []
    
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
        let interactor = TodoListInteractor()
        let view_model = TodoListViewModel()
        let router = TodoListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.view_model = view_model
        view_model.view_controller = viewController
        router.view_controller = viewController
        router.data_store = interactor
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TodoListViewController.add_todo))
        
        self.tableView.register(cellType: TodoTableViewCell.self)
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 40
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
    
    //MARK: - My Functions
    @objc fileprivate func add_todo(){
        self.router?.routeToAddTodo()
    }
    
    //MARK: - TodoListDisplayLogic protocol
    func display_fetched_todolist(view_model: ListTodos.FetchTodos.TodosViewModel) {
        self.displayed_todos = view_model.displayed_todos
        
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return displayed_todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TodoTableViewCell.self)
        
        cell.configure(view_model: displayed_todos[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router?.data_store?.selected_index = indexPath.row
        self.router?.routeToShowTodoDetails()
    }
}

