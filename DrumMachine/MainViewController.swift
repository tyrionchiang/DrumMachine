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
    let metronomeEngine = MetronomeEngine()

    let defaultBPMvalue = 70
    var playSoundTimer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        metronomeEngine.soundEngine = soundEngine
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    

    
    @IBAction func playSoundButtonHasBeenClicked(sender: UIButton) {
        if metronomeEngine.isPlaying(){
            metronomeEngine.stopPlay()
            playSoundButton.setTitle("play", forState: .Normal)
        }else{
            metronomeEngine.startPlay()
            playSoundButton.setTitle("stop", forState: .Normal)
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
                (segue.destinationViewController as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel1":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 1
                (segue.destinationViewController as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel2":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 2
                (segue.destinationViewController as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel3":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 3
                (segue.destinationViewController as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel4":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 4
                (segue.destinationViewController as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel5":
                (segue.destinationViewController as? GrooveNotesViewController)?.channelNumber = 5
                (segue.destinationViewController as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "BPMController":
                (segue.destinationViewController as? BPMViewController)?.metronomeEngine = metronomeEngine
            case "SettingController":
                (segue.destinationViewController as? SettingViewController)?.soundEngine = soundEngine
                (segue.destinationViewController as? SettingViewController)?.metronomeEngine = metronomeEngine

            default:
                break;
            }
        }
        
    }

}

