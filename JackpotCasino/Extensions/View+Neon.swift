//
//  View+Neon.swift
//  JackpotCasino
//
//  Created by Artem on 20.12.2023.
//

import SwiftUI

extension View {
    func neonGlow() -> some View {
        ForEach(0..<2) { i in
            Rectangle()
                .fill(Color("lightBlueNeon"))
                //.frame(width: 400, height: 400)
                .mask(self.blur(radius: 20))
                .overlay(self.blur(radius: 5 - CGFloat(i * 5)))
        }
    }
}
