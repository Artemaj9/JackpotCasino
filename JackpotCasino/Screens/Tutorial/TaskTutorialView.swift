//
//  TaskTutorialView.swift
//

import SwiftUI

struct TaskTutorialView: View {
    
    @State private var width: CGFloat = 0
    @State var showX = true
    @Binding var screen: Int
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var gm: LogicModel
    
    var title = "TASK 1"
    var subTitle = "The Dealer's Rush"
    var image = "task1Deal"
    var text = Tutorial.dealText
    
    var body: some View {
        ZStack {
            BackgroundView()
                .background(
                    GeometryReader() { geo in
                        Color.clear.onAppear {
                            self.width = geo.size.width
                        }
                    })
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
                   .offset(y: -16)
                }
            
            VStack(spacing: 16) {
                VStack(spacing: 8) {
                    Text(title)
                        .foregroundColor(Color("taskBlue"))
                        .font(Font.custom("RobotoCondensed-BoldItalic",size: width < 380 ? 48 : 52))
                    
                    Text(subTitle)
                        .foregroundColor(.white)
                        .font(Font.custom("RobotoCondensed-BoldItalic",size: width < 380 ? 28 : 32))
                        .padding(.horizontal)
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                }
                VStack(spacing: 8) {
                    
                    Text(text)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .font(Font.custom("RobotoCondensed-Bold",size: width < 380 ? 17 : 21))
                        .padding(.horizontal)
                    
                    HStack(spacing: 24) {
                        Button {
                            gm.isTutorialShown = true
                        } label: {
                            DashedButton(color: Color( "lightBlueNeon"), text: "SKIP", padding: 8, fontSize: width < 380 ? 18 : 21 )
                        }
                      
                        Button {
                            withAnimation {
                                screen += 1
                            }
                        } label : {
                            BrightButton(text: "NEXT", fontSize: width < 380 ? 20 : 24, padding: 8)
                        }
                    }
                    .padding()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct TaskTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTutorialView(screen: .constant(1))
    }
}
