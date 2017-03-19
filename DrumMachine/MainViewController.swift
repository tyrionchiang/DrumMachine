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
    var playSoundTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        metronomeEngine.soundEngine = soundEngine
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    

    
    @IBAction func playSoundButtonHasBeenClicked(_ sender: UIButton) {
        if metronomeEngine.isPlaying(){
            metronomeEngine.stopPlay()
            playSoundButton.setTitle("play", for: UIControlState())
        }else{
            metronomeEngine.startPlay()
            playSoundButton.setTitle("stop", for: UIControlState())
        }
        
    }
    
    

    
    @IBAction func unwindForMainSegue(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //print("segue:\(segue.identifier!)")
        
        if let identifier = segue.identifier{
            switch identifier {
            case "notesChannel0":
                (segue.destination as? GrooveNotesViewController)?.channelNumber = 0
                (segue.destination as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel1":
                (segue.destination as? GrooveNotesViewController)?.channelNumber = 1
                (segue.destination as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel2":
                (segue.destination as? GrooveNotesViewController)?.channelNumber = 2
                (segue.destination as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel3":
                (segue.destination as? GrooveNotesViewController)?.channelNumber = 3
                (segue.destination as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel4":
                (segue.destination as? GrooveNotesViewController)?.channelNumber = 4
                (segue.destination as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "notesChannel5":
                (segue.destination as? GrooveNotesViewController)?.channelNumber = 5
                (segue.destination as? GrooveNotesViewController)?.metronomEngine = metronomeEngine
            case "BPMController":
                (segue.destination as? BPMViewController)?.metronomeEngine = metronomeEngine
            case "SettingController":
                (segue.destination as? SettingViewController)?.soundEngine = soundEngine
                (segue.destination as? SettingViewController)?.metronomeEngine = metronomeEngine

            default:
                break;
            }
        }
        
    }

}

