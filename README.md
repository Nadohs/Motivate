# SwiftChainedAnimations
Chain Animations in Swift with operators

First use `ANI` to build a `TimedPair` with a duration and  function
```
let a = ANI(1.5) { print("1\n") }
```

Chain  `TimedPair` animations together with the `/>` operator
```
         ANI(1.5) { print("1\n") }
      /> ANI(2.5) { print("2\n") }
      /> ANI(3.5) { print("3\n") }
```

More 
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
        )
```
