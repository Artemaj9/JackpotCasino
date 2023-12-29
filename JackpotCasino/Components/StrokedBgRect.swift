//
//  StrokedBgRect.swift
//  JackpotCasino
//
//  Created by Artem on 27.12.2023.
//

import SwiftUI

struct StrokedBgRect: View {
    var color = Color("neonRect")
    var lightningColor = Color("lightningRect")
    var shadow = Color("neonRectShadow")
    var dash: [CGFloat] = [60, 30, 100, 20]
    var xScale: CGFloat = 1
    var yScale: CGFloat = 1
    var angle: Angle = .degrees(50)
    var axis:(CGFloat, CGFloat, CGFloat) = (0,1,1)
    @State var dashPhase: CGFloat = CGFloat(Int.random(in: 0...100))
    var endDashPhase: CGFloat = -500
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 12)
        
            .strokeBorder(style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [60, 30, 100, 20], dashPhase: dashPhase))
            .foregroundColor(.white)
            .innerShadow(using:    RoundedRectangle(cornerRadius: 12), angle: .radians(0), color: .black.opacity(0.25), width: 1, blur: 1)
            .frame(width: 270, height: 270)
            .rotationEffect(Angle.radians(-.pi/4))
            .scaleEffect(x: xScale, y: yScale)
            .rotation3DEffect(angle, axis: (x: axis.0, y: axis.1, z: axis.2))
            .shadow(color: lightningColor, radius: 8)
            .shadow(color: lightningColor, radius: 8)
        
            .shadow(color: .black.opacity(0.22),radius: 1, y: 4)
            .shadow(color: .black.opacity(0.22),radius: 1, y: 4)
            .onAppear {
                withAnimation(Animation.linear(duration: 120)) {
                    dashPhase = endDashPhase
                }
            }
    }
}

struct StrokedBgRect_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            StrokedBgRect()
        }
    }
}
