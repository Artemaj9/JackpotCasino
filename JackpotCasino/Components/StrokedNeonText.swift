//
//  StrokedNeonText.swift
//

import SwiftUI

struct StrokedNeonText: View {
    
    let text: String
    let color: Color
    let shadowColor: Color
    let size: CGFloat
    var shadowRadius: CGFloat = 8
    var stroke: CGFloat = 1
    
    var body: some View {
        VStack {
            OutlinedText(text: text, width: stroke, color: .white, mainColor: color, font: Font.custom("RobotoCondensed-Bold", size:  size))
                .viewBorder(color: .white, radius: 0.15, outline: false)
                .drawingGroup()
                .shadow(color: shadowColor, radius: shadowRadius)
        }
    }
}

struct StrokedNeonText_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            Color.black.ignoresSafeArea()
            
            StrokedNeonText(text: "WELCOME!", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 64)
        }
    }
}
