//
//  View+Glow.swift
//  JackpotCasino
//
//  Created by Artem on 20.12.2023.
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
