

/// var num:Double   = 12;
/// var num2:Float   = num.f;
/// var num3:CGFloat = num.c;
/// var num4:Int     = num.i;
/// var num5:Double  = num2.d;

import UIKit;

extension Double {
    var c:CGFloat{
        get{
            return CGFloat(self);
        }
    }
    var f:Float{
        get{
            return Float(self);
        }
    }
    var d:Double{
        get{
            return Double(self);
        }
    }
    var i:Int{
        get{
            return Int(self);
        }
    }
}

extension CGFloat {
    var c:CGFloat{
        get{
            return CGFloat(self);
        }
    }
    var f:Float{
        get{
            return Float(self);
        }
    }
    var d:Double{
        get{
            return Double(self);
        }
    }
    var i:Int{
        get{
            return Int(self);
        }
    }
}


extension Int{
    var c:CGFloat{
        get{
            return CGFloat(self);
        }
    }
    var f:Float{
        get{
            return Float(self);
        }
    }
    var d:Double{
        get{
            return Double(self);
        }
    }
    var i:Int{
        get{
            return Int(self);
        }
    }
}

extension Float{
    var c:CGFloat{
        get{
            return CGFloat(self);
        }
    }
    var f:Float{
        get{
            return Float(self);
        }
    }
    var d:Double{
        get{
            return Double(self);
        }
    }
    var i:Int{
        get{
            return Int(self);
        }
    }
}
