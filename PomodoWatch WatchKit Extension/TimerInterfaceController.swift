//
//  InterfaceController.swift
//  PomodoWatch WatchKit Extension
//
//  Created by Kevin Jonathan on 13/08/21.
//

import WatchKit
import Foundation


class TimerInterfaceController: WKInterfaceController {
    @IBOutlet var myTimer: WKInterfaceTimer!
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        myTimer.setDate(Date())
        myTimer.start()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
}
