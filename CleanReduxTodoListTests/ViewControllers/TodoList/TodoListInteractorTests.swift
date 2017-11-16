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
        var presentErrorTryingToFetchTodoListCalled = false
        
        func present_fetch_todo_list(response: ListTodos.FetchTodos.Response) {
            presentFetchedTodoListCalled = true
        }
        
        func present_error(error: String) {
            presentErrorTryingToFetchTodoListCalled = true
        }
        
    }
    
    class TodoListWorkerSpy: TodoListWorker{
        
        var withError = false
        
        var fetchTodosCalled = false
        var fetchTodosWithErrorCalled = false
        var deleteTodoCalled = false
        
        override func fetch_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void) {
            if withError{
                fetchTodosWithErrorCalled = true
                completionHandler([], TodoListError.somethingHappened(error: "Error"))
            }
            else{
                fetchTodosCalled = true
                completionHandler([Seeds.Todos.todo1, Seeds.Todos.todo2], nil)
            }
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
    
    func testFetchTodosWithErrorsShouldAskTodoListWorkerToFetchTodosAndPresenterToPresentError(){
        //Given
        let todoListPresentationLogicSpy = TodoListPresentationLogicSpy()
        todoListInteractor.view_model = todoListPresentationLogicSpy
        let todoListWorker = TodoListWorkerSpy(todoListServiceProtocol: FirebaseService())
        todoListWorker.withError = true
        todoListInteractor.todo_list_worker = todoListWorker
        
        //When
        let request = ListTodos.FetchTodos.Request()
        todoListInteractor.fetch_todos(request: request)
        
        //Then
        XCTAssertTrue(todoListWorker.fetchTodosWithErrorCalled, "fetch_todos() should ask todoListWorker to try to fetch todos and return an error")
        XCTAssertTrue(todoListPresentationLogicSpy.presentErrorTryingToFetchTodoListCalled, "fetch_todos() should ask presenter to present an error")
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
