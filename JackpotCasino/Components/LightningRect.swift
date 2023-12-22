//
//  LightningRect.swift
//  JackpotCasino
//
//  Created by Artem on 22.12.2023.
//

import SwiftUI

struct LightningRect: View {
    var color = Color("neonRect")
    var shadow = Color("neonRectShadow")
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 12)
           
            .stroke(lineWidth: 6)
            .foregroundColor(.white)
            .innerShadow(using:    RoundedRectangle(cornerRadius: 12), angle: .radians(0), color: .black.opacity(0.25), width: 1, blur: 1)
            .frame(width: 270, height: 270)
            .rotationEffect(Angle.radians(-.pi/4))
            .scaleEffect(y: 0.7)
        
            .shadow(color: Color("lightningRect"), radius: 8)
            .shadow(color: Color("lightningRect"), radius: 8)

            .shadow(color: .black.opacity(0.22),radius: 1, y: 4)
            .shadow(color: .black.opacity(0.22),radius: 1, y: 4)
    }
}

struct LightningRect_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            LightningRect()
        }
    }
}
