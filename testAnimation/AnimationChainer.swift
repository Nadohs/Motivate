//
//  AnimationChainer.swift
//  testAnimation
//
//  Created by Richard Fox on 9/3/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

import UIKit


infix operator /> {
    associativity right
    precedence 140
}

typealias EmptyFunc =  Void -> Void
typealias TimedPair = (Double, EmptyFunc)



/// Create `TimedPair` from duration `t` and function `e`

func ANI (t:Double, e: EmptyFunc) -> TimedPair{
    return (t, e)
}


/// Run animation on `TimedPair`

func AniRun (x:TimedPair){
    x.1()
}


/// Chain together `TimedPair`s and return one `TimedPair`

func /> ( lhs:TimedPair, rhs:TimedPair) ->  TimedPair{
    
    return
        ( -1.0, {
                UIView.animateWithDuration(lhs.0, animations: {
                    //print("time\(lhs.0)\n")
                        lhs.1()
                    }){ _ in
                        
                        if rhs.0 == -1.0{
                            rhs.1()
                            return
                        }
                        
                        UIView.animateWithDuration(rhs.0) {
                          //  print("time B \(rhs.0)\n")
                            rhs.1()
                        }
                    }
             }
        )
}

/* EXAMPLE:


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

*/


