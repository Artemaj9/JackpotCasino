//
//  GameHeaderCell.swift
//  JackpotCasino
//
//  Created by Artem on 25.12.2023.
//

import SwiftUI

struct GameHeaderCell: View {
    
    let image: String
    
    var text: String
    var dashPhase: CGFloat = 0
    var color = Color("lightPinkNeon")
    var body: some View {
   
        RoundedRectangle(cornerRadius: 6)
            .strokeBorder(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [60, 30, 100, 20], dashPhase: dashPhase))
            .foregroundColor(Color("whitePink"))
            .shadow(color: color, radius: 4)
            .shadow(color: color, radius: 4)
            .overlay(
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color("whitePink"))
                        .frame(width: 36)
                        .cornerRadius(6, corners: [.bottomLeft, .topLeft])
                       
                        .shadow(color: color, radius: 4)
                       .shadow(color: color, radius: 2)
                        .overlay {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(1)
                           
                        }
                    Rectangle()
                        .fill(Color("pinkBg"))
                        .shadow(color: color, radius: 1, x: -5)
                        .cornerRadius(10, corners: [.bottomRight, .topRight])
                        .overlay {
                            Text(text)
                                .foregroundColor(.white)
                                .font(Font.custom("RobotoCondensed-Bold",size: 20))
                        }
                       
                })
            .frame(width: 100, height: 36)
        
    }
}

struct GameHeaderCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            HStack {
                GameHeaderCell(image: "heart", text: "10")
                GameHeaderCell(image: "watches", text: "03:00")
            }
        }
    }
}
