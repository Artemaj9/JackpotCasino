//
//  LogicModel.swift
//

import SwiftUI
import Combine

class LogicModel: ObservableObject {
    
    @AppStorage("firstStart") var firstStart = true
    @Published var isSplash = true
    @Published var balance = 0
    @AppStorage("level") var level = 0
    @Published var count = 0
    @Published var isRotating = false
    @Published var rotationIsOver = false
    
    
    // Игра
    @Published var bet = 2500
    @Published var gameMode: GameMode = .Deal
    @Published var isDeal = false
    @Published var isGame = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func setupTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                count += 1
                if count >= 8 && isRotating  {
                    isRotating = false
                    withAnimation { rotationIsOver = true }
                    for item in cancellables {
                        item.cancel()
                    }
                    count = 0
                }
                
                if count >= 15 && isDeal  {
                    isDeal = false
                    for item in cancellables {
                        item.cancel()
                    }
                    count = 0
                }
            }
            .store(in: &cancellables)
    }
    
    
    func stake() {
        bet = [100, 500, 1000, 1500, 2000, 2500, 3000].randomElement()!
        isGame = true
        isDeal = true
        
    }
    
    
    func setupGameTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                count += 1
                if count >= 180 && isGame  {
                    isGame = false
                    isDeal = false
                    bet = 0
                    // GAME OVER
                    for item in cancellables {
                        item.cancel()
                    }
                    count = 0
                }
            }
            .store(in: &cancellables)
    }
}
