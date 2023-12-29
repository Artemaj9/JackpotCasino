//
//  WinView.swift
//

import SwiftUI

struct WinView: View {
    
    @EnvironmentObject var logicModel: LogicModel
    @State var radians: Double = 0.5
    @State var saturation: Double = 0
    @State var textOpacity: Double = 0
    @State var degrees: Double = -35
    @State var radiusFactor: Double = 0
    @State var coinOneOffset: Double = 0
    @State var coinOneDegree: Double = 0
    @State var coinOffsetY: Double = 0
    @State var coinAngle: Double = 0
    @State var transitionOpacity: Double = 0
    
    var body: some View {
        ZStack {
            BackgroundView()
            CoinsView()
                .ignoresSafeArea()
 
            VStack(spacing: 24) {
                Image("star")
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        StrokedNeonText(text: "MEGA\nWIN", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 83)
                            .padding(.top)
                    )
                
                Image("goldRect")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .overlay(
                        HStack() {
                            Text(String(logicModel.balance))
                                .font(Font.custom("RobotoCondensed-Bold",size: 66))
                                .foregroundColor(.white)
                            
                            Image("coin")
                                
                        }
                            .shadow(color: Color("goldShadow"), radius: 4)
                            .shadow(color: Color("goldShadow"), radius: 2)
                            .offset(x: 16)
                    )
                Button {
                    withAnimation {
                        logicModel.firstStart = false
                    }
                }  label: {
                    BrightButton(text: "CLAIM", fontSize: 34)
                        .padding(.horizontal, 64)
                        .padding(.bottom, 32)
                }
            }
            .padding()
        }
        .onAppear {
            radians = 1
            saturation = 1
            degrees = -45
            radiusFactor = 1
            coinAngle = 360
            coinOffsetY = 5000
            transitionOpacity = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                coinOneOffset = 1200
                coinOneDegree = 390
                radians = 0
            }
          
        }
        .preferredColorScheme(.dark)
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView()
            .environmentObject(LogicModel())
    }
}
