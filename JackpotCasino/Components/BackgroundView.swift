//
//  BackgroundView.swift
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("bgGradLight"), Color("bgGradDark")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            Image("bgImage")
                .resizable(resizingMode: .tile)
                .ignoresSafeArea()
                .opacity(0.1)
                .saturation(0)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
