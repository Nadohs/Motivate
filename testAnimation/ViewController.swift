//
//  ViewController.swift
//  testAnimation
//
//  Created by Richard Fox on 9/3/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

import UIKit


prefix operator /+/ {
//associativity left
//precedence 140
}

infix operator /-/ {
associativity left
precedence 140
}


typealias EmptyFunc =  Void -> Void

typealias FuncVoid  = (EmptyFunc) -> (Void)

typealias CompFunc  =  FuncVoid -> FuncVoid


prefix func /+/ ( rhs:EmptyFunc) {
    rhs()
}

func /-/ (@autoclosure(escaping) lhs:EmptyFunc, @autoclosure(escaping) rhs:EmptyFunc) ->  (Double) -> EmptyFunc{
    
    
//    let lhss = lhs
    return { x in {
            UIView.animateWithDuration(x, animations: {
                lhs()
            }){ _ in
                rhs()
            }
        }
    }
}
//
//func animateCompletion()




func animateTime(){
    let x =  (print("1\n")  /-/  print("2\n")) (5.5)// /-/  print("3\n") (5.5)
        x()
}




func longformanimation(){
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

