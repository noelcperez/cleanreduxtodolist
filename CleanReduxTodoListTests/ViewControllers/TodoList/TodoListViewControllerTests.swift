//
//  TodoListViewControllerTests.swift
//  CleanReduxTodoListTests
//
//  Created by Noel Perez on 11/15/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

@testable import CleanReduxTodoList
import XCTest
import UIKit

class TodoListViewControllerTests: XCTestCase {
    
    var todoListViewController: TodoListViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        todoListViewController = StoryboardScene.Main.todoListViewController.instantiate()
    }
    
    override func tearDown() {
        window = nil
        todoListViewController = nil
        
        super.tearDown()
    }
    
    func loadView(){
        window.addSubview(todoListViewController.view)
        RunLoop.current.run(until: Date())
    }
    
    class TodoListBusinessLogicSpy: ListTodosBusinessLogic{
        
        var fetchTodosCalled = false
        var removeTodoCalled = false
        
        func fetch_todos(request: ListTodos.FetchTodos.Request) {
            fetchTodosCalled = true
        }
        
        func remove_todo(request: CreateTodo.Delete.Request) {
            removeTodoCalled = true
        }
        
        func listen() {
            fetchTodosCalled = true
        }
        
        func stop_listening() {
            
        }
    }
    
    class TableViewSpy: UITableView{
        
        var reloadCalled = false
        
        override func reloadData() {
            reloadCalled = true
        }
    }
    
    func testShoudlFetchTodosWhenViewIsLoaded(){
        //Given
        let todoListBusinessLogic = TodoListBusinessLogicSpy()
        todoListViewController.interactor = todoListBusinessLogic
        
        //When
        loadView()
        
        //then
        XCTAssertTrue(todoListBusinessLogic.fetchTodosCalled, "loading the view should ask the interactor to fetch todos")
    }
    
    func testShouldDisplayFetchedTodos(){
        //Given
        let tableViewSpy = TableViewSpy()
        todoListViewController.tableView = tableViewSpy
        
        //When
        let diplayed_todo = ListTodos.FetchTodos.TodosViewModel.DisplayedTodo(key: "2erbvi2e", title: "onqefov", is_done: true, create_date: "", done_date: "")
        let view_model = ListTodos.FetchTodos.TodosViewModel(displayed_todos: [diplayed_todo])
        todoListViewController.display_fetched_todolist(view_model: view_model)
    
        //Then
        XCTAssertTrue(tableViewSpy.reloadCalled, "displaying fetched todos should ask table view to reload")
    }
}
