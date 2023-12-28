//
//  GoodJobView.swift
//  JackpotCasino
//
//  Created by Artem on 27.12.2023.
//

import SwiftUI

struct GoodJobView: View {
    
    @EnvironmentObject var gm: LogicModel
    @Environment(\.dismiss) var dismiss
    @State var rotation: Angle = .degrees(0)
    @State var opacity: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack {
                
              
                StrokedBgRect(lightningColor: Color("purpleEndNeon"), angle:.degrees(107), axis: (0, -0.8, 1),endDashPhase: 700)
                    .scaleEffect(0.75)
                    .offset(x: 100)

            
                StrokedBgRect(lightningColor: Color("yellowEndNeon"), angle:.degrees(90), axis: (1, 0.8, 1))
                    .scaleEffect(0.95)
                    .offset(x: -50, y: -100)
                StrokedBgRect(angle:.degrees(40), axis: (1, 1, -1))
                    .scaleEffect(0.95)
                    .offset(x: -50, y:0)
                
                StrokedBgRect(lightningColor: Color("greenEndNeon"),
                              angle:.degrees(-20), axis: (1, 0.9, -1))
                .scaleEffect(1)
                .offset(x: 120, y: -80)
            }
            
            VStack(spacing: 0) {
                StrokedNeonText(text: "GOOD JOB!", color: Color("cherryColor"), shadowColor: Color("cherryColor").opacity(0.4), size: 74)
                    .padding(.top)
                
                Text("YOU EARNED")
                    .foregroundColor(.white)
                    .font(Font.custom("RobotoCondensed-Bold", size: 50))
                
                Image("gjRect")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .overlay(
                        HStack() {
                            StrokedNeonText(text: "2000", color: Color("cherryColor"), shadowColor: Color("cherryColor").opacity(0.4), size: 74)
                                .offset(x: 16)
                            
                        
                               
                            Image("coin")
                                .rotation3DEffect(rotation, axis: (x: 0, y: 1, z: 0))
                                .onTapGesture {
                                    withAnimation {
                                       
                                        rotation =  rotation == .degrees(0) ? .degrees(360) : .degrees(0)
                                    }
                                }
                                
                            
                        }
                            .opacity(opacity)
                            
                    )
                Button {
                    gm.balance += 2000
                    dismiss()
                    gm.isWinEnd = false
                } label: {
                    BrightButton(text: "TAKE", fontSize: 42)
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                }
            }
        }
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
                rotation = .degrees(360)
            
            }
            withAnimation(.easeIn(duration: 0.4).delay(0.3)) {
                opacity = 1
            }
        }
    }
}

struct GoodJobView_Previews: PreviewProvider {
    static var previews: some View {
        GoodJobView()
    }
}
