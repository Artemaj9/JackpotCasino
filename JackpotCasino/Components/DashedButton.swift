//
//  DashedButton.swift
//  JackpotCasino
//
//  Created by Artem on 20.12.2023.
//

import SwiftUI

struct DashedButton: View {
    var body: some View {
     
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(style: StrokeStyle(lineWidth: 8, lineCap: .round, dash: [60, 20, 100, 20]))
                .foregroundColor(.white)
                .innerShadow3(using: RoundedRectangle(cornerRadius: 10),with: StrokeStyle( lineWidth: 8, lineCap: .round, dash: [60, 20, 100, 20]), angle: .zero, color: .black, width: 2, blur: 3)
              
            
            
            // .neonGlow()
            
            //.glow(color: Color( "lightBlueNeon"), radius: 2)
                .shadow(color: Color( "lightBlueNeon"), radius: 4)
                .shadow(color: Color( "lightBlueNeon"), radius: 4)
                .shadow(color: Color( "lightBlueNeon"), radius: 1)
            
                .shadow(color: Color.black.opacity(0.25), radius: 4)
                .frame(width: 300, height: 150)
        }
             
    }
}

struct DashedButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            DashedButton()
        }
    }
}
