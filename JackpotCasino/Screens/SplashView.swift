//
//  SplashView.swift
//  JackpotCasino
//
//  Created by Artem on 22.12.2023.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var vm: LogicModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            LogoView()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                vm.isSplash = false
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
