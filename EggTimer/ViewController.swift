//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes: [String:Int] = [
        "Soft": 5,
        "Medium": 8,
        "Hard": 12
    ]
    @IBOutlet weak var titleLabel: UILabel!
    
    var timer = Timer()
    var totalTime: Int = 0
    var secondsPassed: Int = 0
    var audio: AVAudioPlayer?
    var url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        secondsPassed = 0
        progressBar.progress = 0
        
        guard let hardness = sender.currentTitle else { return }
        
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        progressBar.setProgress(Float(secondsPassed) / Float(totalTime), animated: true)
        if secondsPassed < totalTime {
            secondsPassed += 1
        } else if secondsPassed == totalTime {
            audio = try! AVAudioPlayer(contentsOf: url!)
            audio?.play()
            timer.invalidate()
            titleLabel.text = "DONE!"
        }
    }
}
