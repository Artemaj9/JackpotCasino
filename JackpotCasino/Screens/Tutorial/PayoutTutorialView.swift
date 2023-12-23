//
//  Payout.swift
//  JackpotCasino
//
//  Created by Artem on 23.12.2023.
//

import SwiftUI

private let chips = [1, 5, 100, 500]

struct PayoutTutorial: View {
    var body: some View {
        ZStack {
            BackgroundView()
            Image("table")
                .resizable()
                .offset(y: 150)
            VStack() {
                BrightButton(text: "CONTINUE", fontSize: 28)
                    .padding(.horizontal, 64)
                    .padding()
                DashedMenuBtn(color: Color( "lightPinkNeon"), dash: [40, 30, 25, 10], text: "2500")
                    .padding(.horizontal, 84)
            
                  
                Spacer()
            }
            VStack(spacing: 50) {
                Spacer()
                Spacer()
                NeonRectangle()
                    .offset(y: 60)
                    .overlay(
                    Text("DRAG\nHERE")
                    .font(Font.custom("RobotoCondensed-Bold",size: 64))
                          )
                
                Spacer()
             
                HStack() {
                    ForEach(chips, id: \.self) { i in
                        Image("chip\(i)")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            Image("timer")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.3)
                .overlay {
                    Text("10")
                        .foregroundColor(.white)
                        .font(Font.custom("RobotoCondensed-Bold",size: 33))
                }
                .offset(x: 158, y: -75)
            HStack {
                Image("chip500")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.35)
                    .offset(x: -80, y: 150)
                    
                    
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct Payout_Previews: PreviewProvider {
    static var previews: some View {
        PayoutTutorial()
    }
}
