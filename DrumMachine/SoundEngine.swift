//
//  SoundEngine.swift
//  DrumMachine
//
//  Created by Chiang Chuan on 2016/6/19.
//  Copyright © 2016年 Chiang Chuan. All rights reserved.
//

import UIKit
import AVFoundation

class SoundEngine: NSObject, AVAudioPlayerDelegate , AVAudioRecorderDelegate {
    
    
    var playerChannels:[AVAudioPlayer?] = []
    var recordingSession : AVAudioSession?
    var audioRecorder: AVAudioRecorder!
    
    var channelsFileInfo:[[String]] = [
        ["HiHatsClose","wav"],
        ["BassDrum","wav"],
        ["Snare","wav"],
        ["HighTom","wav"],
        ["RecordSound0","wav"],
        ["RecordSound1","wav"],
    ]
    
    var channelVolumes: [Float] = [0.2, 1.0, 0.5 ,1.0 , 1.0, 1.0]{
        didSet{
            for index in 0...(playerChannels.count - 1){
                if playerChannels[index]?.volume != channelVolumes[index]{
                    playerChannels[index]?.volume = channelVolumes[index]
                }
            }
            
            NSUserDefaults.standardUserDefaults().setObject(channelVolumes, forKey: "channelVolumes")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    override init(){
        super.init()
        //do someting....
        
        if let volums = NSUserDefaults.standardUserDefaults().objectForKey("channelVolumes") as? [Float]{
            channelVolumes = volums
        }
        
        reloadSound()
        
    }
    
    func reloadSound(){
        
        playerChannels.removeAll()
        
        for index in 0...3{
            playerChannels.append(createAVAudioPlayer(channelsFileInfo[index][0], fileType: channelsFileInfo[index][1], volum: channelVolumes[index]))
        }
        
        let audioURL0 = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]).URLByAppendingPathComponent("\(channelsFileInfo[4][0]).\(channelsFileInfo[4][1])")
        playerChannels.append(createAVAudioPlayer(audioURL0, volume: channelVolumes[4]))
        let audioURL1 = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]).URLByAppendingPathComponent("\(channelsFileInfo[5][0]).\(channelsFileInfo[5][1])")
        playerChannels.append(createAVAudioPlayer(audioURL1, volume: channelVolumes[5]))
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
            print("file not exist: \(fileName)")
        }
        return nil
    }
    
    func createAVAudioPlayer(path: NSURL, volume: Float) -> AVAudioPlayer?{
        if let file = NSData(contentsOfURL: path){
            do{
                let newPlayer = try AVAudioPlayer(data: file)
                newPlayer.volume = volume
                newPlayer.delegate = self
                return newPlayer
            }catch{
                print("music play initialize faild")
            }
        }else{
            print("file not exist")
        }
        return nil
    }
    
    

    func initializeRecorder() {
        recordingSession = AVAudioSession.sharedInstance()
        if let session = recordingSession{
            do{
                try session.setCategory(AVAudioSessionCategoryRecord)
                try session.setActive(true)
                session.requestRecordPermission(){
                    [unowned self] (allowed: Bool) -> Void in dispatch_async(dispatch_get_main_queue()){
                        if allowed{
                            //TODO:
                        }else{
                            //failed to record!
                        }
                    }
                }
            }catch{
                //TODO
                //failed to record!
            }
        }
    }
    
    func startRecord(channelNumber: Int){
        if channelNumber == 4 || channelNumber == 5{
        
            let audioURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]).URLByAppendingPathComponent("\(channelsFileInfo[channelNumber][0]).\(channelsFileInfo[channelNumber][1])")
            let settings = [
                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1 as NSNumber,
                AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
            ]
            do{
                audioRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
            }catch{
                finishRecording(success: false)
            }
        }
    }
    func finishRecording(success success:Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag{
            finishRecording(success: false)
        }
    }
    
   

}
