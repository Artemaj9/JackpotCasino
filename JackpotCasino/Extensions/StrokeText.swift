//
//  StrokeText.swift
//

import SwiftUI

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color
    let mainColor: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            .font(Font.custom("RobotoCondensed-Bold", size: 64))
            
            Text(text)
                .foregroundColor(mainColor)
                .font(Font.custom("RobotoCondensed-Bold", size: 64))
        }
    }
}
