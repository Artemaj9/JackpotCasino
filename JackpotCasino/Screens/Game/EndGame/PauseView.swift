//
//  PauseView.swift
//  JackpotCasino
//
//  Created by Artem on 27.12.2023.
//

import SwiftUI

struct PauseView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            VStack {
                VStack {
                    StrokedNeonText(text: "PAUSE", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 100)
                        .padding(.top)
                    BrightButton(text: "BACK TO GAME", fontSize: 42)
                        .padding(40)
                    Button {
                       // dismiss()
                    } label: {
                        DashedButton(color: Color( "lightBlueNeon"), text: "TO MENU", padding: 12, fontSize: 24, font: Font.custom("RobotoCondensed-Medium", size: 27))
                    }
                    .padding(.horizontal, 40)
                    .padding(.horizontal, 24)
                }
            }
            .padding()
        }
    }
}

struct PauseView_Previews: PreviewProvider {
    static var previews: some View {
        PauseView()
    }
}
