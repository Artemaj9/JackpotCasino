//
//  GameModeView.swift
//

import SwiftUI

struct GameModeView: View {
    
    @Binding var selected: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.red.opacity(0.01), lineWidth: 4)
                .offset(x: -2)
                .frame(width: 314, height: 42)
                .shadow(color: Color("modeShadow"), radius: 8)
                .shadow(color: Color("modeShadow"), radius: 8)
            
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color(selected == 1 ? "orangeBtn" : "pinkBg"))
                    .border(Color("lavandBord"), width: 2)
                    .cornerRadius(6, corners: [.bottomLeft, .topLeft])
                    .overlay(
                        Text("Deal")
                            .foregroundColor(.white)
                            .font(Font.custom("RobotoCondensed-Medium",size: 21))
                    )
                    .animation(.easeInOut, value: selected)
                
                Rectangle()
                    .fill(Color(selected == 2 ? "orangeBtn" : "pinkBg"))
                    .border(Color("lavandBord"), width: 2)
                    .overlay(
                        Text("Hit")
                            .foregroundColor(.white)
                            .font(Font.custom("RobotoCondensed-Medium",size: 21))
                    )
                    .animation(.easeInOut, value: selected)
                    .offset(x: -2)
                
                Rectangle()
                    .fill(Color(selected == 3 ? "orangeBtn" : "pinkBg"))
                    .border(Color("lavandBord"), width: 2)
                    .overlay(
                        Text("Stand")
                            .foregroundColor(.white)
                            .font(Font.custom("RobotoCondensed-Medium",size: 21))
                    )
                    .offset(x: -4)
                    .animation(.easeInOut, value: selected)
                
                Rectangle()
                    .fill(Color(selected == 4 ? "orangeBtn" : "pinkBg"))
                    .border(Color("lavandBord"), width: 2)
                    .cornerRadius(6, corners: [.bottomRight, .topRight])
                    .overlay(
                        Text("Double")
                            .foregroundColor(.white)
                            .font(Font.custom("RobotoCondensed-Medium",size: 21))
                    )
                    .animation(.easeInOut, value: selected)
                    .offset(x: -6)
                Color.clear
                    .frame(width: 18)
            }
            .offset(x: 9)
            .frame(width: 339, height: 42)
            .padding()
        }
        
    }
}

struct GameModeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            GameModeView(selected: .constant(1))
        }
    }
}
