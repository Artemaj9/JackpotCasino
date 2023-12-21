//
//  WelcomeView.swift
//

import SwiftUI

struct WelcomeView: View {
    
    @State var count = 10
    @State private var spin: Double = 0
    @State private var wheelSize: CGSize = .zero
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Spacer()
                StrokedNeonText(text: "WELCOME!", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 77)
                    .padding(.top)

                ZStack {
                    Triangle()
                        .rotationEffect(.degrees(180), anchor: .center)
                        .shadow(color: Color("blueTextShadow"), radius: 4)
                        .shadow(color: Color("blueTextShadow"), radius: 4)
                        .frame(width: 60, height: 20)
                        .offset(x: 30, y: (-wheelSize.width - 4)/2)
                    
                    Triangle()
                        .rotationEffect(.degrees(180), anchor: .center)
                        .shadow(color: Color("blueTextShadow"), radius: 4)
                        .shadow(color: Color("blueTextShadow"), radius: 4)
                        .frame(width: 60, height: 20)
                        .offset(x: -30, y: (-wheelSize.width - 4) / 2)
                    
                    ZStack {
                        ForEach(0..<count, id: \.self) { index in
                            let angle1 = Angle(degrees: Double(index * 360) / Double(count))
                            let angle2 = Angle(degrees: Double((index + 1) * 360) / Double(count))
                            
                            Pie(startAngle: angle1, endAngle: angle2)
                                .fill(Color("wheelColor"))
                            
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
                        }
                        
                        Circle()
                            .shadow(color: Color("wheelShadow"), radius: 1)
                            .frame(width: 48, height: 48)
                        
                        ForEach(0..<count, id: \.self) { index in
                            HStack {
                                let text = index == 0 ? "250" :
                                index == 9 ? "5000" : String(500*index)
                                
                                Text(text)
                                    .font(Font.custom("Roboto-Bold", size: 24))
                                    .shadow(color: Color("blueTextShadow"), radius: 2)
                                    .shadow(color: Color("blueTextShadow"), radius: 1)
                                    .overlay(Text(text)
                                        .font(Font.custom("Roboto-Bold", size:  24)))
                                
                                Image("coin")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            .rotationEffect(Angle(radians:  Double(2 * index + 1) * .pi/Double(count)), anchor: .center)
                            .offset(x: wheelSize.width / 3 * cos( Double(2 * index + 1) * .pi/Double(count)), y: wheelSize.width / 3 * sin(Double(2 * index + 1) * .pi/Double(count)))
                        }
                    }
                    .background(
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                self.wheelSize = geo.size
                            }
                        }
                    )
                    .padding(.horizontal)
                    .rotationEffect(.radians(-.pi/2))
                    .rotationEffect(-.degrees(spin), anchor: .center)
                    
                    Triangle()
                        .shadow(color: Color("blueTextShadow"), radius: 4)
                        .shadow(color: Color("blueTextShadow"), radius: 4)
                        .frame(width: 60, height: 50)
                        .offset(y: (-wheelSize.width + 24)/2)
                }
                
                Button {
                    withAnimation(.spring(response: 4, dampingFraction: 0.7)) {
                        spin = Double.random(in: 360...360*2)
                    }
                    print("Spin:\(spin)")
                let index = (Int(spin) % 360)/36
                let text = index == 0 ?
                    "250" : index == 9 ? "5000" : String(500*index)
                    
                    print("Ваш выигрыш " + text)
                }  label: {
                    BrightButton(text: "SPIN", fontSize: 34)
                        .padding(.horizontal, 64)
                        .padding(.bottom, 32)
                }
                Spacer()
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
