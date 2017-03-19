//
//  SettingViewController.swift
//  DrumMachine
//
//  Created by Chiang Chuan on 2016/6/14.
//  Copyright © 2016年 Chiang Chuan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    var soundEngine : SoundEngine?
    var metronomeEngine : MetronomeEngine?

    @IBOutlet var volumeSlider: [UISlider]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        syncVolumeSliderSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if stopPlayByRecording{
            metronomeEngine?.startPlay()
            stopPlayByRecording = false
        }
    }
   
    
    func syncVolumeSliderSet(){
        if let engine = soundEngine{
            for slider in volumeSlider{
                slider.value = engine.channelVolumes[slider.tag]
            }
        }
    }
    
    
    @IBAction func volumeSliderHasBeenChanged(_ sender: UISlider) {
        if let engine = soundEngine{
            engine.channelVolumes[sender.tag] = sender.value
            soundEngine?.channelVolumes = engine.channelVolumes
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    @IBAction func unwindForSettingSegue(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    var stopPlayByRecording: Bool = false
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier {
            case "recordingController0":
                (segue.destination as? RecordingViewController)?.channelNumber = 4
                (segue.destination as? RecordingViewController)?.soundEngine = soundEngine
                if let engine = metronomeEngine{
                    if engine.isPlaying(){
                        metronomeEngine?.stopPlay()
                        stopPlayByRecording = true
                    }
                }
            case "recordingController1":
                (segue.destination as? RecordingViewController)?.channelNumber = 5
                (segue.destination as? RecordingViewController)?.soundEngine = soundEngine
                if let engine = metronomeEngine{
                    if engine.isPlaying(){
                        metronomeEngine?.stopPlay()
                        stopPlayByRecording = true
                    }
                }
            default:
                break;
            }
        }
     }
 
   
}
