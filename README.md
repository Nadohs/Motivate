# SwiftChainedAnimations
Chain Animations in Swift with operators

### What it Replaces

What this does is turn this long chained animations, set to fire one right after the previous completes
```
func longFormChainedSyntax(){
    UIView.animateWithDuration(1.0, animations: { print("1") }, completion: { _ in
        
        UIView.animateWithDuration(1.0, animations: { print("2") }, completion: { _ in
            
            UIView.animateWithDuration(1.0, animations: { print("3") }, completion: nil)
        })
    })
}
```
into this much more digestible syntax:
```
func shortFormChainedSyntax(){
    ANI(1.0){
        print("1\n")
    }
    /> ANI(2.0){
        print("2\n")
    }
    /> ANI(3.0){
        print("3\n")
    }
}
```






### Usage
First use `ANI` to build a `TimedPair` with a duration and  function
```
let a = ANI(1.5) { print("1\n") }
```

Chain  `TimedPair` animations together with the `/>` operator, which calls the next animation, on the completion of the previous.

```
         ANI(1.5) { print("1\n") }
      /> ANI(2.5) { print("2\n") }
      /> ANI(3.5) { print("3\n") }
```
### More Example Usage
```
            ANI(3.0){
                self.button1.frame.origin.x += 100
                self.button2.frame.origin.x -= 100
            }
            /> ANI(0){
                self.button1.frame.origin.x -= 100
                self.button2.frame.origin.x += 100
            }
            /> ANI(5.5){
                self.button3.frame.origin.x += 100
            }
            /> ANI(3.0){
                self.button1.frame.origin.x -= 100
            }
            /> ANI(5.5){
                self.button2.frame.origin.x -= 100
            }
            /> ANI(5.5){
                self.button3.frame.origin.x -= 100
            }
```
