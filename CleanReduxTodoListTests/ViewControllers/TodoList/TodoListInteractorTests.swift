//
//  TodoListInteractorTests.swift
//  CleanReduxTodoListTests
//
//  Created by Noel Perez on 11/15/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

@testable import CleanReduxTodoList
import XCTest
import UIKit

class TodoListInteractorTests: XCTestCase {
    
    var todoListInteractor: TodoListInteractor!
    
    override func setUp() {
        super.setUp()
        
        todoListInteractor = TodoListInteractor()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    class TodoListPresentationLogicSpy: ListTodosPresentationLogic{
        
        var presentFetchedTodoListCalled = false
        
        func present_fetch_todo_list(response: ListTodos.FetchTodos.Response) {
            presentFetchedTodoListCalled = true
        }
    }
    
    class TodoListWorkerSpy: TodoListWorker{
        
        var fetchTodosCalled = false
        var deleteTodoCalled = false
        
        override func fetch_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void) {
            fetchTodosCalled = true
            
            completionHandler([Seeds.Todos.todo1, Seeds.Todos.todo2], nil)
        }
        
        override func remove_todo(todo: Todo, completionHandler: @escaping () -> ()) {
            deleteTodoCalled = true
            
            completionHandler()
        }
    }
    
    func testFetchTodosShouldAskTodoListWorkerToFetchTodosAndPresenterToFormatResults(){
        //Given
        let todoListPresentationLogicSpy = TodoListPresentationLogicSpy()
        todoListInteractor.view_model = todoListPresentationLogicSpy
        let todoListWorker = TodoListWorkerSpy(todoListServiceProtocol: FirebaseService())
        todoListInteractor.todo_list_worker = todoListWorker
        
        //When
        let request = ListTodos.FetchTodos.Request()
        todoListInteractor.fetch_todos(request: request)
        
        //Then
        XCTAssertTrue(todoListWorker.fetchTodosCalled, "fetch_todos() should ask todoListWorker to fetch todos")
        XCTAssertTrue(todoListPresentationLogicSpy.presentFetchedTodoListCalled, "fetch_todos() should ask presenter to format fetched todos")
    }
    
    func testRemoveTodoShouldAskTodoListWorkerToDeleteTodoAndPresenterToFormatResults(){
        //Given
        let todoListPresentationLogicSpy = TodoListPresentationLogicSpy()
        todoListInteractor.view_model = todoListPresentationLogicSpy
        let todoListWorker = TodoListWorkerSpy(todoListServiceProtocol: FirebaseService())
        todoListInteractor.todo_list_worker = todoListWorker
        
        //When
        let request = CreateTodo.Delete.Request(todo_from_fields: CreateTodo.TodoFromFields(title: "Test", done: .done, key: "Test"))
        todoListInteractor.remove_todo(request: request)
        
        //Then
        XCTAssertTrue(todoListWorker.deleteTodoCalled, "remove_todo() should ask the interactor to call the worker to remove the todo")
        XCTAssertTrue(todoListPresentationLogicSpy.presentFetchedTodoListCalled, "remove_todo() should ask the presenter to format the new todo list")
    }
}
