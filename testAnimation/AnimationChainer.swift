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

func ANI (t:Double, e: EmptyFunc) -> TimedPairWrapper{
    return TimedPairWrapper(tp: (t, e))
}


/// Run animation on `TimedPair`

func AniRun (x:TimedPair){
    x.1()
}

class TimedPairWrapper {
    
    var unwrapFinished = false
    
    var _unwrap:TimedPair
    var unwrap:TimedPair{
        get{
            unwrapFinished = true
            return _unwrap
        }
        set{
            _unwrap = newValue
        }
    }
    
    init(tp:TimedPair){
        _unwrap = tp
    }
    
    deinit{
        if !unwrapFinished{
            unwrap.1()
        }
    }
}

/// Chain together `TimedPair`s and return one `TimedPair`

func /> ( lhs:TimedPairWrapper, rhs:TimedPairWrapper) ->  TimedPairWrapper{
    
    return
        TimedPairWrapper(tp :( -1.0, {
                UIView.animateWithDuration(lhs.unwrap.0, animations: {
                    print("time\(lhs.unwrap.0)\n")
                        lhs.unwrap.1()

                    }){ _ in
                        
                        if rhs.unwrap.0 == -1.0{
                            rhs.unwrap.1()
                            return
                        }
                        
                        UIView.animateWithDuration(rhs.unwrap.0) {
                            print("time B \(rhs.unwrap.0)\n")
                            rhs.unwrap.1()
                        }
                    }
             }
        ))
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


