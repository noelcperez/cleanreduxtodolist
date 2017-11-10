//
//  GlobalProtocols.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

protocol Listener {
    func listen()
    func stop_listening()
}
