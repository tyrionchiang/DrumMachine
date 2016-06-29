//
//  BPMViewController.swift
//  DrumMachine
//
//  Created by Chiang Chuan on 2016/6/14.
//  Copyright © 2016年 Chiang Chuan. All rights reserved.
//

import UIKit

class BPMViewController: UIViewController {
    
    var metronomeEngine: MetronomeEngine?

    //computed properties
    var BPMvalue: Int{
        set{
            if let engine = metronomeEngine{
                engine.BPMValue = newValue
                BPMvalueLabel.text = String(engine.BPMValue)
            }
        }
        get{
            return metronomeEngine?.BPMValue ?? 0
        }
    
    }
    
    @IBOutlet weak var BPMSubPanelView: UIView!
    @IBOutlet weak var BPMvalueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BPMvalueLabel.text = String(BPMvalue)

    }

   
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func increaseBPM(sender: UIButton) {
        BPMvalue += 1
    }
    
    @IBAction func decreaseBPM(sender: UIButton) {
        BPMvalue -= 1
    }
    
    
    var startedPositionOfPanGesture : CGPoint!
    let sensitivityOfBPM: CGFloat = 20.0
    @IBAction func BPMChangedByPanGestuture(sender: UIPanGestureRecognizer) {
        
        
        if sender.state == UIGestureRecognizerState.Began{
            startedPositionOfPanGesture = sender.translationInView(self.BPMSubPanelView)
        }else{
            let newPosition = sender.translationInView(self.BPMSubPanelView)
            let yDelta = newPosition.y - startedPositionOfPanGesture.y
            
            if abs(yDelta / sensitivityOfBPM) >= 1{
                BPMvalue -= Int(yDelta / sensitivityOfBPM)
                startedPositionOfPanGesture = sender.translationInView(self.BPMSubPanelView)
            }
        }
        
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
