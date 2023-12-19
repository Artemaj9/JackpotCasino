//
//  StrokedNeonText.swift
//  JackpotCasino
//
//  Created by Artem on 19.12.2023.
//

import SwiftUI

struct StrokedNeonText: View {
    

    let text: String
    let shadowColor: Color
    let color: Color
    let size: CGFloat
    
    var body: some View {
      
        StrokeText(text: text, width: 2, color: .white, mainColor: color)
            .compositingGroup()
            .shadow(color: shadowColor, radius: 8)
        
    }
}

struct StrokedNeonText_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            StrokedNeonText(text: "GOOD JOB!", shadowColor: Color("cherryText"), color: Color("cherryText"), size: 12)
        }
    }
}
