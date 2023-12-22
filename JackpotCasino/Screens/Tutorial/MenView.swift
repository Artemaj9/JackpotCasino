//
//  MenView.swift
//  

import SwiftUI

struct MenView: View {
    @State private var width: CGFloat = 0
    
    var body: some View {
        ZStack {
            BackgroundView()
                .background(
                    GeometryReader() { geo in
                        Color.clear.onAppear {
                            self.width = geo.size.width
                            print(width)
                        }
                    }
                )
            VStack (spacing: width > 400 ? 24 : 8) {
                Image("men")
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .topTrailing) {
                        Button {
                            
                        } label: {
                            ZStack {
                                Circle()
                                    .fill( Color.purple.opacity(0.001))
                                    .frame(width: 50, height: 50)
                                Image("back")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            .padding(24)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                
                VStack() {
                    Text(Tutorial.welcomeText)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .font(Font.custom("RobotoCondensed-Bold",size: width < 380 ? 16 : 20))
                        .padding(.horizontal)
                    
                    HStack(spacing: 24) {
                        DashedButton(color: Color( "lightBlueNeon"), text: "SKIP", padding: 8, fontSize: width < 380 ? 18 : 21 )
                        BrightButton(text: "NEXT", fontSize: width < 380 ? 20 : 24, padding: 8)
                    }
                    .padding()
                    .offset(y: width > 400 ? 16 : 0)//.padding(.top)
                }
            }
            .offset(y: -8)
        }
        .preferredColorScheme(.dark)
    }
}

struct MenView_Previews: PreviewProvider {
    static var previews: some View {
        MenView()
    }
}
