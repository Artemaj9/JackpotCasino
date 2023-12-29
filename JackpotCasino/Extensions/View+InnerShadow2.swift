//
//  View+InnerShadow2.swift
//

import SwiftUI

extension View {
    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 6) -> some View {
        
        return self
            .overlay(
            shape
                .stroke(color, lineWidth: width)
                .blur(radius: blur)
                .mask(shape)
            )
    }
    
    func innerShadow3<S: Shape>(using shape: S, with strokeStyle: StrokeStyle, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 6) -> some View {

        return self
            .overlay(
            shape
                .stroke(style: strokeStyle)
                .blur(radius: blur)
                .mask(shape)
            )
    }
}
