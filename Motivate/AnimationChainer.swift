//
//  AnimationChainer.swift
//  testAnimation
//
//  Created by Richard Fox on 9/3/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

import UIKit





public typealias EmptyFunc  =  Void -> Void


public struct TimedPair {

    
    var time : Double
    let delay: Double
    
    let block  : EmptyFunc
    var reverse: EmptyFunc
    
//    var style  : MotivationStyle = .None

    
    var target : Any?
    
    init(_ time:Double, _ delay:Double,_ block:EmptyFunc, reverse:EmptyFunc = {}){
        self.time    = time
        self.delay   = delay
        self.block   = block
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




/// Create `TimedPair` from duration `t` and function `e`


    public func Motivate(time t:Double, delay d:Double = 0.0, e: EmptyFunc) -> TimedPairWrapper{
        
        return TimedPairWrapper(tp: TimedPair(t, d, e ))
    }

    public func Motivate(time t:Double, delay d:Double = 0.0, _ e: TimedPair...) -> TimedPairWrapper{
        
        var total = e.reduce(.Zero, combine: + )
        total.time = t

        let x = TimedPair(t, d, total.block, reverse: total.reverse).wrap()
        return x
    }


/// Run animation on `TimedPair`


public class TimedPairWrapper {

    /// determines whether to call `run()` on deinit
    private var unwrapFinished = false
    
    private var shouldLoop     = false
    
//    private var totalTime:Double = 0
    
    private var animations = [TimedPair]()
    
    /// `run()` to play animation one time
    public func run(){
        buildRun()
    }
    
    /// `runReverse` plays animation backwards
    /// requires having used dot proprty "by" quantity animations
    public func runReverse(){
        buildReverse()
    }
    
    private func buildRun(){
        let animate = buildAnimation(animations)
        animate()
    }
    
    
    private func buildReverse(){
        let animate = buildAnimation(animations.reverse(), reverse:true)
        animate()
    }
    
    
    func buildAnimation(var list:[TimedPair], reverse:Bool = false) -> EmptyFunc{
        
        var gen = list.generate()
        
        func aniFuncForPair(pair:TimedPair) -> EmptyFunc{
            
            let time  = pair.time
            let delay = pair.delay
            
            let block = reverse ? pair.reverse : pair.block
            
            return {
                UIView.animateWithDuration(time,
                    delay: delay,
                    options: .TransitionNone,
                    animations: block,
                    completion: { _ in
                        
                        if let next = gen.next(){
                            
                            aniFuncForPair(next)()
                        }
                })
            }
        }
        
        if let first = gen.next(){
            return aniFuncForPair(first)
            
        }else{
            return {}
            
        }
    }

    
    
    init(tp:TimedPair){
        animations = [tp]
    }
    
//    /// call `runLoop()` to repeat the animation continuously.
//    
//    func runLoop(){
//        shouldLoop = true
//        loop()
//    }
//    
//    /// call `run()` to **run** animation once.
//    
//    
//    func forwardReverse(){
//        run()
////        delay(totalTime){
////            self.unwrap.reverse()
////        }
//    }
//    
//    private func loop(){
//        self.run()
//        
//        if !shouldLoop{
//            return
//        }
//        
////        delay(totalTime){
////            self.loop()
////        }
//    }
    

    deinit{
        if !unwrapFinished{
            run()
        }
    }
}


//MARK: - Custom/Overloaded Operators -

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


public func <> ( lhs:TimedPairWrapper, rhs:TimedPairWrapper) ->  TimedPairWrapper{
    
    lhs.animations += rhs.animations//.append(rhs.animations.first!)
    rhs.unwrapFinished = true;
    return lhs//pair
}


//MARK:


//enum MotivationStyle{
//    case None, Frame, Color, Alpha, Corners
//}


//private func delay(delay:Double, closure:()->()) {
//    dispatch_after(
//        dispatch_time(
//            DISPATCH_TIME_NOW,
//            Int64(delay * Double(NSEC_PER_SEC))
//        ),
//        dispatch_get_main_queue(), closure)
//}