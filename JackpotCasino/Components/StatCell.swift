//
//  StatCell.swift
//  JackpotCasino
//
//  Created by Artem on 24.12.2023.
//

import SwiftUI

struct StatCell: View {
    
    let title: String
    let color: Color
    let num: Int
    var alignment: HorizontalAlignment = .leading
    
    var body: some View {
        VStack(alignment: alignment, spacing: 8) {
            Text(title)
                .foregroundColor(.white)
                .font(Font.custom("RobotoCondensed-Medium", size: 21))
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color("statBg").opacity(0.5))
                    .frame(width: 58, height: 36)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(color, lineWidth: 2)
                    )
                Text(String(num))
                    .foregroundColor(.white)
                    .font(Font.custom("RobotoCondensed-Bold", size: 21))
            }
        }
    }
}

struct StatCell_Previews: PreviewProvider {
    static var previews: some View {
        StatCell(title: "Player's Hand", color: Color("redNeon"), num: 7)
    }
}
