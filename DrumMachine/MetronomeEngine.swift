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
    
    
    var notePointsChannels: [[Bool]] = [
        [false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        ],
        [false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        ],
        [false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        ],
        [false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        ],
        [false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        ],
        [false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        false,false,false,false,
        ],
    ]{
        didSet{
            NSUserDefaults.standardUserDefaults().setObject(notePointsChannels, forKey: "notePointsChannels")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
    private let maxBPMvalue = 250
    private let minBPNvalue = 30
    private var _BPMValue = 70
    
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
        
        if let object = NSUserDefaults.standardUserDefaults().objectForKey("notePointsChannels") as? [[Bool]]{
             notePointsChannels = object
        }
        
       


    }
    
    var counter = 0
    func startPlay(){
        if isPlaying(){
            stopPlay()
        }else{
            let timeInterval = 60.0 / Double(BPMValue) / 4.0
            
            playSoundTimer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(playSound), userInfo: nil, repeats: true)
        }
    }
    func stopPlay(){
        if let timer = playSoundTimer{
            timer.invalidate()
            playSoundTimer = nil
            
            if let engine = soundEngine{
                for player in engine.playerChannels{
                    player?.stop()
                }
            }
        }
        counter = 0
    }
    
    func isPlaying() -> Bool {
        return playSoundTimer != nil
    }
    
    @objc private func playSound() {
        for index in 0...(notePointsChannels.count - 1){
            if let player = soundEngine?.playerChannels[index]{
                if notePointsChannels[index][counter]{
                    player.currentTime = 0
                    player.play()
                }
            }
        }
        
        
        counter++
        
        if counter >= notePointsChannels[0].count{
            counter = 0
        }
    }

}
