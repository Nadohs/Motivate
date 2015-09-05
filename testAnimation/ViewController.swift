//
//  ViewController.swift
//  testAnimation
//
//  Created by Richard Fox on 9/3/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        AniRun(
            ANI(3.0){
                    self.button1.frame.origin.x += 100
                }
            /> ANI(0){
                    self.button2.frame.origin.x += 100
                }
            /> ANI(5.5){
                    self.button3.frame.origin.x += 100
            }
            /> ANI(3.0){
                self.button1.frame.origin.x -= 100
            }
            /> ANI(5.5){
                self.button2.frame.origin.x -= 100
            }
            /> ANI(5.5){
                self.button3.frame.origin.x -= 100
            }
//        )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

