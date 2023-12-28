//
//  MenView.swift
//  

import SwiftUI

struct MenTypeView: View {
    
    @State private var width: CGFloat = 0
    @Binding var screen: Int
    @Environment(\.dismiss) var dismiss
    
    let text: String
    let image: String
    var showX: Bool = false
    var isTitle: Bool = false
    
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
                if isTitle {
                    Text("GAME MECHANICS")
                        .font(Font.custom("RobotoCondensed-BoldItalic",size: width < 380 ? 38 : 42))
                        .foregroundColor(Color("taskBlue"))
                        .padding(.bottom, -12)
                }
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .topTrailing) {
                        Button {
                           dismiss()
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
                        .opacity(showX ? 1 : 0)
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                
                VStack() {
                    Text(text)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .font(Font.custom("RobotoCondensed-Bold",size: width < 380 ? 16 : 20))
                        .padding(.horizontal)
                    
                    HStack(spacing: 24) {
                        Button {
                            dismiss()
                        } label: {
                            DashedButton(color: Color( "lightBlueNeon"), text: "SKIP", padding: 8, fontSize: width < 380 ? 18 : 21 )
                        }
                        
                        Button {
                            withAnimation {
                                screen < 7 ? screen += 1 : dismiss()
                            }
                        } label: {
                            BrightButton(text: "NEXT", fontSize: width < 380 ? 20 : 24, padding: 8)
                        }
                    }
                    .padding()
                    .offset(y: width > 400 ? 16 : 0)
                }
            }
            .offset(y: -8)
        }
        .preferredColorScheme(.dark)
    }
}

//struct MenView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenView()
//    }
//}
