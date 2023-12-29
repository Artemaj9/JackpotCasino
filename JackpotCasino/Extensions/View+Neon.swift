//
//  View+Neon.swift
//

import SwiftUI

extension View {
    func neonGlow() -> some View {
        ForEach(0..<2) { i in
            Rectangle()
                .fill(Color("lightBlueNeon"))
                .mask(self.blur(radius: 20))
                .overlay(self.blur(radius: 5 - CGFloat(i * 5)))
        }
    }
}
