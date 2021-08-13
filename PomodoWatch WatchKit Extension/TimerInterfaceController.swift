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
    var isBreak: Bool = false
    var timer = Timer()
    var backgroundTimer = 15
    var session = ""
    var breakName = "Break"
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        session = (context as? String)!
        sessionName.setText(session)
    }
    
    override func willActivate() {
        if(!isBreak) {
            myTimer.setDate(Date() + TimeInterval(backgroundTimer))
        }
        myTimer.start()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
    }
    
    func restartTimer() {
        if(!isBreak) {
            sessionName.setText(session)
            backgroundTimer = 15
            myTimer.setDate(Date() + TimeInterval(backgroundTimer))
        } else {
            sessionName.setText(breakName)
            backgroundTimer = 3
            myTimer.setDate(Date() + TimeInterval(backgroundTimer))
        }
        myTimer.start()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
    }
    
    override func didDeactivate() {
        timer.invalidate()
        myTimer.stop()
    }
    
    @objc func timerCountDown() {
        backgroundTimer -= 1
        if backgroundTimer == 0 {
            timer.invalidate()
            myTimer.stop()
            isBreak.toggle()
            restartTimer()
        }

    }
}
