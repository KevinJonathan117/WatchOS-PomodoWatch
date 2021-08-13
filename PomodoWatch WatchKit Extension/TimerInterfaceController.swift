//
//  InterfaceController.swift
//  PomodoWatch WatchKit Extension
//
//  Created by Kevin Jonathan on 13/08/21.
//

import WatchKit
import Foundation


class TimerInterfaceController: WKInterfaceController {
    @IBOutlet var sessionName: WKInterfaceLabel!
    @IBOutlet var myTimer: WKInterfaceTimer!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        sessionName.setText(context as? String)
    }
    
    override func willActivate() {
        myTimer.setDate(Date())
        myTimer.start()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
}
