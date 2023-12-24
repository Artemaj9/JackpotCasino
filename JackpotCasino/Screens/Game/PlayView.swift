//
//  PlayView.swift
//  JackpotCasino
//
//  Created by Artem on 24.12.2023.
//

import SwiftUI

struct PlayView: View {
    
    @State var size: CGSize = .zero
    let tableRatio = 0.2
    
    var body: some View {
        ZStack {
            BackgroundView()
                .background(
                    GeometryReader() { geo in
                        Color.clear.onAppear {
                            self.size = geo.size
                            print("width:  \(size.width)")
                            print("height: \(size.height)")
                        }
                        })
            Image("table")
                .resizable()
                .offset(y: tableRatio * size.height)
            Image("carddeck")
                .resizable()
                .scaleEffect(0.5)
                .offset(x: -size.width*0.25,y: size.height * 0.1)
           
            NeonRect(color: Color("redNeon"), shadow: Color("redNeon"), strokeCoeff: 0.5)
                .frame(width: size.height * 0.23, height: size.height * 0.23)
                .rotationEffect(Angle(degrees: 15))
                .offset(x: size.width * 0.19)
            
       
            
            NeonRect(color: Color("freshBlueNeon"), shadow: Color("freshBlueNeon"), strokeCoeff: 0.5)
                .frame(width: size.height * 0.23, height: size.height * 0.23)
                .rotationEffect(Angle(degrees: 15))
                .offset(x: -size.width * 0.08, y: size.height*0.38)
            VStack(alignment: .leading) {
                Text("Player's Hand")
                    .foregroundColor(.white)
              
                    RoundedRectangle(cornerRadius: 6)
                    .fill(Color("statBg").opacity(0.5))
                        .frame(width: 58, height: 36)
                        .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("redNeon"), lineWidth: 2)
                    )
            }
            .offset(x: -size.width * 0.34, y: -size.height*0.07)
            
            VStack(alignment: .trailing) {
                Text("Your's Hand")
                    .foregroundColor(.white)
            }
            
         
                
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
