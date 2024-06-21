//
//  Colors.swift
//
//
//  Created by Arjun Dureja on 2024-06-19.
//


import SwiftUI

struct Colors {
    static let lightTrackStroke = Color.gray.opacity(1)
    static let darkTrackFill = Color(white: 0.3).opacity(0.5)
    static let lightTrackFill = Color(white: 0.8).opacity(0.5)
    static let lightThumbFill = Color(red: 240/255, green: 240/255, blue: 240/255)
    static let darkThumbFill = Color(red: 225/255, green: 225/255, blue: 225/255)
    static let thumbShadowLight = Color.black.opacity(0.1)
    static let thumbShadowDark = Color.white.opacity(0.05)
    static let thumbIconColor = Color(red: 25/255, green: 25/255, blue: 25/255)
}

extension ColorScheme {
    var trackFill: Color {
        self == .dark ? Colors.darkTrackFill : Colors.lightTrackFill
    }

    var trackStroke: Color {
        self == .light ? Colors.lightTrackStroke : .clear
    }

    var thumbFill: Color {
        self == .dark ? Colors.darkThumbFill : Colors.lightThumbFill
    }

    var thumbShadow: Color {
        self == .dark ? Colors.thumbShadowDark : Colors.thumbShadowLight
    }
}
