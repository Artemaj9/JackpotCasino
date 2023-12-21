//
//  AllRewardsView.swift
//

import SwiftUI

struct AllRewardsView: View {
    
    @State var record: Int = 12
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Color.clear
                            .frame(width: 40, height: 50)
                       RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth:4)
                            .shadow(color: Color("titleShadow"), radius: 4)
                            .shadow(color: Color("titleShadow"), radius: 1)
                         
                            .frame(height: 48)
                            .overlay(
                            Text("CURRENT RECORD: \(record)")
                                .font(Font.custom("RobotoCondensed-Medium", size: 27))
                                .foregroundColor(.white)
                            )
                            
                        Button {
                            
                        } label: {
                            ZStack {
                                Circle()
                                    .fill( Color.purple.opacity(0.001))
                                    .frame(width: 50, height: 50)
                                Image("back")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                            
                        }
                    }
                    .padding(.vertical)
                    
                    VStack {
                        Text("REWARDS")
                            .font(Font.custom("RobotoCondensed-Medium", size: 42))
                            .foregroundColor(.white)
                        Text("Сlick to find out details and conditions\nfor receiving the award")
                            .multilineTextAlignment(.center)
                            .font(Font.custom("RobotoCondensed-Medium", size: 18))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    VStack {
                        HStack(spacing: 8) {
                            RewardCell(index: 1)
                            RewardCell(index: 2)
                            RewardCell(index: 3)
                        }
                        .padding(8)
                        HStack(spacing: 8) {
                            RewardCell(index: 4)
                            RewardCell(index: 5)
                            RewardCell(index: 6)
                        }
                        .padding(8)
                        HStack(spacing: 8) {
                            RewardCell(index: 7)
                            RewardCell(index: 8)
                            RewardCell(index: 9)
                        }
                        .padding(8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    Spacer()
                }
            }
            .preferredColorScheme(.dark)
        }
        .navigationViewStyle(.stack)
    }
}

struct AllRewardsView_Previews: PreviewProvider {
    static var previews: some View {
        AllRewardsView()
    }
}
