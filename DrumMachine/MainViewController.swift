//
//  MainViewController.swift
//  DrumMachine
//
//  Created by Chiang Chuan on 2016/6/13.
//  Copyright © 2016年 Chiang Chuan. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController{

    @IBOutlet weak var playSoundButton: UIButton!
    
    //create soundEngine
    let soundEngine = SoundEngine()
    let defaultBPMvalue = 70
    var playSoundTimer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    func playSound() {
        
        //play sound
        if let player = soundEngine.snarePlayer{
            player.currentTime = 0.0
            player.play()
        }
    }
    
    @IBAction func playSoundButtonHasBeenClicked(sender: UIButton) {
        if let timer = playSoundTimer{
            //stop
            timer.invalidate()
            playSoundTimer = nil
            playSoundButton.setTitle("Play", forState: .Normal)
        }else{
            //play
            
            let BPMvalue = NSUserDefaults.standardUserDefaults().objectForKey("BPMvalue") as? Int ?? defaultBPMvalue
            let timeInterval = 60.0 / Double(BPMvalue) * (4/16)
            print(timeInterval)
            playSoundTimer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(MainViewController.playSound), userInfo: nil, repeats: true)
            playSoundButton.setTitle("Stop", forState: .Normal)
        }
    }
    
    

    
    @IBAction func unwindForMainSegue(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //print("segue:\(segue.identifier!)")
        
        if let identifier = segue.identifier{
            switch identifier {
            case "notesChannel0":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 0
            case "notesChannel1":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 1
            case "notesChannel2":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 2
            case "notesChannel3":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 3
            case "notesChannel4":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 4
            case "notesChannel5":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 5
                
            default:
                break;
            }
        }
        
    }

}

