//
//  SplashView.swift
//

import SwiftUI

struct SplashView: View {
    
    let gradient = LinearGradient(colors: [Color("splashLightGrad"), Color("splashDarkGrad")], startPoint:.topLeading , endPoint: .bottomTrailing)
    var body: some View {
        ZStack {
         //   GeometryReader { geo in
            BackgroundView()
          
                
                ZStack {
                    Rectangle()
                        .fill(gradient)
                        .foregroundColor(.gray)
                        
                        .frame(width: 170, height: 190)
                        .rotationEffect(.degrees(50))
                        
                    VStack(spacing: 0) {
                        Image("rhombusUp")
                            .resizable()
                            .shadow(color: Color(.white), radius: 2)
                            .shadow(color: Color(.white), radius: 2)
                            .shadow(color: Color("wheelShadow"), radius: 6)
                            .shadow(color: Color("wheelShadow"), radius: 6)
                        Image("rhombusDown")
                            .resizable()
                            .shadow(color: Color(.white), radius: 2)
                            .shadow(color: Color(.white), radius: 2)
                            .shadow(color: Color("wheelShadow"), radius: 6)
                            .shadow(color: Color("wheelShadow"), radius: 6)
                    }
                    
                    VStack(spacing: 0) {
                        Image("rhombusUp")
                            .resizable()
                            .shadow(color: Color(.white), radius: 2)
                            .shadow(color: Color(.white), radius: 2)
                            .shadow(color: Color("wheelShadow"), radius: 6)
                            .shadow(color: Color("wheelShadow"), radius: 6)
                        Image("rhombusDown")
                            .resizable()
                            .shadow(color: Color(.white), radius: 2)
                            .shadow(color: Color(.white), radius: 2)
                            .shadow(color: Color("wheelShadow"), radius: 6)
                            .shadow(color: Color("wheelShadow"), radius: 6)
                    }
                    .scaleEffect(0.75)
                }
                .padding()
                .frame(height: 274)
                //            VStack {
                //              // для Splash не нужно
                //                /* StrokedNeonText(text: "WELCOME TO", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 77)
                //                    .padding(.top)
                //                 */
                //
                //
                //                StrokedNeonText(text: "JACKPOT", color: Color("blueText"), shadowColor: Color("blueTextShadow" ), size: 55, shadowRadius: 3)
                //                Image("casino")
                //                    .resizable()
                //                    .scaledToFill()
                //                    .frame(width: 290, height: 67)
                //                StrokedNeonText(text: "HIGH STAKES", color: Color("blueText"), shadowColor: Color("blueTextShadow"), size: 48, shadowRadius: 3)
                //            }
                
                
            }
       // }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
