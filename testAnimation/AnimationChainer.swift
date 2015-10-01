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

typealias NestedFunc = (EmptyFunc) -> Void


struct TimedPair {

    
    var time : Double
    let delay: Double
    
    let block  : EmptyFunc
    var reverse: EmptyFunc
    
    var style  : MotivationStyle = .None

    
    var target : Any?
    
    init(_ time:Double, _ delay:Double,_ block:EmptyFunc,reverse:EmptyFunc = {}){
        self.time  = time
        self.delay = delay
        self.block = block
        self.reverse = reverse
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
        
        var total = e.reduce(.Zero, combine: + )
        total.time = t

        let x = TimedPair(t, d, total.block, reverse: total.reverse).wrap()
    return x
    }


/// Run animation on `TimedPair`


class TimedPairWrapper {

    
    private var unwrapFinished = false
    
    private var shouldLoop = false
    
    private var totalTime:Double = 0
    
//    private var animations:[TimedPair] = []
    
    private var _unwrap:TimedPair
    private var  unwrap:TimedPair{
        get{
            unwrapFinished = true
            return _unwrap
        }
        set{
            _unwrap = newValue
        }
    }
    
    private var reverse:TimedPair = .Zero
    
    private func calculateTime(){
        let left = self.unwrap
        if left.time != -1{
            totalTime += left.time + left.delay
        }
    }
    
   private func chainAnimate(next:EmptyFunc = {} ) -> EmptyFunc{
        
        let left = self.unwrap

        return {
            print("def time  = \(left.time) && totalTime = \(self.totalTime) && delay = \(left.delay)")
            
            UIView.animateWithDuration(
                     left.time,
                     delay: left.delay,
                   options: UIViewAnimationOptions.TransitionNone,
                animations:
                
                    { left.block() }) // Animation Block
                    { _ in next()  }  // Completion Block
        }
    }
    
    
    
    ///A3  - B1 - C1 - D2
    ///totalTimeDelay - animate D2 - totalTimeDelay + D2 time - animate C1 - totalDelay + c1 time +
    
    private func revChainAnimate(next:EmptyFunc = {} ) -> EmptyFunc{
        
        let left = self.unwrap

        return {
            print("def time  = \(left.time) && totalTime = \(self.totalTime) && delay = \(left.delay)")
            print("rev time = \(self.reverse.time)")
            if left.time == -1{
                left.reverse()
                delay(self.totalTime){
                    next()
                }
            }else{
                UIView.animateWithDuration(left.time,
                    delay: left.delay,
                    options: UIViewAnimationOptions.TransitionNone,
                    animations: left.reverse,
                    completion: {_ in next()})
            }

            

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
    
    /// call `run()` to **run** animation once.
    
    func run(){
        unwrap.block()
    }
    
    func runReverse(){
             self.unwrap.reverse()
    }
    
    func forwardReverse(){
        run()
        delay(totalTime){
            self.unwrap.reverse()
        }
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
    
    let rev = TimedPair(rhs.unwrap.time,rhs.unwrap.time, {},reverse: {
        
        rhs.revChainAnimate({
            if lhs.unwrap.time == -1.0{
               lhs.unwrap.reverse()
            }else{
               lhs.revChainAnimate()()
            }
        })()
    })
    
    let pair = TimedPairWrapper(tp : TimedPair(-1.0,0.0, {
            
        lhs.chainAnimate({
            if rhs.unwrap.time == -1.0{
               rhs.unwrap.block()
            }else{
               rhs.chainAnimate()()
            }
        })()
        
    }, reverse: rev.reverse ))
    
    pair.totalTime = lhs.totalTime + rhs.totalTime
    //pair.unwrap.reverse = rev
    
    return pair
}



