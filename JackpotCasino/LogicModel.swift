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
    @Published var isStand = false
    @Published var playerWin = false
    @Published var remainingTime = 180
    
    
    // hit, stand or double 0, 1, 2
    @Published var decision = -1
    
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
    
    
    func countdown() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                remainingTime -= 1
                if remainingTime <= 0 && isGame  {
                    print("TIME IS OVER!")
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
    
    
    
    func randomNumber(probabilities: [Double]) -> Int {

        // Sum of all probabilities (so that we don't have to require that the sum is 1.0):
        let sum = probabilities.reduce(0, +)
        // Random number in the range 0.0 <= rnd < sum :
        let rnd = Double.random(in: 0.0 ..< sum)
        // Find the first interval of accumulated probabilities into which `rnd` falls:
        var accum = 0.0
        for (i, p) in probabilities.enumerated() {
            accum += p
            if rnd < accum {
                return i
            }
        }
        // This point might be reached due to floating point inaccuracies:
        return (probabilities.count - 1)
    }
}
