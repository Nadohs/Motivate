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
          ANI(1.5){
                print("1\n")
            }
      /> ANI(2.5){
                print("2\n")
            }
      /> ANI(3.5){
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

    override func viewDidLoad() {
        super.viewDidLoad()
        animateTime()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

