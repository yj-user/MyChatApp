//
//  WelcomeViewController.swift
//  MyChatApp
//
//  Created by youngjun kim on 2021/04/07.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var myChatTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myChatTitle.text = ""
        
        let title = "My Chat"
        var timeInterval = 0.5
        
        for txt in title {
            Timer.scheduledTimer(withTimeInterval: 0.05 * timeInterval , repeats: false) { (timer) in
                self.myChatTitle.text?.append(txt)
            }
            timeInterval += 1.0
        }
        
        
    }
    
  
    
}
