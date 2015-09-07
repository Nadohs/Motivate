//
//  AnimationChainer.swift
//  testAnimation
//
//  Created by Richard Fox on 9/3/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

import UIKit




typealias EmptyFunc =  Void -> Void
typealias TimedPair = (time:Double, delay:Double, block:EmptyFunc)




/// Create `TimedPair` from duration `t` and function `e`


    func Motivate(time t:Double, delay d:Double = 0.0, e: EmptyFunc) -> TimedPairWrapper{
        return TimedPairWrapper(tp: (t, d, e ))
    }


/// Run animation on `TimedPair`



class TimedPairWrapper {
    
    private func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    
    var unwrapFinished = false
    
    var shouldLoop = false
    
    var totalTime:Double = 0
    
    var _unwrap:TimedPair
    var  unwrap:TimedPair{
        get{
            unwrapFinished = true
            return _unwrap
        }
        set{
            _unwrap = newValue
        }
    }
    
    func calculateTime(){
        let left = self.unwrap
        if left.time != -1{
            totalTime += left.time + left.delay
        }
    }
    
    func chainAnimate(next:EmptyFunc = {} ) -> EmptyFunc{
        
        let left = self.unwrap
        

        
        return {
            
            UIView.animateWithDuration(
                     left.time,
                     delay: left.delay,
                   options: UIViewAnimationOptions.TransitionNone,
                animations:
                
                    { left.block() })
                    { _ in next()  }
        }
    }
    
    
    init(tp:TimedPair){
        _unwrap = tp
    }
    
    /// call `runLoop()` to repeat the animation continuously.
    
    func runLoop(){
        shouldLoop = true
        loop()
    }
    
    
    private func loop(){
        unwrap.block()
        
        if !shouldLoop{
            return
        }
        
        delay(totalTime){
            self.loop()
        }
    }
    
    
    deinit{
        if !unwrapFinished{
            unwrap.block()
        }
    }
    
    //    chain() DOESNT WORK BECAUSE REQUIRES RIGHT ASSOCIATIVITY
    
    //    func chain(time t:Double, delay d:Double = 0.0, e: EmptyFunc) -> TimedPairWrapper{
    //        return (self <> TimedPairWrapper(tp: (t, d, e )))
    //    }
}


/// Chain together `TimedPair`s and return one `TimedPair`

infix operator <> {
    associativity right
    precedence 140
}


func <> ( lhs:TimedPairWrapper, rhs:TimedPairWrapper) ->  TimedPairWrapper{
    
    lhs.calculateTime()
    rhs.calculateTime()
    
    let pair = TimedPairWrapper(tp :( -1.0, 0.0, {
            
            lhs.chainAnimate({
                if rhs.unwrap.time == -1.0{
                   rhs.unwrap.block()
                }else{
                   rhs.chainAnimate()()
                }
            })()
    }))
    
    pair.totalTime = lhs.totalTime + rhs.totalTime
    
    return pair
}



