# Notes
My random shits in learnig swiftUI.

## View stuffs

### ViewBuilder
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

### @ObservableObject & @Published
if you have a class implements @ObservableObject, you'll get a free
```swift
var objectWillChange: ObservableObjectPublisher
```
We use the var to tell the view that something is going to change
`@Published` decorated vars calls `objectWillChange.send()` every time it changes

## Animation
**Important takeaways about Animation**
Only changes can be animated. Changes to what?
+ ViewModifier arguments (including GeometryEffect modifiers)
+ Shapes
+ The transition of a View form "existing" to "not existing" in the UI(or vice versa)
Animation is showing the user changes that have **already happend** (i.e. the recent post)

### MatchedGeometryEffect
todo

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

We do Persistence in **ViewModel**

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

### Archiving
#### Codable Mechanism
An object is Codable if all of its properties are codable
```swift
let object: MyType = ... // MyType must conform to Codable
let jsonData: Data = try JSONEncoder().encode(object)

let jsonString = String(data: jsonData, encoding: .utf8) // JSON is always utf8

// write
try jsonData.write(to: url)

// get object graph back from the jsonData
if let myObject: MyType = try? JSONDecoder().decode(MyType.self, from: jsonData) {
    // some shits with the object
}
```

#### UserDefaults
+ UserDefaults is a very simple, persistent, dictionary-like thing.
```swift
let defaults = UserDefaults.standard

// set data
default.set(object, forKey: "SomeKey") // object must be a Propertylist

// retrieving data
let i: Int? = defaults.integer(forKey: "MyInteger")
let b: Data? = defaults.integer(forKey: "MyData")
```
A Property List is a concept (not a protocol or concrete type), ancient thing, about 20 years old.

## Error Handling
### choose not to handle an error thrown at you
+ try? completely ignores any error that is thrown and returns nil if an error is thrown
+ try! crashes your program
+ try inside a function that is itself marked as `throws` (this rethrows any error that is thrown)

### Actually handling a thrown error
```swift
do {
    try functionThatThrows()
} catch let error {
    // handle the thrown error here
    // error can be anything that implements the Error protocol
}
```
You can also catch specific errors with multiple catch clauses on a single do { }.

## Property Wrappers
`@Something` is actually a struct, which encapsulate some "template" behavior applied to the vars they wrap.
Examples:
+ Making a var live in the heap(and update its View) (@State)
+ Making a var publish its changes (@Published)
+ Causing a View publish its changes (@ObservableObject)
The property wrapper feature adds "syntactic sugar" to make these structs easy to create/use.

```swift
@Published var emojiArt: EmojiArt = EmojiArt()
// desugars to
struct Published {
    var wrappedValue: EmojiArt
    var projectedValue: Publisher<EmojiArt, Never>
}
// and swift (approximately) makes these vars available to you
var _emojiArt: Published = Published(wrappedValue: EmojiArt())
var emojiArt: EmojiArt {
    get { _emojiArt.wrappedValue }
    set { _emojiArt.wrappedValue = newValue }
}
// you can accessing projectedValue using `$emojiArt`
```
Publishers are essentially something that knows how to publish something basic on a stream of information.
projectedValue's type is up to the Property Wrapper

### Why?
Because, the Wrapper struct **does something** on set/get of the wrappedValue.
+ `@Published` publish change through projectedValue($emojiArt), invokes `objectWillChange.send()` in its enclosing ObservableObject.
+ `@State` stores the wrappedValue in the heap; when it changes, invalidates the View. `init() { _foo = .init(initialValue: 5) }`. projectedValue: a binding to the value in the heap
+ `@StateObject` and `@ObservedObject`: anything that implements the `ObservableObject` protocol.(ViewModels). invalidates the View when wrappedValue does `objectWillChange.send()`. projectedValue: a `Binding` to the vars of the wrappedValue ViewModel. e.g. `$myViewModel.someVar.someArray[3]`
+ `@Binding` wrappedValue: a value that is bound to something else, gets/sets the value of the wrappedValue from some other source, when the bound-to value changes, it invalidates the View. projectedValue: a `Binding` to the Binding **self**.
+ `@EnvironmentObject` wrappedValue: ObservableObject obtained via `.environmentObject()` sent to the View. Invalidates the when when wrappedValue does objectWillChange.send(). projectedValue: a `Binding` to the vars of the wrappedValue ViewModel.
+ `Environment` Property Wrappers can have yet more variables than wrappedValue and projectedValue. They are just normal structs. You can pass values to set these other vars using `()` (e.g. `\.colorscheme`) is a key path. It specifies which instance variable to look at in an EnvironmentValue struct. wrappedValue: some var in EnvironmentValue. projectedValue: none.

### Where we do `Bindings`?
All over the freaking place.
Getting text out of a `TextField` ,the choice out of a Picker, etc.
Using a Toggle or other state-modifying UI element.
Finding out which item in a `List` was chosen
Binding our gestures state to the .updating function of a gesture.
Knowing anout (or causing) a modaly presented View's dismissal.
In general, breaking our Views into smaller pieces (and sharing data with them).
Bindings are all about having a **single source of the truth**!
```swift
struct MyView: View {
    @State var myString = "Hello"
    var body: View {
        OtherView(sharedText: $myString)
    }
}

struct OtherView: View {
    @Binding var sharedText: String
    var body: View {
        TextFiled("Shared: ", text: sharedText)
    }
}
```
