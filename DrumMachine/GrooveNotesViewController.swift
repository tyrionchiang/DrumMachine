//
//  GrooveNotesViewController.swift
//  DrumMachine
//
//  Created by Chiang Chuan on 2016/6/14.
//  Copyright © 2016年 Chiang Chuan. All rights reserved.
//

import UIKit

class GrooveNotesViewController: UIViewController {

    
    var channelNumber: Int = 0
    
    //======================================
    //TODO : notes has to be replaced by notes in metronome engine
    var notes : [Bool]? = [true,false,false,false,
                          false,false,false,false,
                          true,false,false,false,
                          false,false,false,false,
                          ]
    //======================================
    
    @IBOutlet weak var noteButtonsContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("channelNumber:\(channelNumber)")
        
        if let currentNotes = notes{
            for view in noteButtonsContainerView.subviews{
                if let button = (view as? UIButton){
                    if currentNotes[button.tag]{
                        button.setBackgroundImage(UIImage(named: "cyan_circle"), forState: .Normal)
                    }else{
                        button.setBackgroundImage(UIImage(named: "pink_circle"), forState: .Normal)
                    }
                }
            }
        }
        
    }

 

    @IBAction func noteButtonHasBeenClicked(sender: UIButton) {
        if let currentNotes = notes{
            //let clicked =
            notes![sender.tag] = !currentNotes[sender.tag]
            if notes![sender.tag]{
                sender.setBackgroundImage(UIImage(named: "cyan_circle"), forState: .Normal)
            }else{
                sender.setBackgroundImage(UIImage(named: "pink_circle"), forState: .Normal)
            }
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //print("GrooveNotesViewController")
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

}
