//
//  MetronomeEngine.swift
//  DrumMachine
//
//  Created by Chiang Chuan on 6/28/16.
//  Copyright © 2016 Chiang Chuan. All rights reserved.
//

import UIKit

class MetronomeEngine: NSObject {
    
    
    var soundEngine: SoundEngine?
    private var playSoundTimer: NSTimer?
    private var _BPMValue = 70
    private let maxBPMvalue = 250
    private let minBPNvalue = 30
    
    var bassDrumPoints:[Bool] = [true,false,false,false,
                              false,false,false,false,
                              true,false,false,false,
                              false,false,false,false,
                              ]
    
    var snarePoints:[Bool] = [false,false,false,false,
                              true,false,false,false,
                              false,false,false,false,
                              true,false,false,false,
                              ]
    
    var hihatsPoints:[Bool] = [true,false,true,false,
                               true,false,true,false,
                               true,false,true,false,
                               true,false,true,false,
                               ]
    
    var BPMValue: Int{
        set{
            _BPMValue = min(max(newValue, minBPNvalue),maxBPMvalue)
            NSUserDefaults.standardUserDefaults().setObject(_BPMValue, forKey: "BPMValue")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            if isPlaying(){
                stopPlay()
                startPlay()
            }
        }
        get{
            return _BPMValue
        }
    }
    
    
    override init(){
        super.init()
        //do something
    
        
        BPMValue = NSUserDefaults.standardUserDefaults().objectForKey("BPMValue") as? Int ?? _BPMValue

    }
    
    var counter = 0
    func startPlay(){
        if isPlaying(){
            stopPlay()
        }else{
            let timeInterval = 60.0 / Double(BPMValue) / 4.0
            
            playSoundTimer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(MetronomeEngine.playSound), userInfo: nil, repeats: true)
        }
    }
    func stopPlay(){
        if let timer = playSoundTimer{
            timer.invalidate()
            playSoundTimer = nil
        }
        counter = 0
    }
    
    func isPlaying() -> Bool {
        return playSoundTimer != nil
    }
    
    func playSound() {
        if let player = soundEngine?.hiHatsPlayer{
            if hihatsPoints[counter]{
                player.currentTime = 0
                player.play()
            }
        }
        if let player = soundEngine?.bassDrumPlayer{
            if bassDrumPoints[counter]{
                player.currentTime = 0
                player.play()
            }
        }
        if let player = soundEngine?.snarePlayer{
            if snarePoints[counter]{
                player.currentTime = 0
                player.play()
            }
        }
        
        counter++
        
        if counter >= snarePoints.count{
            counter = 0
        }
    }

}
