//
//  FiredView.swift
//  JackpotCasino
//
//  Created by Artem on 27.12.2023.
//

import SwiftUI

struct FiredView: View {
    
    @EnvironmentObject var gm: LogicModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            VStack {
                StrokedBgRect(lightningColor: .red)
                    .scaleEffect(0.78)
                    .offset(x: 190)
                StrokedBgRect(lightningColor: .red, angle:.degrees(-70), axis: (1, 0, 1))
                    .scaleEffect(0.75)
                    .offset(x: -120, y: 0)
                StrokedBgRect(lightningColor: .red,angle:.degrees(-60), axis: (1, 1, -1))
                    .offset(x: 100, y: 80)
                StrokedBgRect(lightningColor: .red,
                              angle:.degrees(60), axis: (1, 1, 0))
                    .scaleEffect(1)
                    .offset(x: -10, y: -150)
            }
                VStack(spacing: 0) {
                    StrokedNeonText(text: "YOU FIRED!", color: Color("cherryColor"), shadowColor: Color("cherryColor").opacity(0.4), size: 74)
                        .padding(.top)
                    BrightButton(text: "TO MENU", fontSize: 42)
                        .padding(.horizontal, 40)
            }
        }
    }
}

struct FiredView_Previews: PreviewProvider {
    static var previews: some View {
        FiredView()
    }
}
