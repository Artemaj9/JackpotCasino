//
//  NeonRectangle.swift
//  JackpotCasino
//
//  Created by Artem on 20.12.2023.
//

import SwiftUI

struct NeonRectangle: View {
    
    var color = Color("neonRect")
    var shadow = Color("neonRectShadow")
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color("neonRect"))
         
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("neonRect"), lineWidth: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.7), lineWidth: 4)
                            .glow(color: Color("neonRect"), radius: 2.6)
                            .shadow(color: .black.opacity(0.2), radius: 13)
                        .innerShadow(using:  RoundedRectangle(cornerRadius: 12), color: .black.opacity(0.36),width: 8, blur: 3)
                    )
            }
            .shadow(color: Color("neonRectShadow"), radius: 12)
            .frame(width: 200, height: 200)
            .rotationEffect(.degrees(45))
    }
}

struct NeonRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            NeonRectangle()
        }
    }
}
