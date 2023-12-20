//
//  NeonRectangle.swift
//  JackpotCasino
//
//  Created by Artem on 20.12.2023.
//

import SwiftUI

struct NeonRectangle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("neonRect"), lineWidth: 2)
                   // .blur(radius: 6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 4)
                            .glow(color: Color("neonRect"), radius: 2.6)

                            .shadow(color: .black.opacity(0.2), radius: 13)
                        .innerShadow(using:  RoundedRectangle(cornerRadius: 12), color: .black.opacity(0.36),width: 8, blur: 3)
                        //.innerShadow(using:  RoundedRectangle(cornerRadius: 12), color: .black.opacity(0.24), blur: 2)
                            //.blur(radius: 1)
                    )
            }
          // .shadow(color: Color("neonRectShadow"), radius: 4)
            .shadow(color: Color("neonRectShadow"), radius: 12)
          //  .shadow(color: Color("neonRectShadow"), radius: 4)
            //.shadow(color: Color("neonRectShadow"), radius: 12, x: 10, y: 10)
           //.shadow(color: Color("neonRectShadow"), radius: 2)
            .frame(width: 200, height: 200)
            .rotationEffect(.degrees(45))
       
            

        
         
            //.innerShadow(using:  RoundedRectangle(cornerRadius: 12), color: .black.opacity(0.2), blur: 2)
           // .innerShadow(using:  RoundedRectangle(cornerRadius: 12), color: .black.opacity(0.2), blur: 2)
          
           
            //.shadow(color: Color.black.opacity(0.1),radius: 32)
           
            //.blur(radius: 0.4)
           //.innerShadow(color: .black, radius: 1)
         
           
         
           // .shadow(color: Color("neonRectShadow"), radius: 8)
           //  .shadow(color: Color("neonRectShadow"), radius: 2)
           // .shadow(color: Color("neonRectShadow"), radius: 2)
            //.shadow(color: .black.opacity(0.25), radius: 4)
          
            
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
