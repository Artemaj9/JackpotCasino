//
//  NeonRect.swift
//

import SwiftUI

struct NeonRect: View {
    var color = Color("neonRect")
    var shadow = Color("neonRectShadow")
    var strokeCoeff: CGFloat = 1
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(color)
         
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color, lineWidth: 2*strokeCoeff)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.7), lineWidth: 4*strokeCoeff)
                            .glow(color: color, radius: 2.6)
                            .shadow(color: .black.opacity(0.2), radius: 13)
                    )
            }
         .rotationEffect(.degrees(45))
            .shadow(color: shadow, radius: 23)  
    }
}

struct NeonRect_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
           Image("table")
            NeonRect()
        }
    }
}
