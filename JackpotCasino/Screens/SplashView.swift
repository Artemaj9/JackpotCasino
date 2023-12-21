//
//  SplashView.swift
//

import SwiftUI

struct SplashView: View {
    
    let gradient = LinearGradient(colors: [Color("splashLightGrad"), Color("splashDarkGrad")], startPoint:.top , endPoint: .bottom)
    @State var logoSize: CGSize = .zero
    @State var glowRadius: CGFloat = 4
    @State var lightOpacity: CGFloat = 0
    
    var body: some View {
        ZStack {
            BackgroundView()
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 3)
                    .glow(color: Color.white, radius: 9)
                    .shadow(color: Color("wheelShadow"), radius: 10)
            
                Ellipse()
                    .fill(Color.white)
                    .glow(color: Color("wheelShadow"), radius: glowRadius)
                    .shadow(color: Color.white, radius: 4)
                    .shadow(color: Color("wheelShadow"), radius: 8)
                    .animation(.spring(response: 2, dampingFraction: 0.7, blendDuration: 0.4), value: glowRadius)
                    .frame(width: logoSize.height*1.1, height: 180)
                        
                        Ellipse()
                            .fill(gradient)
                            .foregroundColor(.gray)
                            .frame(width: logoSize.height, height: 160)
                    
                
                VStack(spacing: 0) {
                    Image("rhombusUp")
                        .resizable()
                        .shadow(color: Color(.white), radius: 1, y: -3)
                        .shadow(color: Color("wheelShadow"), radius: 1, y: -1)
                    
                    Image("rhombusDown")
                        .resizable()
                        .shadow(color: Color(.white), radius: 1, y: 3)
                        .shadow(color: Color("wheelShadow"), radius: 1, y: 1)
                }
                
                VStack(spacing: 0) {
                    Image("rhombusUp")
                        .resizable()
                        .shadow(color: Color(.white), radius: 2, y: -3)
                        .shadow(color: Color(.white), radius: 2, y: -3)
                       // .shadow(color: Color.white, radius: 2, y: -4)
                        .shadow(color: Color("wheelShadow"), radius: 1, y: -4)
                    
                    Image("rhombusDown")
                        .resizable()
                        .shadow(color: Color(.white), radius: 2, y: 3)
                        .shadow(color: Color(.white), radius: 2, y: 3)
                        .shadow(color: Color("wheelShadow").opacity(1), radius: 1, y: 4)
                        
                }
                .scaleEffect(0.77)
            }
            .padding()
            .frame(height: logoSize.height*1.1)
            
            VStack(spacing: 0) {
                        StrokedNeonText(text: "JACKPOT", color: Color("blueText"), shadowColor: Color("blueTextShadow" ), size: 55, shadowRadius: 3)
                            .offset(y: 16)
                
                Image("casino")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 290, height: 67)
                    .offset(y: -2)
                
                StrokedNeonText(text: "HIGH STAKES", color: Color("blueText"), shadowColor: Color("blueTextShadow"), size: 48, shadowRadius: 3)
                    .offset(y: -16)
            }
           
            .onAppear {
                glowRadius = 5
            }
            .background {
                GeometryReader { geo in
                    Color.clear.onAppear {
                        self.logoSize = geo.size
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
