//
//  WelcomeView.swift
//

import SwiftUI

struct WelcomeView: View {
    
    @State var count = 10
    @State var spin: Double = 0
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                StrokedNeonText(text: "WELCOME!", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 77)
                    .padding(.top, 32)
                
                ZStack {
                    ForEach(0..<count, id: \.self) { index in
                        
                        let angle1 = Angle(degrees: Double(index * 360) / Double(count))
                        let angle2 = Angle(degrees: Double((index + 1) * 360) / Double(count))
                        let angle3 = Angle(degrees: (angle1.degrees + angle2.degrees) / 2)
                        Pie(startAngle: angle1, endAngle: angle2)
                            .stroke(lineWidth: 4)
                            .fill(.white)
                            .shadow(color: Color("wheelShadow"), radius: 2)
                            .shadow(color: Color("wheelShadow"), radius: 2)
                        
                       
                    }
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 6)
                            .shadow(color: Color("wheelShadow").opacity(0.2), radius: 4)
                           //.glow(color: Color("wheelShadow"), radius: 1)
                    }
                    
                    
                    Circle()
                        .shadow(color: Color("wheelShadow"), radius: 1)
                        .frame(width: 48, height: 48)
                    
                    ForEach(0..<count, id: \.self) { index in
                        HStack {
                            Text(String(100*index))
                                .font(Font.custom("RobotoCondensed-Bold", size:  24))
                              
                
                            Image("coin")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        .rotationEffect(Angle(radians:  Double(2 * index + 1) * .pi/Double(count)), anchor: .center)
                            .offset(x: 130 * cos( Double(2 * index + 1) * .pi/Double(count)), y: 130 * sin(Double(2 * index + 1) * .pi/Double(count)))
                    }
                }
                .padding(.horizontal)
               // .compositingGroup()
                .rotationEffect(.radians(-.pi/2))
                .rotationEffect(.degrees(spin), anchor: .center)
                
                Button {
                    withAnimation(.spring(response: 4, dampingFraction: 0.7)) {
                        spin += Double.random(in: 360...360*2)
                    }
                }  label: {
                    BrightButton(text: "SPIN", fontSize: 34)
                        .padding(.horizontal, 64)
                        .padding(.bottom, 32)
                }
              
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}