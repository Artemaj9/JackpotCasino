//
//  InfoWelcome.swift
//

import SwiftUI

struct InfoWelcome: View {
    
    @State private var width: CGFloat = 0
    @State var screen = 1
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            Rectangle()
                .fill(Color("infoRibbon").opacity(0.08))
                .frame(width: 25)
                .scaleEffect(4)
                .rotationEffect(Angle.radians(-.pi/4))
                .offset(y: -100)
            
            VStack {
                if screen == 1 {
                    VStack(spacing: width < 380 ? 8 : 24) {
                        StrokedNeonText(text: "WELCOME TO", color: Color("purpleText"), shadowColor: Color("purpleText"), size: width < 380 ? 58 : 60)
                        
                        LogoView()
                            .background(
                                GeometryReader() { geo in
                                    Color.clear.onAppear {
                                        self.width = geo.size.width
                                        print(width)
                                    }
                                })
                        
                        VStack {
                            Text(Info.welcomeText)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                                .font(Font.custom("RobotoCondensed-Bold", size: width < 380 ? 18 : 22))
                                .padding()
                            
                            HStack(spacing: 24) {
                                Button {
                                    dismiss()
                                } label: {
                                    DashedButton(color: Color( "lightBlueNeon"), text: "SKIP", padding: width < 380 ? 8 : 16 )
                                }
                                
                                Button {
                                    withAnimation {
                                        screen += 1
                                    }
                                } label: {
                                    BrightButton(text: "NEXT", fontSize: 24, padding: width < 380 ? 8 : 16)
                                }
                            }
                            .padding(width < 380 ? 8 : 16)
                        }
                    }
                } else {
                    MenTypeView(
                        screen: $screen,
                        text: infoScreens[screen - 2].text,
                        image: infoScreens[screen - 2].image,
                        isTitle: screen < 5 ? false : true )
                    .id(screen)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading))
                    )
                }
            }
        }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
    }
}

struct InfoWelcome_Previews: PreviewProvider {
    static var previews: some View {
        InfoWelcome()
    }
}
