//
//  DashedButton.swift
//  JackpotCasino
//
//  Created by Artem on 20.12.2023.
//

import SwiftUI

struct DashedButton: View {
    
    var color: Color
    var dash: [CGFloat] = [60, 30, 100, 20]
    var text: String = "OK"
    var padding: CGFloat = 8
    var fontSize: CGFloat = 21
    
    @State var dashPhase: CGFloat = 0
    
    var body: some View {
        
        Text(text)
            .foregroundColor(.white)
            .font(Font.custom("RobotoCondensed-Medium", size: fontSize))
            .padding(.vertical, padding)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [60, 30, 100, 20], dashPhase: dashPhase))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: dash, dashPhase: dashPhase))
                            .foregroundColor(.blue)
                            .blur(radius: 2)
                            .mask(RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: dash, dashPhase: dashPhase)))
                    })
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: dash, dashPhase: dashPhase))
                    })
                    .foregroundColor(.white)
                    .neonInnerShadow(1, opacity: 0.8)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white.opacity(0.02))
                    }
                
                    .shadow(color: color, radius: 4)
                    .shadow(color: color, radius: 4)
                    .shadow(color: color, radius: 1)
                
                    .shadow(color: Color.black.opacity(0.25), radius: 4)
                
            }
        
            .onAppear {
                withAnimation(Animation.linear(duration: 120)) {
                    dashPhase = 1500
                }
            }
    }
}

struct DashedButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            VStack(spacing: 50) {
                DashedButton(color: Color( "lightBlueNeon"))
                    .frame(width: 300, height: 150)
                DashedButton(color: Color( "lightGreenNeon"))
                    .frame(width: 300, height: 150)
                Spacer()
                DashedButton(color: Color( "lightPinkNeon"), dash: [40, 30, 25, 10])
                    .frame(width: 100, height: 30)
                DashedButton(color: Color( "lightPinkNeon"), dash: [40, 30, 25, 10])
                    .frame(width: 194, height: 50)
            }
        }
    }
}
