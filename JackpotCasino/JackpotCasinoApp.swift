//
//  JackpotCasinoApp.swift
//

import SwiftUI

@main
struct JackpotCasinoApp: App {
    
    @StateObject var gameLogic = LogicModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameLogic)
        }
    }
}
