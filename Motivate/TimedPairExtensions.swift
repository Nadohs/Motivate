//
//  TimedPairExtensions.swift
//  testAnimation
//
//  Created by Richard Fox on 9/6/15.
//  Copyright © 2015 Demo. All rights reserved.
//

import UIKit


public extension UIView{
    
    
    public func byX(x:CGFloat) -> TimedPair{
        var f = CGRect.zero
        f.origin.x += x
        return self.byFrame(f)
    }
    
    
    public func byY(y:CGFloat) -> TimedPair{
        var f = CGRect.zero
        f.origin.y += y
        return self.byFrame(f)
    }
    
    
    public func byWidth(w:CGFloat) -> TimedPair{
        var f = CGRect.zero
        f.size.width += w
        return self.byFrame(f)
    }
    
    
    public func byHeight(h:CGFloat) -> TimedPair{
        var f = CGRect.zero
        f.size.height += h
        return self.byFrame(f)
    }
    
    
    public func byFrame(frame:CGRect) -> TimedPair{
        
        let block:EmptyFunc = {
            self.frame.origin.x    += frame.origin.x
            self.frame.origin.y    += frame.origin.y
            self.frame.size.width  += frame.size.width
            self.frame.size.height += frame.size.height
        }
        let reverse:EmptyFunc = {
            self.frame.origin.x    -= frame.origin.x
            self.frame.origin.y    -= frame.origin.y
            self.frame.size.width  -= frame.size.width
            self.frame.size.height -= frame.size.height
        }
        return TimedPair(0, 0, block, reverse:reverse)
    }
    
    
    public func byAlpha(change:CGFloat) -> TimedPair{
        
        let block:EmptyFunc = {
            self.alpha += change
        }
        let reverse:EmptyFunc = {
            self.alpha -= change
        }
        return TimedPair(0, 0, block, reverse:reverse)
    }
    
    
    public func backColorChange(from from:UIColor, to:UIColor) -> TimedPair{
        
        let block:EmptyFunc = {
            self.backgroundColor = to
        }
        let reverse:EmptyFunc = {
            self.backgroundColor = from
        }
        return TimedPair(0, 0, block, reverse:reverse)
    }
    
    
    public func rotateBy(degrees:CGFloat) -> TimedPair{
        
        let angle:CGFloat->CGFloat = { M_PI.c * ($0 / 360).c }
        
        let block: EmptyFunc = {
            self.transform = CGAffineTransformRotate( self.transform,  angle(degrees) )
            self.fixHeight()
        }
        
        let reverse: EmptyFunc = {
            self.transform = CGAffineTransformRotate( self.transform, -angle(degrees) )
            self.fixHeight()
        }
        
        return TimedPair(0, 0, block, reverse:reverse)
    }
    
    
    private func fixHeight(){
        var boundz = self.bounds;
        boundz.size.height = self.frame.height;
        self.bounds = boundz;
    }
    
}



//extension UIImageView {
//    
//    public func imageChange(from from:UIImage, to:UIImage) -> TimedPair{
//        let block:EmptyFunc = {
//            self.image = to
//        }
//        let reverse:EmptyFunc = {
//            self.image = from
//        }
//        return TimedPair(0, 0, block, reverse:reverse)
//    }
//    
//    
//    public func imageChange(from from:String, to:String) -> TimedPair{
//        
//        let block:EmptyFunc = {
//            self.image = UIImage(named: to)
//        }
//        let reverse:EmptyFunc = {
//            self.image = UIImage(named: from)
//        }
//        return TimedPair(0, 0, block, reverse:reverse)
//    }
//    
//}