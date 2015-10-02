//
//  ViewController.swift
//  testAnimation
//
//  Created by Richard Fox on 9/3/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

import UIKit
import Motivate

var str = "Hello, playground"





class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    var animation:TimedPairWrapper?
    
    @IBAction func playPressed(sender: AnyObject) {
        animation?.run()
    }
    
    
    @IBAction func reversePressed(sender: AnyObject) {
        animation?.runReverse()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func animationChain(){
        
         animation =
            Motivate(
                time: 3.0,
                button1.rotateBy(50),
                button1.byX(-20),
                button2.byX(-20)
            )
            <> Motivate(
                time: 1.0,
                button1.byX(-30),
                button2.byX(-30)
            )
            <> Motivate(
                time: 1.0,
                imageView1.byAlpha(-0.5),
                button1.backColorChange(from: UIColor.redColor(), to: UIColor.blueColor()),
//                imageView1.imageChange(from: "dog1", to: "dog2"),
                imageView1.rotateBy(90),
                imageView1.byWidth(100),
                imageView1.byHeight(100)
            )
            <> Motivate(
                time: 2.5,
//                button1.byX( 0),
                button2.byX( 0),
                button3.byX( -100),
                button3.byY( -50)
            )
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animationChain()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

