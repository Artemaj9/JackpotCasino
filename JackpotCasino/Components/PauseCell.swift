//
//  PauseCell.swift
//  JackpotCasino
//
//  Created by Artem on 25.12.2023.
//

import SwiftUI

struct PauseCell: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(gradient)
                .shadow(color: Color("questGradBright"), radius: 8)
            
                .frame(width: 36,height: 36)
                .overlay(
                    Image("pause")
                        .resizable()
                        .scaledToFit()
                        .padding(10))
            VStack(alignment: .trailing) {
                Text("Mode")
                    .font(Font.custom("RobotoCondensed-LightItalic",size: 14))
                Text("Payout")
                    .font(Font.custom("RobotoCondensed-MediumItalic",size: 18))
            }
            .foregroundColor(.white)
        }
    }
}

private let gradient  =
LinearGradient(colors: [Color("questGradLight"), Color("questGradBright")], startPoint: .leading, endPoint: .trailing)

struct PauseCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            PauseCell()
        }
    }
}
