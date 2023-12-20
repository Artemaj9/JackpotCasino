//
//  View+InnerNeonShadow.swift
//

import SwiftUI

private extension View {
    func innerShadow(_ shadowRadius: Double, opacity: Double = 0.5, x: Double = 0, y: Double = 0) -> some View {
        let opacity = min(1, max(0, opacity))
        return self
            .compositingGroup()
            .background(
                Color.white(1-opacity)
                    .overlay(
                        Color.white
                            .mask(self)
                            .blur(radius: shadowRadius)
                            .offset(x: x,y: y)
                    )
                    .mask(self)
                    .compositingGroup()
            )
            .blendMode(.multiply)
            .compositingGroup()
    }
}
