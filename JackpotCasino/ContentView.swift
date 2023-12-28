//
//  ContentView.swift
//  JackpotCasino
//
//  Created by Artem on 25.12.2023.
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
        .onAppear {
            gameLogic.firstStart = true
            gameLogic.lives = 1
            gameLogic.record = 0
            gameLogic.balance = 0
            gameLogic.level = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
