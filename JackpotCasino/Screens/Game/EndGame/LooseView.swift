//
//  LooseView.swift
//  JackpotCasino
//
//  Created by Artem on 27.12.2023.
//

import SwiftUI

struct LooseView: View {
    @State var size: CGSize = .zero
    @EnvironmentObject var gm: LogicModel
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            VStack {
                
                StrokedBgRect(lightningColor: Color("greenEndNeon"),
                              angle:.degrees(20), axis: (1, 1, -1))
                
                    .scaleEffect(0.7)
                    .offset(x: 80)
                StrokedBgRect( angle:.degrees(40), axis: (-1, 0.8, 1))
                    .scaleEffect(0.6)
                    .offset(x: -70, y: -250)
                Spacer()
            }
            .offset(y: -20)
            
                VStack(spacing: 0) {
                    Text("YOU RUN OUT OF LIVES!")
                        .foregroundColor(.white)
                        .font(Font.custom("RobotoCondensed-Bold", size: 24))
                    StrokedNeonText(text: "DO YOU WANT TO CONTINUE?", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 46)
                        //.padding(.top)
                    BrightButton(text: "CONTINUE FOR 2500", fontSize: size.width < 380 ? 27 : 33)
                        .padding([.horizontal, .bottom] , 44)
                        .padding(.top, 16)
                    Button {
                       // dismiss()
                    } label: {
                        DashedButton(color: Color( "lightBlueNeon"), text: "TO MENU", padding: 12, fontSize: 27, font: Font.custom("RobotoCondensed-Medium", size: 27))
                    }
                    .padding(.horizontal, 40)
                    .padding(.horizontal, 24)
                }
           .padding()
        }
    }
}

struct LooseView_Previews: PreviewProvider {
    static var previews: some View {
        LooseView()
    }
}
