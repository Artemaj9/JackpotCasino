//
//  View+Border.swift
//

import SwiftUI

extension View {
    @ViewBuilder
    func viewBorder(color: Color = .black, radius: CGFloat = 0.4, outline: Bool = false) -> some View {
        if outline {
            self
            
                .shadow(color: color, radius: radius, x: 0, y: 1)
                .shadow(color: color, radius: radius, x: 0, y: -1)
                .shadow(color: color, radius: radius, x: 1, y: 0)
                .shadow(color: color, radius: radius, x: -1, y: 0)
                .invertedMask(
                    self
                )
        } else {
            self
                .shadow(color: color, radius: radius, x: 0, y: 1)
                .shadow(color: color, radius: radius, x: 0, y: -1)
                .shadow(color: color, radius: radius, x: 1, y: 0)
                .shadow(color: color, radius: radius, x: -1, y: 0)
        }
    }
}

extension View {
    func invertedMask<Content : View>(_ content: Content) -> some View {
        self
            .mask(
                ZStack {
                    self
                        .brightness(1)
                    content
                        .brightness(-1)
                }.compositingGroup()
                    .luminanceToAlpha()
            )
    }
}
