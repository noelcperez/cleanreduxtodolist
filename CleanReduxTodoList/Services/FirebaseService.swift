//
//  FirebaseService.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit
import Firebase

public class FirebaseService: TodoListServiceProtocol, TodoListListenerProtocol {
    
    fileprivate let kTodosTable = "todos"
    
    func add_todo(todo: Todo, completionHandlers: (Todo, String?) -> Void) {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(todo)
        Database.database().reference().child(kTodosTable).childByAutoId().setValue(data)
        completionHandlers(todo, nil)
    }
    
    func fetch_all_todos(completionHandler: @escaping ([Todo], TodoListError?) -> Void) {
        
    }
    
    func listen_to_todos(completionHandler: @escaping ([Todo]) -> Void) {
        Database.database().reference().child(kTodosTable).observeSingleEvent(of: .value, with: { (dataSnapshot) in
            completionHandler(self.process_todos(dataSnapshot: dataSnapshot))
        })
    }
    
    func stop_listening_todos() {
        
    }
    
    fileprivate func process_todos(dataSnapshot: DataSnapshot) -> [Todo]{
        var todos = [Todo]()
        
        if dataSnapshot.hasChildren(), let todos_dict = dataSnapshot.value as? NSDictionary, let todos_keys = todos_dict.allKeys as? [String]{
            for todo_key in todos_keys{
                if let todo_dictionary = todos_dict[todo_key] as? NSMutableDictionary{
                    todo_dictionary.setValue(todo_key, forKey: "key")
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do{
                        let data = try JSONSerialization.data(withJSONObject: todo_dictionary, options: [])
                        let todo = try decoder.decode(Todo.self, from: data)
                        todos.append(todo)
                    }
                    catch{ }
                }
            }
        }
        
        return todos
    }
    
}
