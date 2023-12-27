//
//  PauseView.swift
//  JackpotCasino
//
//  Created by Artem on 27.12.2023.
//

import SwiftUI

struct PauseView: View {
    @State var size: CGSize = .zero
    @EnvironmentObject var gm: LogicModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .background(
                    GeometryReader() { geo in
                        Color.clear.onAppear {
                            self.size = geo.size
                            print("width:  \(size.width)")
                            print("height: \(size.height)")
                        }
                        })
            VStack {
                
                StrokedBgRect(lightningColor: Color("greenEndNeon"),
                              angle:.degrees(40), axis: (1, 1, -1))
                
                .scaleEffect(0.8)
                .offset(x: 90, y: 0)
                StrokedBgRect(lightningColor: Color("yellowEndNeon"), angle:.degrees(90), axis: (1, 0.8, 1))
                    .scaleEffect(0.95)
                    .offset(x: -50, y: -200)
            }
            .offset(y: -100)
            
            VStack {
                VStack {
                    StrokedNeonText(text: "PAUSE", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 100)
                        .padding(.top)
                    Button {
                        gm.isPaused = false
                    } label: {
                        BrightButton(text: "BACK TO GAME", fontSize: size.width < 380  ? 34 : 42)
                        .padding(40)
                    }
                    Button {
                        gm.isPaused = false
                        gm.cancelAllTimers()
                        dismiss()
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
