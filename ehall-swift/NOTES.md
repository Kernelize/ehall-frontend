# Notes
My random shits in learnig swiftUI.

## View stuffs

In swift, the `@ViewBuilder` property wrapper is actually a syntax sugar, it will get conversed into a func that returns `some View` in compilation.
This code:
```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Text("World")
        }
    }
}
```

Desugars into:
```swift
struct ContentView: View {
    var body: some View {
        ViewBuilder.buildBlock(
            Text("Hello"),
            Text("World")
        )
    }
}
```

```swift
struct fuck {
    Text("\(taps) taps")
        .onChange(of: viewModel.cards) { newCards in
            taps += 1
        }
}
```
newCards is the value it's going to set to

## Animation
**Important takeaways about Animation**
Only changes can be animated. Changes to what?
+ ViewModifier arguments (including GeometryEffect modifiers)
+ Shapes
+ The transition of a View form "existing" to "not existing" in the UI(or vice versa)
Animation is showing the user changes that have **already happend** (i.e. the recent post)

## Gestures
### Handling Non-Discrete Gestures
```swift
var theGesture: some Gesture {
    DragGesture(...)
        .onEnded { value in 
            /* do something */
        }
}
```
note though that its `.onEnded` passes you a value.
That value tells you the state of the DragGesture when it ended.
what that value is varies from gesture to gesture.
For a DragGesture, it's a struct with things loke the start and end location of the fingers.
For a MagnificationGesture, it's a struct with things like the scale of the magnification.
For a RotationGesture it's the angle of the roration (like the fingers were turning a dial).

During a gesture, state:
```swift
@GestureState var myGestureState: myGestureStateType = <starting value>
```
**This var will always return to <starting value> when the gesture ends**
```swift
DragGesture(...)
    .updating($myGestureState) { value, myGestureState, transaction in
        myGestureState = /* some shits */
    }
    .onEnded { value in /* shits */ }
```

## Persistence
+ Storing data that persists between launchings of your application (part one)
+ FileManager/URL/DATA (accessing the Unix file system)
+ JSON Enconding/Decoding + Codable
+ UserDefaults

### URL
+ URL methods:
```swift
func appendingPathComponet(String) -> URL {}
func appendingPathExtension(String) -> URL {}
```

+ Buiding on top of these system paths
let path = URL.documentsDirectory.appendingPathComponet("filename.doc")

+ Finding out about what's at the other end of a URL
```swift
var isFileURL: Bool // is this a file URL or something else
func resourceValues(for keys: [URLResourceKey]) throws -> [URLResourceKey:Any]?
```

### Data
+ Reading binary data from a URL ...
```swift
init(contentsOf: URL, options: Data.ReadingOptions) throws
// e.g. 
let data = try Data(contentsOf: url)
```
Notice that the function **throws** and **blocks**(so we'd rarely use it for that).

+ Writing binary data to a URL ...
```swift
func write(to url: URL, options: Data.WritingOptions) throws -> Bool {}
```
The options can be things like .atomic(write to tmp file, the swap) or .withoutOverwriting.
The function also **throws**
