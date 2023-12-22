//
//  SplashView.swift
//  JackpotCasino
//
//  Created by Artem on 22.12.2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            LogoView()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
