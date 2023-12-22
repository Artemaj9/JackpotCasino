//
//  DashedMenuBtn.swift
//  JackpotCasino
//
//  Created by Artem on 22.12.2023.
//

import SwiftUI

struct DashedMenuBtn: View {
    
    var color: Color
    var dash: [CGFloat] = [60, 30, 100, 20]
    var text: String = "TRAINING MODE"
    var padding: CGFloat = 8
    var fontSize: CGFloat = 21
    
    @State var dashPhase: CGFloat = CGFloat(Int.random(in: 10...100))
    
    var body: some View {
        StrokedNeonText(text: text, color: Color("greenMenu"), shadowColor: Color("greenMenuShadow"), size: 30)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [60, 30, 100, 20], dashPhase: dashPhase))
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.02))
                    }
                    .shadow(color: Color.black.opacity(0.25), radius: 4)
                    .shadow(color: color, radius: 4)
                    .shadow(color: color, radius: 4)
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 120)) {
                    dashPhase = 1500
                }
            }
    }
}

struct DashedMenuBtn_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            VStack(spacing: 50) {
                DashedMenuBtn(color: Color( "lightBlueNeon"))
                    .frame(width: 300, height: 150)
                DashedMenuBtn(color: Color( "lightGreenNeon"))
                    .frame(width: 300, height: 150)
                Spacer()
                DashedMenuBtn(color: Color( "lightPinkNeon"), dash: [40, 30, 25, 10])
                    .frame(width: 100, height: 30)
                DashedMenuBtn(color: Color( "lightPinkNeon"), dash: [40, 30, 25, 10])
                    .frame(width: 194, height: 50)
            }
        }
    }
}

