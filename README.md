# AnimatedGradientBackground

A small Swift Package written in SwiftUI for an animated gradient, which you can use in the background of your app.

It uses two identical RadialGradients set with different colors (old and newly changed) and change the opacity of the gradient in the front to animate a color change.

https://github.com/DonMalte/AnimatedGradientBackground/assets/35227173/ef4db93b-030f-42d5-b6ef-b4470cefe6b9

## The animations

**There are two animations:**
- the transition from the current to the next color.
- the position of the gradient moves slowly from one end to another. The points are chosen randomly. This creates a discreet and smooth motion.


## Installation

**Requirements**

- iOS 15.0+ / macOS 12.0+
- Xcode 13+
- Swift 5+

**Swift Package Manager**

In Xcode, go to `File > Add Packages` and add `https://github.com/DonMalte/AnimatedGradientBackground.git`. Add the package to all your targets.


## How to use

To use the package, you need to `import AnimatedGradientBackground`

You can change the settings globally to your needs:

```       
let settings = AnimatedGradientSettings.shared
settings.anchorPoints = [.init(x: 0.3, y: 0.6), .init(x: 0.6, y: 0.3)]
settings.animationDuration = 5
settings.showBlurOverlay = false
```


Or you can change it per background view:
```       
let settings = AnimatedGradientSettings()
settings.anchorPoints = ...
...
AnimatedGradientBackground(backgroundColor: .red, accentColor: .yellow, settings: settings)
```

To animate a color change, just change the input of the initilizer.

I got the idea from [this blog](https://nerdyak.tech/development/2019/09/30/animating-gradients-swiftui.html), so shoutout to Pavel Zak!
If you have an issue or a way to optimize the animation, please let me know! :) 
