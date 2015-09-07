//
//  AnimationChainer.swift
//  testAnimation
//
//  Created by Richard Fox on 9/3/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

import UIKit





typealias EmptyFunc =  Void -> Void


typealias PurePair = (Double, Double) -> TimedPair


struct TimedPair {
    
    let time : Double
    let delay: Double
    let block: EmptyFunc
    
    var style  : MotivationStyle = .None
    var reverse: EmptyFunc = {}
    
    var target : Any?
    
    init(_ time:Double, _ delay:Double,_ block:EmptyFunc,reverse:EmptyFunc = {}){
        self.time  = time
        self.delay = delay
        self.block = block
    }
    
    static var Zero:TimedPair {
        get{
            return TimedPair(0,0,{})
        }
    }
    
    func wrap() -> TimedPairWrapper{
        return TimedPairWrapper(tp: self)
    }
}




enum MotivationStyle{
    case None, Frame, Color, Alpha, Corners
}

private func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}




/// Create `TimedPair` from duration `t` and function `e`


    func Motivate(time t:Double, delay d:Double = 0.0, e: EmptyFunc) -> TimedPairWrapper{
        
        return TimedPairWrapper(tp: TimedPair(t, d, e ))
    }

func Motivate(time t:Double, delay d:Double = 0.0, _ e: TimedPair...) -> TimedPairWrapper{
        
        let total = e.reduce(TimedPair.Zero, combine: + )
        
        return TimedPair(t, d, total.block, reverse: total.reverse).wrap()
    }


/// Run animation on `TimedPair`


class TimedPairWrapper {

    
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
    
    var reverse:TimedPair
    
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
        reverse = tp
    }
    
    /// call `runLoop()` to repeat the animation continuously.
    
    func runLoop(){
        shouldLoop = true
        loop()
    }
    
    /// call `run()` to **run** animation once.
    
    func run(){
        unwrap.block()
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
}




infix operator <> {
    associativity right
    precedence 140
}



/// Combine two unwrapped `TimedPair` block & reverse functions, while resetting `time` and `delay`

private func + (lhs:TimedPair, rhs:TimedPair) -> TimedPair{
    let block = {
        lhs.block()
        rhs.block()
    }
    
    let reverse = {
        lhs.reverse()
        rhs.reverse()
    }
    return TimedPair(0,0,block,reverse:reverse)
}


/// Chain together two wrapped `TimedPair`s and return one `TimedPair`


func <> ( lhs:TimedPairWrapper, rhs:TimedPairWrapper) ->  TimedPairWrapper{
    
    lhs.calculateTime()
    rhs.calculateTime()
    
    let pair = TimedPairWrapper(tp : TimedPair(-1.0,0.0, {
            
        lhs.chainAnimate({
            if rhs.unwrap.time == -1.0{
               rhs.unwrap.block()
            }else{
               rhs.chainAnimate()()
            }
        })()
        
    }))
    
    pair.totalTime = lhs.totalTime + rhs.totalTime
    
//    let reverse = TimedPair(0.0,0.0){
//        
//    }
//    
//    pair.reverse = reverse
    
    return pair
}



