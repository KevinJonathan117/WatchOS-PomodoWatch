//
//  InterfaceController.swift
//  PomodoWatch WatchKit Extension
//
//  Created by Kevin Jonathan on 13/08/21.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    var sessionName: String = ""
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    @IBAction func sessionInput(_ value: NSString?) {
        if value != nil {
            sessionName = value! as String
        }
    }
    @IBAction func doneButton() {
        pushController(withName: "timerPomodoro", context: sessionName)
    }
}
