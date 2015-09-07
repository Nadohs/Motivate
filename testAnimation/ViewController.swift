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
    
    

    func animationChain(){
        
       let animation = Motivate(time: 3.0){
                        self.button1.frame.origin.x += 100
                        self.button2.frame.origin.x -= 100
                        self.button1.backgroundColor = UIColor.greenColor()
                        }
                    <> Motivate(time: 1.0, delay:2.0){
                        
                        self.button1.frame.origin.x -= 100
                        self.button2.frame.origin.x += 100
                        self.button1.backgroundColor = UIColor.blueColor()
                    }
                    <> Motivate(time: 2.5){
                        
                        self.button3.frame.origin.x += 100
                        self.button1.backgroundColor = UIColor.orangeColor()
                    }
                    <> Motivate(time: 1.0){
                        
                        self.button1.frame.origin.x -= 100
                        self.button1.backgroundColor = UIColor.redColor()
                    }
                    <> Motivate(time: 2.5){
                        
                        self.button2.frame.origin.x += 100
                        self.button1.backgroundColor = UIColor.blackColor()
                    }
                    <> Motivate(time: 1.5, delay:1.5){
                        
                        self.button3.frame.origin.x -= 100
                        self.button2.frame.origin.x -= 100
                        self.button1.frame.origin.x += 100
                        self.button1.backgroundColor = UIColor.whiteColor()
                    }
        
        animation.runLoop()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animationChain()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

