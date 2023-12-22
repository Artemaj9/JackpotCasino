//
//  BrightButton.swift
//  JackpotCasino
//
//  Created by Artem on 19.12.2023.
//
import SwiftUI

struct BrightButton: View {
    
    let text: String
    let fontSize: CGFloat
    var padding: CGFloat = 8
    
    var body: some View {
        
        Text(text)
            .font(Font.custom("RobotoCondensed-Bold", size: fontSize))
            .foregroundColor(.white)
            .padding(.vertical, padding)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 8)
                .fill(Color("orangeBtn"))}
            .innerShadow(using: RoundedRectangle(cornerRadius: 8), angle: .zero, color: .white, width: 6, blur: 6)
            .compositingGroup()
            .shadow(color: Color("orangeBtnShadow").opacity(0.8), radius: 8)
            .shadow(color: Color("orangeBtnShadow").opacity(0.8), radius: 8)
    }
}


struct BrightButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView (showsIndicators: false) {
                VStack (spacing: 50) {
                    BrightButton(text: "BACK TO GAME", fontSize: 42)
                        .padding(.horizontal, 32)
                    
                    BrightButton(text: "TO MENU", fontSize: 42)
                        .padding(.horizontal, 32)
                    
                    BrightButton(text: "TAKE", fontSize: 42)
                        .padding(.horizontal, 32)
                    
                    BrightButton(text: "CONTINUE FOR 2500", fontSize: 33)
                        .padding(.horizontal, 32)
                    
                    BrightButton(text: "PLAY", fontSize: 34)
                        .padding(.horizontal, 64)
                    
                    BrightButton(text: "SPIN", fontSize: 34)
                        .padding(.horizontal, 64)
                    
                    BrightButton(text: "CLAIM", fontSize: 34)
                        .padding(.horizontal, 64)
                    
                    BrightButton(text: "CONTINUE", fontSize: 28)
                        .padding(.horizontal, 64)
                    
                    BrightButton(text: "NEXT", fontSize: 24)
                        .padding(.horizontal, 64)
                }
            }
        }
    }
}
