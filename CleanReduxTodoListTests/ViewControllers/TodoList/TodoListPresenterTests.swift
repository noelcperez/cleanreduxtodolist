//
//  TodoListPresenterTests.swift
//  CleanReduxTodoListTests
//
//  Created by Noel Perez on 11/15/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

@testable import CleanReduxTodoList
import XCTest
import UIKit

class TodoListPresenterTests: XCTestCase {
    
    var todoListPresenter: TodoListViewModel!
    
    override func setUp() {
        super.setUp()
        
        todoListPresenter = TodoListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    class TodoListDisplayLogicSpy: TodoListDisplayLogic{
        
        var displayTodoListCalled = false
        var view_model: ListTodos.FetchTodos.TodosViewModel!
        
        func display_fetched_todolist(view_model: ListTodos.FetchTodos.TodosViewModel) {
            displayTodoListCalled = true
            
            self.view_model = view_model
        }
    }
    
    func testPresentFetchedTodosShouldFormatFetchedTodosForDisplay(){
        //Given
        let todoListDisplayLogicSpy = TodoListDisplayLogicSpy()
        todoListPresenter.view_controller = todoListDisplayLogicSpy
        
        //When
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 10
        dateComponents.day = 15
        dateComponents.hour = 10
        dateComponents.minute = 10
        dateComponents.second = 0
        let date = Calendar.current.date(from: dateComponents)!
        
        var todo1 = Seeds.Todos.todo1
        todo1.done = Todo.DoneStatus.done
        todo1.create_date = date
        todo1.done_date = date
        let todos = [todo1]
        
        let response = ListTodos.FetchTodos.Response(todos: todos)
        todoListPresenter.present_fetch_todo_list(response: response)
        
        //Then
        let displayedTodos = todoListDisplayLogicSpy.view_model.displayed_todos
        for displayedTodo in displayedTodos{
            XCTAssertEqual(displayedTodo.create_date, "10/15/17, 10:10 AM", "Presenting fetched todo list should properly format todo create date")
            XCTAssertEqual(displayedTodo.done_date, "10/15/17, 10:10 AM", "Presenting fetched todo list should properly format todo done date")
            XCTAssertEqual(displayedTodo.is_done, true, "Presenting fetched todo list should properly format the done status")
            XCTAssertEqual(displayedTodo.title, "Go Shopping", "Presenting fetched todo list should properly format the done status")
            XCTAssertEqual(displayedTodo.key, "lirgejbfv", "Presenting fetched todo list should properly format the done status")
        }
    }
    
    func testPresentFetchedTodosShouldAskViewControllerToDisplayThem(){
        //Given
        let todoListDisplayLogicSpy = TodoListDisplayLogicSpy()
        todoListPresenter.view_controller = todoListDisplayLogicSpy
        
        //When
        let todos = [Seeds.Todos.todo1]
        let response = ListTodos.FetchTodos.Response(todos: todos)
        todoListPresenter.present_fetch_todo_list(response: response)
        
        XCTAssertTrue(todoListDisplayLogicSpy.displayTodoListCalled, "present fetched todos should ask view controller to display the formatted todo list")
    }
}
