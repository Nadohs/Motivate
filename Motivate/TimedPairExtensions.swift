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
    
}