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


// @autoclosure(escaping) 

func ANI (t:Double, e: EmptyFunc) -> TimedPair{
    return (t, e)
}

func AniRun (x:TimedPair){
    x.1()
//    UIView.animateWithDuration(x.0, animations: x.1)
}


func /> ( lhs:TimedPair, rhs:TimedPair) ->  TimedPair{
    
    return
        ( -1.0, {
                UIView.animateWithDuration(lhs.0, animations: {
                    print("time\(lhs.0)\n")
                        lhs.1()
                    }){ _ in
                        
                        if rhs.0 == -1.0{
                            rhs.1()
                            return
                        }
                        
                        UIView.animateWithDuration(rhs.0) {
                            print("time B \(rhs.0)\n")
                            rhs.1()
                        }
                    }
             }
        )
}



