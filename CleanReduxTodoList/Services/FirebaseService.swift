//
//  FirebaseService.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit
import Firebase

public class FirebaseService: TodoListServiceProtocol, TodoListListenerProtocol, TodoListenerProtocol {
    
    fileprivate lazy var todosDatabaseReference = Database.database().reference().child("todos")
    
    //MARK: TodoListServiceProtocol implementation
    func fetch_all_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void) {
        self.todosDatabaseReference.observeSingleEvent(of: .value, with: { (dataSnapshot) in
            completionHandler(self.process_todos(dataSnapshot: dataSnapshot), nil)
        })
    }
    
    func add_todo(todo: Todo, completionHandlers: @escaping (Todo?, String?) -> Void) {
        do {
            let dict = try self.encode(todo: todo)
            self.todosDatabaseReference.childByAutoId().setValue(dict)
            completionHandlers(todo, nil)
        }
        catch let error {
            completionHandlers(nil, error.localizedDescription)
        }
    }
    
    func update_todo(todo: Todo, completionHandlers: @escaping (Todo?, String?) -> ()) {
        do {
            let dict = try self.encode(todo: todo)
            self.todosDatabaseReference.child(todo.key).setValue(dict)
            completionHandlers(todo, nil)
        }
        catch let error {
            completionHandlers(nil, error.localizedDescription)
        }
    }
    
    func remove_todo(todo: Todo, completionHandler: @escaping () -> ()) {
        self.todosDatabaseReference.child(todo.key).removeValue()
        completionHandler()
    }
    
    //MARK: TodoListListenerProtocol implementation
    func listen_to_todos(completionHandler: @escaping ([Todo]) -> Void) {
        self.todosDatabaseReference.observe(.value, with: { (dataSnapshot) in
            completionHandler(self.process_todos(dataSnapshot: dataSnapshot))
        })
    }
    
    func stop_listening_todos() {
        self.todosDatabaseReference.removeAllObservers()
    }
    
    
    //MARK: TodoListenerProtocol implementation
    func listen_to_todo(todo: Todo, completionHandler: @escaping (Todo) -> Void) {
        self.todosDatabaseReference.child(todo.key).observe(.value, with: { (dataSnapshot) in
            if dataSnapshot.hasChildren(), let todo_dict = dataSnapshot.value as? NSDictionary{
                completionHandler(self.decode(todo_dictionary: todo_dict, todo_key: dataSnapshot.key))
            }
        })
    }
    
    func stop_listening_todo() {
        self.stop_listening_todos()
    }
    
    //MARK: Utility functions
    fileprivate func encode(todo: Todo) throws -> Any{
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(todo)
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
    
    fileprivate func process_todos(dataSnapshot: DataSnapshot) -> [Todo]{
        var todos = [Todo]()
        
        if dataSnapshot.hasChildren(), let todos_dict = dataSnapshot.value as? NSDictionary, let todos_keys = todos_dict.allKeys as? [String]{
            for todo_key in todos_keys{
                if let todo_dictionary = todos_dict[todo_key] as? NSMutableDictionary{
                    todos.append(self.decode(todo_dictionary: todo_dictionary, todo_key: todo_key))
                }
            }
        }
        
        return todos
    }
    
    fileprivate func decode(todo_dictionary: NSDictionary, todo_key: String) -> Todo{
        var todo_to_return: Todo!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do{
            let data = try JSONSerialization.data(withJSONObject: todo_dictionary, options: [])
            todo_to_return = try decoder.decode(Todo.self, from: data)
            todo_to_return.key = todo_key
        }
        catch{ }
        
        return todo_to_return
    }
    
}
