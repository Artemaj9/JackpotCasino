//
//  CoinsView.swift
//  JackpotCasino
//
//  Created by Artem on 28.12.2023.
//

import SwiftUI

struct CoinsView: View {
    @State var offset: CGFloat = -1000
    var body: some View {
        ZStack {
        
            ForEach(1..<15) { i in
                Image("coin")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.4)
                    .offset(x: CGFloat(Int.random(in: -150...150)), y: CGFloat(Int.random(in: -3500...0)))
                    .offset(y: offset)
                    .animation(.easeIn(duration: 20), value: offset)
                  
            }
        }
        .onAppear {
            offset = 140
        }
    }
}

struct CoinsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsView()
    }
}
