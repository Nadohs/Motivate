# Motivate - Reversible Animation Chaining ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
Chain Animations in Swift with operators

### What it Replaces

What **Motivate** does is turn this long chain of animations, set to fire one animation after the other completes:

```
func longFormChainedSyntax(){
    UIView.animateWithDuration(1.0, animations: { print("1") }, completion: { _ in
        
        UIView.animateWithDuration(1.0, animations: { print("2") }, completion: { _ in
            
            UIView.animateWithDuration(1.0, animations: { print("3") }, completion: nil)
        })
    })
}
```

into this much more readable syntax:


```
func Motivate(time t:Double, delay d:Double = 0.0, e: EmptyFunc) -> TimedPairWrapper

//USAGE
func shortFormChainedSyntax(){
    Motivate(time: 1.0){
        print("1\n")
    }
    <> Motivate(time: 2.0){
        print("2\n")
    }
    <> Motivate(time: 3.0){
        print("3\n")
    }
}
```

### Usage

First use `Motivate` to build a `TimedPair` with a duration as `time`, optionally `delay` and a function to animate

```
let a = Motivate(time: 1.5, delay: 1.0) { print("1\n") }
```

Chain  `TimedPair` animations together with the `<>` operator, which calls the next animation, on the completion of the previous.

```
         Motivate(time: 1.5) { print("1\n") }
      <> Motivate(time: 2.5) { print("2\n") }
      <> Motivate(time: 3.5) { print("3\n") }
```

### Reversability
Using a "by" quantity type specification you can now reverse stored animations with `runReverse()`.


```
    func Motivate(time t:Double, delay d:Double = 0.0, _ e: TimedPair...) -> TimedPairWrapper
    
    ////USAGE
    let animation =
            Motivate(
                time: 3.0,
                button1.byX(-20),
                button2.byX(-20)
            )
            <> Motivate(
                time: 1.0,
                button1.byX(-30),
                button2.byX(-30)
            )
         
    animation.runReverse()
```


~~### Looping~~

`runLoop` and `forwardReverse()` temporarily removed in current version
