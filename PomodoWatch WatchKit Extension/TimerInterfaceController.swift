//
//  InterfaceController.swift
//  PomodoWatch WatchKit Extension
//
//  Created by Kevin Jonathan on 13/08/21.
//

import WatchKit
import Foundation
import AVFoundation

class TimerInterfaceController: WKInterfaceController {
    @IBOutlet var sessionName: WKInterfaceLabel!
    @IBOutlet var myTimer: WKInterfaceTimer!
    @IBOutlet weak var pauseLabel: WKInterfaceButton!
    @IBOutlet weak var doneButton: WKInterfaceButton!
    
    var isBreak: Bool = false
    var timer = Timer()
    var backgroundTimer = 5
    var player: AVAudioPlayer!
    var session = ""
    var breakName = "Break"
    var count = 1
    var isPause : Bool = false
    
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
            count += 1
            sessionName.setText(session)
            backgroundTimer = 5
            myTimer.setDate(Date() + TimeInterval(backgroundTimer))
            pauseLabel.setHidden(false)
            doneButton.setHidden(false)
        } else {
            if count != 4{
                sessionName.setText(breakName)
                backgroundTimer = 3
                myTimer.setDate(Date() + TimeInterval(backgroundTimer))
        
            }else {
                sessionName.setText("Longer Break")
                backgroundTimer = 10
                myTimer.setDate(Date() + TimeInterval(backgroundTimer))
                count = 0
            }
            pauseLabel.setHidden(true)
            doneButton.setHidden(true)
            
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
            playSound()
            WKInterfaceDevice().play(.notification)
            restartTimer()
        }
        
        
    }
    @IBAction func doneSession() {
        popToRootController()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "Alert", withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    @IBAction func pauseSession() {
        if !isPause {
            timer.invalidate()
            myTimer.stop()
            isPause.toggle()
            pauseLabel.setTitle("Resume")
        }else {
            myTimer.setDate(Date() + TimeInterval(backgroundTimer))
            myTimer.start()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
            isPause.toggle()
            pauseLabel.setTitle("Pause")
        }
    }
    
}
