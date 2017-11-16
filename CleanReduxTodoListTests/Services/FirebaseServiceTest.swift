//
//  FirebaseServiceTest.swift
//  CleanReduxTodoListTests
//
//  Created by Noel Perez on 11/15/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

@testable import CleanReduxTodoList
import XCTest
import UIKit

class FirebaseServiceTest: XCTestCase {
    var firebaseService: FirebaseService!
    var testTodos: [Todo]!
    
    override func setUp() {
        super.setUp()
        
        self.setupTodosFirebaseService()
    }
    
    override func tearDown() {
        firebaseService = nil
        
        super.tearDown()
    }
    
    func setupTodosFirebaseService(){
        firebaseService = FirebaseService()
        
        deleteAllTodosInFirebase()
        
        testTodos = [Seeds.Todos.todo1, Seeds.Todos.todo2]
        
        for todo in testTodos{
            let expect = expectation(description: "Wait for add_todo() to return")
            firebaseService.add_todo(todo: todo, completionHandlers: { (todo, error) in
                expect.fulfill()
            })
            waitForExpectations(timeout: 1.0)
        }
        
        //Fetch todos
        let fetchTodosExpectation = expectation(description: "wait for fetch_todos() to return")
        firebaseService.fetch_all_todos { (todos, error) in
            self.testTodos = todos
            fetchTodosExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    func deleteAllTodosInFirebase(){
        var allTodos = [Todo]()
        let fetchTodosExpectation = expectation(description: "Wait for fetch_all_todos() to return")
        firebaseService.fetch_all_todos { (todos, error) in
            allTodos = todos
            fetchTodosExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        for todo in allTodos{
            let deleteTodoExpectation = expectation(description: "Wait for remove_todo() to return")
            firebaseService.remove_todo(todo: todo, completionHandler: {
                deleteTodoExpectation.fulfill()
            })
            waitForExpectations(timeout: 1.0)
        }
    }
    
    func testFetchTodosShouldReturnListOfTodosOrError(){
        //Given
        
        //When
        var fetchedTodos = [Todo]()
        var fetchedTodosError: TodoListError?
        let expect = expectation(description: "Wait for fetch_all_todos() to return")
        firebaseService.fetch_all_todos { (todos, error) in
            fetchedTodos = todos
            fetchedTodosError = error
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Then
        XCTAssertEqual(fetchedTodos.count, testTodos.count, "fetch_all_todos() should return a list of todos")
        for todo in fetchedTodos{
            XCTAssert(self.testTodos.contains(where: {$0.key == todo.key}), "fetched todos should match the todos in the data store")
        }
        XCTAssertNil(fetchedTodosError, "fetch_all_todos() should not return an error")
    }
    
    func testAddTodoShouldCreateNewTodo_OptionalError(){
        //Given
        let todoToAdd = Seeds.Todos.todo3
        
        //When
        var addedTodo: Todo?
        var addedTodoError: String?
        let addTodoExpectation = expectation(description: "Wait for add_todo() to return")
        firebaseService.add_todo(todo: todoToAdd) { (todo, error) in
            addedTodo = todo
            addedTodoError = error
            addTodoExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Fetch todos
        var allTodos: [Todo]?
        let fetchTodosExpectation = expectation(description: "wait for fetch_todos() to return")
        firebaseService.fetch_all_todos { (todos, error) in
            allTodos = todos
            fetchTodosExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Then
        XCTAssertEqual(todoToAdd, addedTodo, "add_todo() should add a new todo to the list")
        XCTAssertEqual(allTodos?.count, self.testTodos.count + 1, "add_todo() should increase the todo list by one")
        XCTAssertNil(addedTodoError, "add_todo() should not return an error")
    }
    
    func testUpdateTodoShouldUpdateExistingTodo_OptionalError(){
        //Given
        var todoToUpdate = testTodos.first!
        let done = Todo.DoneStatus.done
        todoToUpdate.done = done
        
        //When
        var updatedTodo: Todo?
        var updatedTodoError: String?
        let updateTodoExpectation = expectation(description: "Wait for update_todo() to return")
        firebaseService.update_todo(todo: todoToUpdate) { (todo, error) in
            updatedTodo = todo
            updatedTodoError = error
            updateTodoExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Then
        XCTAssertEqual(todoToUpdate, updatedTodo, "update_todo() should update an existing todo")
        XCTAssertNil(updatedTodoError, "update_todo() should not return and error")
    }
    
    func testDeleteTodoShouldDeleteExistingTodo(){
        //Given
        let todoToRemove = testTodos.first!
        
        //When
        //Remove todo
        let removeTodoExpectation = expectation(description: "Wait for delete_todo() to return")
        firebaseService.remove_todo(todo: todoToRemove) {
            removeTodoExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Fetch todos
        var allTodos: [Todo]?
        let fetchTodosExpectation = expectation(description: "wait for fetch_todos() to return")
        firebaseService.fetch_all_todos { (todos, error) in
            allTodos = todos
            fetchTodosExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        //Then
        XCTAssertEqual(allTodos?.count, 1, "todos count should be 1")
    }
}
