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
    fileprivate var playSoundTimer: Timer?
    
    
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
            UserDefaults.standard.set(notePointsChannels, forKey: "notePointsChannels")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    fileprivate let maxBPMvalue = 250
    fileprivate let minBPNvalue = 30
    fileprivate var _BPMValue = 70
    
    var BPMValue: Int{
        set{
            _BPMValue = min(max(newValue, minBPNvalue),maxBPMvalue)
            UserDefaults.standard.set(_BPMValue, forKey: "BPMValue")
            UserDefaults.standard.synchronize()
            
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
    
        
        BPMValue = UserDefaults.standard.object(forKey: "BPMValue") as? Int ?? _BPMValue
        
        if let object = UserDefaults.standard.object(forKey: "notePointsChannels") as? [[Bool]]{
             notePointsChannels = object
        }
        
       


    }
    
    var counter = 0
    func startPlay(){
        if isPlaying(){
            stopPlay()
        }else{
            let timeInterval = 60.0 / Double(BPMValue) / 4.0
            
            playSoundTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(playSound), userInfo: nil, repeats: true)
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
    
    @objc fileprivate func playSound() {
        for index in 0...(notePointsChannels.count - 1){
            if let player = soundEngine?.playerChannels[index]{
                if notePointsChannels[index][counter]{
                    player.currentTime = 0
                    player.play()
                }
            }
        }
        
        
        counter += 1
        
        if counter >= notePointsChannels[0].count{
            counter = 0
        }
    }

}
