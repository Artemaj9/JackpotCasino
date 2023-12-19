//
//  BrightButton.swift
//  JackpotCasino
//
//  Created by Artem on 19.12.2023.
//
import SwiftUI

struct BrightButton: View {
    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            
            Text("SPIN")
                .font(Font.custom("RobotoCondensed-Bold", size: 34))
                .foregroundColor(.white)
                .padding(.vertical, 16)
                .padding(.horizontal, 54)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("orangeBtn"))
                        .innerShadow(color: .white, radius: 0.14)
                        .blur(radius: 3)
                        .cornerRadius(8)
                        .compositingGroup()
                        .shadow(color:Color("orangeBtn").opacity(0.8), radius: 12)
                }
        }
    }
}


struct BrightButton_Previews: PreviewProvider {
    static var previews: some View {
        BrightButton()
    }
}
