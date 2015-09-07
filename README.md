# Motivate - Animation Chaining
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

### Looping

You can assign the animation as a variable, and either call `runLoop` to run it looped, or `run` to animate it once.

```        
let animation = Motivate(time: 3.0){
                    self.button1.frame.origin.x += 100
                    self.button2.frame.origin.x -= 100
                    self.button1.backgroundColor = UIColor.greenColor()
                }
                <> Motivate(time: 1.0, delay:2.0){
                    
                    self.button1.frame.origin.x -= 100
                    self.button2.frame.origin.x += 100
                    self.button1.backgroundColor = UIColor.blueColor()
                }
                <> Motivate(time: 2.5){
                    
                    self.button3.frame.origin.x += 100
                    self.button1.backgroundColor = UIColor.orangeColor()
                }
                <> Motivate(time: 1.0){
                    
                    self.button1.frame.origin.x -= 100
                    self.button1.backgroundColor = UIColor.redColor()
                }
                <> Motivate(time: 2.5){
                    
                    self.button2.frame.origin.x += 100
                    self.button1.backgroundColor = UIColor.blackColor()
                }
                <> Motivate(time: 1.5, delay:1.5){
                    
                    self.button3.frame.origin.x -= 100
                    self.button2.frame.origin.x -= 100
                    self.button1.frame.origin.x += 100
                    self.button1.backgroundColor = UIColor.whiteColor()
                }

animation.runLoop() //repeats
//animation.run() //runs once
```
