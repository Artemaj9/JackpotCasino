//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var gameLogic: LogicModel
    
    var body: some View {
        ZStack {
            if gameLogic.isSplash {
                SplashView()
                    .environmentObject(gameLogic)
            } else if gameLogic.firstStart {
                WelcomeView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: .slide))
                    .environmentObject(gameLogic)
            } else {
                MenuView()
                    .transition(.opacity)
                    .environmentObject(gameLogic)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LogicModel())
    }
}
