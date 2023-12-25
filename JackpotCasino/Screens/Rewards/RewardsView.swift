//
//  AwardsView.swift
//

import SwiftUI

struct RewardsView: View {
    
    @State var shapeWidth: CGFloat = 0
    @State var lineOpacity: CGFloat = 0.08
    @Environment(\.dismiss) var dismiss
    let rewardScreen: Int
   
    var body: some View {
        ZStack {
            BackgroundView()
            ForEach(-2..<4) { index in
                Rectangle()
                    .fill(Color("r\(rewardScreen)Bg").opacity(lineOpacity))
                    .frame(width: 6)
                    .scaleEffect(4)
                    .rotationEffect(Angle.radians(-.pi/6))
                    .offset(y: index > 0 ? (CGFloat(index * 90) + 200) : (CGFloat((index-1) * 90) - 200))
            }

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        lineOpacity = 0
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill( Color.purple.opacity(0.001))
                                .frame(width: 50, height: 50)
                            Image("back")
                                .resizable()
                                .frame(width: 36, height: 36)
                        }
                            
                    }
                }
                .padding(.horizontal, 20)
               
                
           
            VStack(spacing: 34) {
                StrokedNeonText(text: rewardModel[rewardScreen-1].largeTitle, color: Color("purpleText"), shadowColor: Color("purpleText"), size: 50)
                ZStack {
                    RewardShape()
                        .fill(Color("r\(rewardScreen)Bg").opacity(0.15))
                        .background(
                            GeometryReader() { geo in
                                Color.clear.onAppear {
                                    shapeWidth = geo.size.width
                                    print(shapeWidth)
                                }
                                
                            }
                            )
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
                            .offset(y: shapeWidth < 340 ? 8 : 18 )
                        StrokedNeonText(text:rewardModel[rewardScreen - 1].title, color: Color("purpleText"), shadowColor: Color("purpleText"), size: shapeWidth < 340 ? 27 : 28)
                            .offset(y: 36)
                        Text(rewardModel[rewardScreen - 1].description)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(Font.custom("RobotoCondensed-Medium", size:shapeWidth < 340 ? 20 : 21))
                            .offset(y: 4)
                            .padding()
                    }
                    .offset(y: 16)
                }
                .offset(y: shapeWidth < 340 ? -16 : -8)
                .frame(maxHeight: 400)
                .padding(.horizontal, 20)
            }
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
       
    }
      
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView(rewardScreen: 1)
    }
}
