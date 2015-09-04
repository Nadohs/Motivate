# SwiftChainedAnimations
Chain Animations in Swift with operators

First use `ANI` to build a `TimedPair` with a duration and  function
```
let a = ANI(1.5) { print("1\n")
```

Chain  `TimedPair` animations together with the `/>` operator
```
let x =  ANI(1.5) { print("1\n") }
      /> ANI(2.5) { print("2\n") }
      /> ANI(3.5) { print("3\n") }
```

Run the animation with  `AniRun`
```
AniRun(x)
```





