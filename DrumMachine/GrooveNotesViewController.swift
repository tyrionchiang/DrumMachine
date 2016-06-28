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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("channelNumber:\(channelNumber)")
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //print("GrooveNotesViewController")
        
    }
    

}
