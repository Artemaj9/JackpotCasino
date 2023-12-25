//
//  View+Glow.swift
//

import SwiftUI

extension View {
    func glow(color: Color = .white, radius: CGFloat = 20) -> some View {
        self
            .overlay(self.blur(radius: radius/6))
            .shadow(color: color, radius: radius/3)
            .shadow(color: color, radius: radius/3)
            .shadow(color: color, radius: radius/3)
    }
}
