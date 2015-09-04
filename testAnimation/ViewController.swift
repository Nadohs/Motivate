//
//  ViewController.swift
//  testAnimation
//
//  Created by Richard Fox on 9/3/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

import UIKit



func animateTime(){
    AniRun(
          ANI(1.0){
                print("1\n")
            }
      /> ANI(2.0){
                print("2\n")
            }
      /> ANI(3.0){
                print("3\n")
            }
    )
}




func longFormAnimation(){
    UIView.animateWithDuration(1.0, animations: { print("1") }, completion: { _ in
        
        UIView.animateWithDuration(1.0, animations: { print("2") }, completion: { _ in
            
            UIView.animateWithDuration(1.0, animations: { print("3") }, completion: nil)
            })
        })
}



class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        animateTime()
        
        AniRun(
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
        )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

