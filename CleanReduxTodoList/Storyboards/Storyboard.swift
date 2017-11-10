//
//  Storyboard.swift
//  CleanReduxTodoList
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//
// Generated using SwiftGen,
//by O.Halligon — https://github.com/SwiftGen/SwiftGen


import Foundation
import UIKit

protocol StoryboardType {
    static var storyboardName: String { get }
}

extension StoryboardType {
    static var storyboard: UIStoryboard {
        let name = self.storyboardName
        return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
    }
}

struct SceneType<T: Any> {
    let storyboard: StoryboardType.Type
    let identifier: String
    
    func instantiate() -> T {
        let identifier = self.identifier
        guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
        }
        return controller
    }
}

struct InitialSceneType<T: Any> {
    let storyboard: StoryboardType.Type
    
    func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
            fatalError("ViewController is not of the expected class \(T.self).")
        }
        return controller
    }
}

protocol SegueType: RawRepresentable { }

extension UIViewController {
    func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
        let identifier = segue.rawValue
        performSegue(withIdentifier: identifier, sender: sender)
    }
}

enum StoryboardScene {
    enum Main: StoryboardType {
        static let storyboardName = "Main"
        
        static let initialScene = InitialSceneType<UINavigationController>(storyboard: Main.self)
        
        static let todoListViewController = SceneType<CleanReduxTodoList.TodoListViewController>(storyboard: Main.self, identifier: "TodoListViewController")
    }
}

enum StoryboardSegue {
}

private final class BundleToken {}
