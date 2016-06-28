//
//  SoundEngine.swift
//  DrumMachine
//
//  Created by Chiang Chuan on 2016/6/19.
//  Copyright © 2016年 Chiang Chuan. All rights reserved.
//

import UIKit
import AVFoundation

class SoundEngine: NSObject, AVAudioPlayerDelegate  {
    var musicPlayer: AVAudioPlayer?
    var bassDrumPlayer: AVAudioPlayer?
    var snarePlayer: AVAudioPlayer?
    var ridePlayer: AVAudioPlayer?
    var hiHatsPlayer: AVAudioPlayer?
    var hiTomPlayer: AVAudioPlayer?
    
    override init(){
        super.init()
        //do someting....
        //==================================
        musicPlayer = createAVAudioPlayer("Radicalo - I will kill you all", fileType: "mp3", volum: 0.05)
        bassDrumPlayer = createAVAudioPlayer("BassDrum", fileType: "wav", volum: 1.0)
        snarePlayer = createAVAudioPlayer("Snare", fileType: "wav", volum: 0.3)
        ridePlayer = createAVAudioPlayer("Ride", fileType: "wav", volum: 0.3)
        hiHatsPlayer = createAVAudioPlayer("HiHatsClose", fileType: "wav", volum: 0.3)
        hiTomPlayer = createAVAudioPlayer("HighTom", fileType: "wav", volum: 0.3)
        //==================================
        
    }
    func createAVAudioPlayer(fileName : String, fileType: String, volum:Float) -> AVAudioPlayer? {
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType){
            if let file = NSFileManager.defaultManager().contentsAtPath(path){
                do{
                    let newPlayer = try AVAudioPlayer(data: file)
                    newPlayer.volume = volum
                    newPlayer.delegate = self
                    return newPlayer
                }catch{
                    print("music play initialize faild")
                }
            }else{
                print("load file failed")
            }
        }else{
            print("file not exist")
        }
        return nil
    }


}
