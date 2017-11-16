//
//  TodoWorkerTest.swift
//  CleanReduxTodoListTests
//
//  Created by Noel Perez on 11/15/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

@testable import CleanReduxTodoList
import XCTest
import UIKit

class TodoWorkerTest: XCTestCase {
    
    var todoListWorker: TodoListWorker!
    static var testTodos: [Todo]!
    
    override func setUp() {
        super.setUp()
        
        todoListWorker = TodoListWorker(todoListServiceProtocol: TodoFirebaseServiceSpy())
        
        TodoWorkerTest.testTodos = [Seeds.Todos.todo1, Seeds.Todos.todo2]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    class TodoFirebaseServiceSpy: FirebaseService{
        
        // MARK: Method call expectations
        var fetchTodosCalled = false
        var addTodoCalled = false
        var updateTodoCalled = false
        var deleteTodoCalled = false
        
        override func fetch_all_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void) {
            fetchTodosCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler(TodoWorkerTest.testTodos, nil)
            }
        }
        
        override func add_todo(todo: Todo, completionHandlers: @escaping (Todo?, String?) -> Void) {
            addTodoCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandlers(TodoWorkerTest.testTodos.first, nil)
            }
        }
        
        override func update_todo(todo: Todo, completionHandlers: @escaping (Todo?, String?) -> ()) {
            updateTodoCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandlers(TodoWorkerTest.testTodos.first!, nil)
            }
        }
        
        override func remove_todo(todo: Todo, completionHandler: @escaping () -> ()) {
            deleteTodoCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler()
            }
        }
    }
    
    func testFetchTodosShouldReturnListOfTodos(){
        //Given
        let todosFirebaseServiceSpy = todoListWorker.todoListServiceProtocol as! TodoFirebaseServiceSpy
        
        //When
        var fetchedTodos = [Todo]()
        let expect = expectation(description: "Wait for fetch_todos() to return")
        todosFirebaseServiceSpy.fetch_all_todos { (todos, error) in
            fetchedTodos = todos
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Then
        XCTAssert(todosFirebaseServiceSpy.fetchTodosCalled, "Calling fetch_todos() should ask the service for a list of todos")
        XCTAssertEqual(TodoWorkerTest.testTodos.count, fetchedTodos.count, "fetched todos should return a list of todos")
    }
    
    func testAddTodoShouldReturnAddedTodo(){
        //Given
        let todosFirebaseServiceSpy = todoListWorker.todoListServiceProtocol as! TodoFirebaseServiceSpy
        let todoToAdd = TodoWorkerTest.testTodos.first!
        
        //When
        var addedTodo: Todo?
        let expect = expectation(description: "Wait for fetch_todos() to return")
        todosFirebaseServiceSpy.add_todo(todo: todoToAdd) { (todo, error) in
            addedTodo = todo
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Then
        XCTAssert(todosFirebaseServiceSpy.addTodoCalled, "Calling add_todos() should ask the service to create a new todo")
        XCTAssertEqual(todoToAdd, addedTodo, "add_todo should create a todo")
    }
    
    func testUpdateTodoShouldReturnTheUpdatedTodo(){
        //Given
        let todosFirebaseServiceSpy = todoListWorker.todoListServiceProtocol as! TodoFirebaseServiceSpy
        let todoToUpdate = TodoWorkerTest.testTodos.first!
        
        //When
        var updatedTodo: Todo?
        let expect = expectation(description: "Wait for update_todo() to return")
        todosFirebaseServiceSpy.update_todo(todo: todoToUpdate) { (todo, error) in
            updatedTodo = todo
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Then
        XCTAssert(todosFirebaseServiceSpy.updateTodoCalled, "Calling update_todo() should ask the service to update a todo")
        XCTAssertEqual(todoToUpdate, updatedTodo, "update_todo should update the todo")
    }
    
    func testDeleteTodoShouldBeCalled(){
        //Given
        let todosFirebaseServiceSpy = todoListWorker.todoListServiceProtocol as! TodoFirebaseServiceSpy
        let todoToRemove = TodoWorkerTest.testTodos.first!
        
        //When
        let expect = expectation(description: "Wait for delete_todo() to return")
        todosFirebaseServiceSpy.remove_todo(todo: todoToRemove) {
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Then
        XCTAssert(todosFirebaseServiceSpy.deleteTodoCalled, "Calling delete_todo() should ask the service to delete a todo")
    }
}
