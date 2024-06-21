//
//  View+Extensions.swift
//
//
//  Created by Arjun Dureja on 2024-06-19.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
