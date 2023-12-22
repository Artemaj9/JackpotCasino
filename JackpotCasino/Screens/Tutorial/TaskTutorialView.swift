//
//  TaskTutorialView.swift
//  JackpotCasino
//
//  Created by Artem on 22.12.2023.
//

import SwiftUI

struct TaskTutorialView: View {
    
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
            VStack(spacing: 16) {
                VStack(spacing: 8) {
                    Text("TASK 1")
                        .foregroundColor(Color("taskBlue"))
                        .font(Font.custom("RobotoCondensed-BoldItalic",size: width < 380 ? 48 : 52))
                    
                    Text("The Dealer's Rush")
                        .foregroundColor(.white)
                        .font(Font.custom("RobotoCondensed-BoldItalic",size: width < 380 ? 28 : 32))
                        .padding(.horizontal)
                    
                    Image("task1Deal")
                        .resizable()
                        .scaledToFit()
                }
                VStack(spacing: 8) {
                    
                    Text(Tutorial.dealText)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .font(Font.custom("RobotoCondensed-Bold",size: width < 380 ? 17 : 21))
                        .padding(.horizontal)
                    
                    HStack(spacing: 24) {
                        DashedButton(color: Color( "lightBlueNeon"), text: "SKIP", padding: 8, fontSize: width < 380 ? 18 : 21 )
                        BrightButton(text: "NEXT", fontSize: width < 380 ? 20 : 24, padding: 8)
                    }
                    .padding()
                }
            }
        }
    }
}

struct TaskTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTutorialView()
    }
}
