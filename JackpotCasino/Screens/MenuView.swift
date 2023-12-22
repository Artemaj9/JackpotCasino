//
//  MenuView.swift
//  JackpotCasino
//
//  Created by Artem on 22.12.2023.
//

import SwiftUI

private let gradient  = LinearGradient(colors: [Color("questGradLight"), Color("questGradBright")], startPoint: .bottomLeading, endPoint: .topTrailing)

struct MenuView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 4)
                    .innerShadow(using:    RoundedRectangle(cornerRadius: 8), angle: .radians(0), color: .black.opacity(0.25), width: 1, blur: 1)
                    .shadow(color: .black.opacity(0.25), radius: 1)
                    .shadow(color: Color("menuRectShadow"), radius: 4)
                    .shadow(color: Color("menuRectShadow"), radius: 2)
                 
                    
                    .frame(height: 50)
                    .overlay {
                        HStack {
                        Text("5000")
                                .font(Font.custom("RobotoCondensed-Bold",size: 27))
                        Image("coin")
                            .resizable()
                            .scaledToFit()
                                }
                    }
                 
                RoundedRectangle(cornerRadius: 8)
                    .fill(gradient)
                    .shadow(color: Color("questGradBright"), radius: 8)
    
                    .frame(width: 50,height: 50)
                    .overlay(
                    Image("quest")
                        .resizable()
                        .scaledToFit()
                        .padding(10))
                    
            }
            .padding(20)
        }
        .preferredColorScheme(.dark)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
