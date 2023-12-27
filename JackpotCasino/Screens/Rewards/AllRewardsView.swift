//
//  AllRewardsView.swift
//

import SwiftUI

struct AllRewardsView: View {

   // @State var record: Int = 12
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: LogicModel
 
    var body: some View {
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
                            Text("CURRENT RECORD: \(vm.record)")
                                .font(Font.custom("RobotoCondensed-Medium", size: 27))
                                .foregroundColor(.white)
                        )
                    
                    Button {
                        dismiss()
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
                    ForEach (1..<4) { h in
                        HStack(spacing: 8) {
                            ForEach (1..<4) { w in
                                let i = w+(h - 1)*3
                                let lock = (i == 1) ?
                                vm.record < i : vm.record < (i - 1) * 5
                                
                                NavigationLink {
                                    if !lock {
                                        RewardsView(rewardScreen: i)
                                    }
                                } label: {
                                    
                                    RewardCell(index: i, isLocked: lock)
                                }
                                .allowsHitTesting(!lock)
                            }
                        }
                        .padding(8)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 20)
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
    }
}

struct AllRewardsView_Previews: PreviewProvider {
    static var previews: some View {
        AllRewardsView()
    }
}
