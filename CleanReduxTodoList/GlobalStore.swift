//
//  GlobalStore.swift
//  CleanReduxStore
//
//  Created by Noel Perez on 11/3/17.
//  Copyright © 2017 Combustion Group. All rights reserved.
//

import UIKit
import ReSwift

struct GlobalStore {
    static let store = Store<TodoListState>(reducer: appReducer, state: nil)
}
