//
//  ModernSlider.swift
//  ModernSlider
//
//  Created by Arjun Dureja on 2024-06-18.
//

import SwiftUI

/// `ModernSlider` is a customizable slider component for selecting a value from a linear range of values.
///
/// # Features
/// - Customizable width, height, system image, and color
/// - Customizable title with a background view
/// - Provides a callback for value changes and for when the dragging ends
///
/// # Example
///
/// ```
/// @State private var brightness = 50.0
///
/// var body: some View {
///     ModernSlider("Brightness", imageType: .system(name: "sun.max.fill"), value: $brightness, onChange: { newValue in
///         print("Brightness changed to \(newValue)")
///     })
/// }
/// ```
///
/// # Parameters
///
/// - `title`: An optional string to describe the data the slider represents.
/// - `systemImage`: A string representing the system image name for the slider thumb.
/// - `sliderWidth`: The width of the slider track. Defaults to 250.
/// - `sliderHeight`: The height of the slider track and thumb. Defaults to 25.
/// - `sliderColor`: The color of the slider's fill and thumb. Defaults to white.
/// - `value`: A binding to the current value of the slider.
/// - `onChange`: An optional closure that is called when the slider value changes.
/// - `onChangeEnd`: An optional closure that is called when the dragging ends.
///
public struct ModernSlider: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var offset: CGFloat = 0
    @State private var isDragging: Bool = false

    @Binding private var value: Double

    private let title: String?
    private let systemImage: String
    private let sliderWidth: CGFloat
    private let sliderHeight: CGFloat
    private let sliderColor: Color
    private let onChange: ((Double) -> Void)?
    private let onChangeEnd: ((Double) -> Void)?

    public init(
        _ title: String? = nil,
        systemImage: String,
        sliderWidth: CGFloat = 250,
        sliderHeight: CGFloat = 25,
        sliderColor: Color = .white,
        value: Binding<Double>,
        onChange: ((Double) -> Void)? = nil,
        onChangeEnd: ((Double) -> Void)? = nil
    ) {
        self.title = title
        self.systemImage = systemImage
        self.sliderWidth = sliderWidth
        self.sliderHeight = sliderHeight
        self.sliderColor = sliderColor
        self._value = value
        self.onChange = onChange
        self.onChangeEnd = onChangeEnd
    }

    private var halfThumbSize: CGFloat {
        sliderHeight / 2
    }

    private var sliderFillWidth: CGFloat {
        let fillAmount = min(offset + halfThumbSize, sliderWidth - halfThumbSize)
        return max(halfThumbSize, fillAmount) + halfThumbSize
    }

    public var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .foregroundStyle(Color.primary)
                    .font(.system(size: halfThumbSize))
            }

            SliderView(
                offset: $offset,
                isDragging: $isDragging,
                sliderWidth: sliderWidth,
                sliderHeight: sliderHeight,
                sliderColor: sliderColor,
                systemImage: systemImage,
                colorScheme: colorScheme,
                onChange: updateValue,
                onChangeEnd: { onChangeEnd?(value) }
            )
        }
        .padding(12)
        .modifier(ConditionalBackground(isActive: title != nil))
        .onChange(of: value) { newValue in
            updateOffset(to: newValue)
        }
        .onAppear {
            updateOffset(to: value)
        }
    }

    private func updateValue() {
        value = Double(offset / (sliderWidth - sliderHeight)) * 100
        onChange?(value)
    }

    private func updateOffset(to value: Double) {
        let newOffset = (value / 100.0) * (sliderWidth - sliderHeight)
        offset = max(0, min(newOffset, sliderWidth - sliderHeight))
    }
}

private struct SliderView: View {
    @Binding var offset: CGFloat
    @Binding var isDragging: Bool

    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    let sliderColor: Color
    let systemImage: String
    let colorScheme: ColorScheme
    let onChange: () -> Void
    let onChangeEnd: () -> Void

    private var halfThumbSize: CGFloat {
        sliderHeight / 2
    }

    private var sliderFillWidth: CGFloat {
        let fillAmount = min(offset + halfThumbSize, sliderWidth - halfThumbSize)
        return max(halfThumbSize, fillAmount) + halfThumbSize
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                isDragging = true
                updateOffset(at: value.location.x)
                onChange()
            }
            .onEnded { _ in
                isDragging = false
                onChangeEnd()
            }
    }

    var body: some View {
        ZStack(alignment: .leading) {
            sliderTrack
            sliderFill
            sliderThumb
        }
        .gesture(dragGesture)
        .animation(.easeIn(duration: 0.1), value: offset)
    }

    private var sliderTrack: some View {
        Capsule()
            .fill(colorScheme.trackFill)
            .frame(width: sliderWidth, height: sliderHeight)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                Capsule()
                    .stroke(colorScheme.trackStroke, lineWidth: 0.25)
            )
    }

    private var sliderFill: some View {
        Capsule()
            .fill(sliderColor)
            .frame(width: sliderFillWidth, height: sliderHeight)
            .overlay(
                Capsule()
                    .stroke(colorScheme.trackStroke, lineWidth: 0.25)
            )
    }

    private var sliderThumb: some View {
        Circle()
            .frame(width: sliderHeight, height: sliderHeight)
            .foregroundStyle(sliderColor)
            .brightness(isDragging ? -0.1 : 0)
            .shadow(radius: colorScheme == .dark ? 5 : 3)
            .overlay {
                Image(systemName: systemImage)
                    .font(.system(size: halfThumbSize))
                    .foregroundStyle(Colors.thumbIconColor)
            }
            .offset(x: offset)
    }

    private func updateOffset(at location: CGFloat) {
        let adjustedLocation = location - halfThumbSize
        offset = max(0, min(adjustedLocation, sliderWidth - sliderHeight))
    }
}

private struct ConditionalBackground: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    let isActive: Bool

    func body(content: Content) -> some View {
        content
            .background(isActive ? AnyShapeStyle(.regularMaterial) : AnyShapeStyle(Color.clear))
            .clipShape(RoundedRectangle(cornerRadius: isActive ? 12 : 0))
            .shadow(color: colorScheme.thumbShadow, radius: isActive ? 8 : 0)
    }
}

#Preview {
    ModernSlider("Brightness", systemImage: "sun.max.fill", value: .constant(50))
}

