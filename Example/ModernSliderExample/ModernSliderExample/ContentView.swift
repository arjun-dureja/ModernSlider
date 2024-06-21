//
//  ContentView.swift
//  ModernSliderExample
//
//  Created by Arjun Dureja on 2024-06-18.
//

import SwiftUI
import ModernSlider


struct ContentView: View {
    @State private var brightness: Double = 20.0
    @State private var volume: Double = 40.0
    @State private var temperature: Double = 60.0
    @State private var noTitleSliderValue: Double = 80.0

    var body: some View {
        VStack(spacing: 8) {
            Text("ModernSlider Examples")
                .font(.largeTitle)
                .padding()

            // Slider with default color
            ModernSlider(
                "Brightness",
                systemImage: "sun.max.fill",
                sliderWidth: 250,
                sliderHeight: 25,
                value: $brightness,
                onChange: { newValue in
                    print("Brightness onChange: \(newValue)")
                })
            Text("Brightness: \(Int(brightness))")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 12)


            // Slider with custom color
            ModernSlider(
                "Volume",
                systemImage: "speaker.wave.1.fill",
                sliderWidth: 275,
                sliderHeight: 25,
                sliderColor: .green,
                value: $volume
            )
            Text("Volume: \(Int(volume))")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 12)

            // Slider with custom color
            ModernSlider(
                "Temperature",
                systemImage: "thermometer",
                sliderWidth: 300,
                sliderHeight: 35,
                sliderColor: .blue,
                value: $temperature,
                onChangeEnd: { newValue in
                    print("Temperature onChangeEnd: \(newValue)")
                })
            Text("Temperature: \(Int(temperature))")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 12)

            // Slider with no title and default color
            ModernSlider(
                systemImage: "circle",
                sliderWidth: 325,
                sliderHeight: 30,
                value: $noTitleSliderValue
            )
            Text("No Title Slider Value: \(Int(noTitleSliderValue))")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 12)

            Spacer()
        }
    }
}

#Preview {
    ContentView()
        #if os(macOS)
        .frame(width: 500, height: 600)
        #endif
}
