
# ModernSlider

![ModernSlider Image](https://https://github.com/arjun-dureja/ModernSlider/Assets/hero-image.png)

`ModernSlider` is a customizable slider component for SwiftUI, inspired by the macOS Control Center sliders, that provides a sleek and modern interface for selecting values from a range.

## Features

- Customizable width, height, system image, and color
- Optional title with a background view
- Smooth sliding animation
- Callbacks for value changes and drag end events
- Support for light and dark mode

## Requirements

- iOS 14.0+
- macOS 11.0+
- Swift 5.3+
- Xcode 12.0+

## Installation

### Swift Package Manager

You can install ModernSlider using Swift Package Manager. Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/arjun-dureja/ModernSlider.git", from: "1.0.0")
]
```

## Usage

First, import the ModernSlider package in your SwiftUI view:

```swift
import ModernSlider
```

Then, you can use the ModernSlider in your SwiftUI views:

```swift
struct ContentView: View {
    @State private var sliderValue = 50.0

    var body: some View {
        ModernSlider(
            "Brightness",
            systemImage: "sun.max.fill",
            sliderColor: .yellow,
            value: $sliderValue,
            onChange: { newValue in
                print("Slider value changed to \(newValue)")
            },
            onChangeEnd: { finalValue in
                print("Sliding ended with value \(finalValue)")
            }
        )
    }
}
```

### Customization

ModernSlider offers various customization options:

```swift
ModernSlider(
    "Volume",
    systemImage: "speaker.wave.2.fill",
    sliderWidth: 300,
    sliderHeight: 30,
    sliderColor: .blue,
    value: $volume
)
```

## API Reference

### ModernSlider

```swift
public init(
    _ title: String? = nil,
    systemImage: String,
    sliderWidth: CGFloat = 250,
    sliderHeight: CGFloat = 25,
    sliderColor: Color = .white,
    value: Binding<Double>,
    onChange: ((Double) -> Void)? = nil,
    onChangeEnd: ((Double) -> Void)? = nil
)
```

#### Parameters

- `title`: An optional string to describe the data the slider represents.
- `systemImage`: A string representing the system image name for the slider thumb.
- `sliderWidth`: The width of the slider track. Defaults to 250.
- `sliderHeight`: The height of the slider track and thumb. Defaults to 25.
- `sliderColor`: The color of the slider's fill and thumb. Defaults to white.
- `value`: A binding to the current value of the slider (0-100).
- `onChange`: An optional closure that is called when the slider value changes.
- `onChangeEnd`: An optional closure that is called when the dragging ends.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

ModernSlider is available under the MIT license. See the LICENSE file for more info.