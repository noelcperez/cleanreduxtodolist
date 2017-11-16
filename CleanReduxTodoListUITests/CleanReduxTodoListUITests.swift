//
//  CleanReduxTodoListUITests.swift
//  CleanReduxTodoListUITests
//
//  Created by Noel C Perez on 11/10/17.
//  Copyright © 2017 Noel C Perez. All rights reserved.
//

@testable import CleanReduxTodoList
import XCTest
import UIKit

class CleanReduxTodoListUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTapOnAddTodoButtonNavigateToAddTodoScreen(){
        //Given
        let app = XCUIApplication()
        app.navigationBars["Todo List"].buttons["Add"].tap()
        
        let titleTextField = app.textFields["titleTextField"]
        
        //Then
        XCTAssertTrue(titleTextField.exists, "Title text field should exist")
    }
    
}
