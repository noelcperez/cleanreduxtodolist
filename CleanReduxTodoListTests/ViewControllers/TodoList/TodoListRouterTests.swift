//
//  TodoListRouterTests.swift
//  CleanReduxTodoListTests
//
//  Created by Noel Perez on 11/16/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

@testable import CleanReduxTodoList
import XCTest
import UIKit

class TodoListRouterTests: XCTestCase {
    
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
    
    class TodoListRoutingLogicSpy: NSObject, TodoListRoutingLogic, TodoListDataPassing{
        
        var data_store: ListTodosDataSource?
        
        var todoListRoutingRouteToShowTodoDetailsCalled = false
        var todoListRoutingRouteToAddTodoCalled = false
        
        func routeToShowTodoDetails() {
            todoListRoutingRouteToShowTodoDetailsCalled = true
        }
        
        func routeToAddTodo() {
            todoListRoutingRouteToAddTodoCalled = true
        }
        
    }
    
    func testAddTodoShouldCallRouterToShowAddTodoViewController() {
        //Given
        let todoListRoutingLogicSpy = TodoListRoutingLogicSpy()
        todoListViewController.router = todoListRoutingLogicSpy
        
        //When
        loadView()
        let selector = NSSelectorFromString("add_todo")
        todoListViewController.perform(selector)
        
        //Then
        XCTAssertTrue(todoListRoutingLogicSpy.todoListRoutingRouteToAddTodoCalled, "if add todo button is tapped the router routeToAddTodo should be called")
    }
}
