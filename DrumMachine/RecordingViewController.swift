//
//  RecordingViewController.swift
//  DrumMachine
//
//  Created by Chiang Chuan on 2016/6/14.
//  Copyright © 2016年 Chiang Chuan. All rights reserved.
//

import UIKit

class RecordingViewController: UIViewController {

    
    @IBOutlet weak var recordingButton: UIButton!    
    @IBOutlet weak var lodingIndicator: UIActivityIndicatorView!
    var soundEngine: SoundEngine?
    var channelNumber: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lodingIndicator.isHidden = true
        lodingIndicator.startAnimating()
        
        soundEngine?.initializeRecorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        soundEngine?.reloadSound()
    }
    

    var isRecording = false
    @IBAction func recordingButtonHasBeenClicked(_ sender: UIButton) {
        isRecording = !isRecording
        if isRecording{
            //TODO: Start recording
            soundEngine?.startRecord(channelNumber)
            
            sender.setImage(UIImage(named: "stop"), for: UIControlState())
            lodingIndicator.isHidden = false
        }else{
            soundEngine?.finishRecording(success: true)
            
            sender.setImage(UIImage(named: "play"), for: UIControlState())
            lodingIndicator.isHidden = true
        }
    }
   
    override var prefersStatusBarHidden : Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
