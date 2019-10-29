//
//  ViewController.swift
//  iOS13-Stopwatch
//
//  Created by Piotr Rutkowski on 27/10/2019.
//  Copyright © 2019 Piotr Rutkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    var counter = 0.0 // intialise timer to default value 0
    var timer = Timer()
    var isRunning = false // this boolean is used to check whether the timer is running or not
    let buttonPress = UISelectionFeedbackGenerator() // creating new haptic feedback generator from UIKit
    let minutePassed = UIImpactFeedbackGenerator(style: .light) // haptic feedback generator for passed minutes
    
    
    @objc func timerRun() {
        counter += 0.1
        
//      formatting the time to the HH:MM:SS.S format
        let counterFloor = Int(floor(counter))
        let hours = counterFloor / 3600
        var hoursDisplay = "\(hours)"
        if hours < 10 {
            hoursDisplay = "0\(hours)"
        }
        
        let minutes = (counterFloor % 3600) / 60
        var minutesDisplay = "\(minutes)"
        if minutes < 10 {
            minutesDisplay = "0\(minutes)"
        }
        
        let seconds = (counterFloor % 3600) % 60
        var secondsDisplay = "\(seconds)"
        if seconds < 10 {
            secondsDisplay = "0\(seconds)"
        }
        
//      generating haptic feedback for every minute passed
        if seconds == 0 && minutes >= 1 {
            minutePassed.impactOccurred()
        }
        
        let miliseconds = String(format: "%.1f", counter).components(separatedBy: ".").last!
        timeLabel.text = "\(hoursDisplay):\(minutesDisplay):\(secondsDisplay).\(miliseconds)"
    }
    
//  start button functionality
    @IBAction func startTimer(_ sender: Any) {
        buttonPress.selectionChanged() // haptic feedback upon button press
        startButton.isEnabled = false // if the timer is running, the start button will be grayed out
        stopButton.isEnabled = true // and the pause button will be enabled
        resetButton.isEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
        isRunning = true
    }
    
//  stop button functionality
    @IBAction func stopTimer(_ sender: Any) {
        buttonPress.selectionChanged()
        startButton.isEnabled = true // if the timer is stopped, the start button will be enable as a resume button
        stopButton.isEnabled = false // and the stop button will be grayed out
        resetButton.isEnabled = true
        
        timer.invalidate()  //Apple defined function of class NSTimer that stops the timer at its current value
        isRunning = false
    }
    
//  reset button functionality
    @IBAction func resetTimer(_ sender: Any) {
        buttonPress.selectionChanged()
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
        isRunning = false
        counter = 0.0
        timeLabel.text = "00:00:00.0"
        resetButton.isEnabled = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false // disable the stop button upon launch
        resetButton.isEnabled = false
        
    }
    
    
}

