//
//  StrokedNeonText.swift
//

import SwiftUI

struct StrokedNeonText: View {
    
    let text: String
    let color: Color
    let shadowColor: Color
    let size: CGFloat
    
    var body: some View {
        VStack {
            OutlinedText(text: text, width: 1, color: .white, mainColor: color, font: Font.custom("RobotoCondensed-Bold", size:  size))
                .viewBorder(color: .white, radius: 0.15, outline: false)
                .drawingGroup()
                .shadow(color: shadowColor, radius: 8)

// Stroke with shadows!
//            Text("GOOD JOB!")
//                .font(Font.custom("RobotoCondensed-Bold", size: 64))
//
//                .viewBorder(color: .white, radius: 0.8, outline: false)
//                .overlay(content: {
//                    Text("GOOD JOB!")
//                        .font(Font.custom("RobotoCondensed-Bold", size: 64))
//                        .foregroundColor(Color("cherryText"))
//                })
//                .compositingGroup()
//                .shadow(color: shadowColor, radius: 6)
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
