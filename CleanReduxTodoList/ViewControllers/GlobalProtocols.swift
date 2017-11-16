//
//  GlobalProtocols.swift
//  CleanReduxTodoList
//
//  Created by Noel Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

import UIKit

//----Interactor global protocols
protocol Listener {
    func listen()
    func stop_listening()
}

//---View Models global protocols
protocol PresentsError {
    func present_error(error: String)
}

//----View Controllers global protocols
protocol DisplaysError {
    func display_error(error: String)
}

extension DisplaysError where Self: UIViewController{
    func display_error(error: String){
        let settingsActionSheet: UIAlertController = UIAlertController(title:"Error", message:error, preferredStyle:UIAlertControllerStyle.alert)
        settingsActionSheet.addAction(UIAlertAction(title:"OK", style:UIAlertActionStyle.cancel, handler:nil))
        present(settingsActionSheet, animated:true, completion:nil)
    }
}
