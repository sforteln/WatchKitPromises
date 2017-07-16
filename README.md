# WatchKitPromises


## PromiseKit Promises for WatchKit


## Installation

WatchKitPromises is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile in the WatchKit Extension target:

```ruby
target 'XXXX WatchKit Extension' do

  pod 'WatchKitPromises'

end
```

## Usage

```swift
import WatchKitPromises

override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    self.animate(duration: duration, animations: {
        self.startButton?.setAlpha(0)
        self.swipeLabel?.setAlpha(0)
    })
    .wait(2)
    .then(execute: {
        ///API request, etc
        return
    })
    .animate(in: self, duration: 2, animations: {
        self.startButton?.setAlpha(1)
        self.swipeLabel?.setAlpha(1)

    })
}
```



## Author

Simon Fortelny, sforteln@gmail.com

## License

WatchKitPromises is available under the MIT license. See the LICENSE file for more info.
