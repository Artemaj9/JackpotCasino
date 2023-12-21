//
//  AwardsView.swift
//  JackpotCasino
//
//  Created by Artem on 21.12.2023.
//

import SwiftUI

struct RewardsView: View {
    
    let rewardScreen: Int
    
    var body: some View {
        ZStack {
            BackgroundView()
           
            VStack(spacing: 34) {
            StrokedNeonText(text: "FIRST DAY\nREWARD", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 64)
                ZStack {
                    RewardShape()
                        .fill(Color("r\(rewardScreen)Bg").opacity(0.15))
                    RewardShape()
                        .stroke(lineWidth: 4)
                    
                        .foregroundColor(.white)
                    
                        .shadow(color: Color("r\(rewardScreen)Bg"), radius: 2)
                        .shadow(color: Color("r\(rewardScreen)Bg"), radius: 2)
                      
                    VStack {
                        Image("reward\(rewardScreen)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 80)
                        StrokedNeonText(text: "CHERRY\nCASCADE", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 27)
                            .offset(y: 36)
                        Text("A chance cherry on the card shoe brought unexpected luck to the dealer. They became the Cherry Cascade Conductor, orchestrating a magical dance of wins that turned each deal into casino legend.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(Font.custom("RobotoCondensed-Medium", size: 20))
                            .padding()
                    }
                    .offset(y: 18)
                }
                .frame(maxHeight: 400)
                .padding(.horizontal, 20)
            }
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView(rewardScreen: 7)
    }
}
