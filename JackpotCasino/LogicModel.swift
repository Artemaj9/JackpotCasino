//
//  LogicModel.swift
//

import SwiftUI
import Combine

class LogicModel: ObservableObject {
    
    @AppStorage("firstStart") var firstStart = true
    @AppStorage("level") var level = 0
    @AppStorage("record") var record = 0
    @AppStorage("lives") var lives = 10
    @AppStorage("balance") var balance = 0
    
    @Published var isSplash = true
    //@Published var balance = 0
    @Published var count = 0

    
    // Animation end round
    @Published var animCount = 0
    @Published var isAnimationRound = false
    @Published var showEndText = false
    @Published var result = ""
    @Published var praiseEndGame = ""
    @Published var needToStartNewGame = false
    
    @Published var isRotating = false
    @Published var rotationIsOver = false
    @Published var isPaused = false
    
    // Game
    @Published var bet = 0
    @Published var isDeal = false
    @Published var isGame = false
    @Published var isStand = false
    @Published var canDouble = true
    @Published var isDouble = false
    @Published var isLoosed = false
    @Published var playerWin = false
    @Published var remainingTime = 180
    //@Published var lives = 1
    @Published var isWinEnd = false
    @Published var isFired = false
    @Published var timerStopflag = false
    @Published var winnerDefined = false
    @Published var notAbleToBring = false
    @Published var isBlackJack = false
    @Published var openDillerCards = false
    @Published var deadTimerCount = 0
    
    //Live таймер
    @Published var liveTimerCount = 0
    
    
    // hit, stand or double 0, 1, 2
    @Published var decision = -1
    
    @Published var size: CGSize = .zero
    
    
    
    private var cancellables = Set<AnyCancellable>()
    
    private var animTimer: AnyCancellable?
    var liveTimer: AnyCancellable?
    var deadTimer: AnyCancellable?
    
    func setupTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                if !isPaused {
                    count += 1
                }
                if count >= 8 && isRotating  {
                    isRotating = false
                    withAnimation { rotationIsOver = true }
                    for item in cancellables {
                        item.cancel()
                    }
                    count = 0
                }
                
                if count >= 15 && isDeal {
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
        bet = [2, 10, 100, 500, 1000, 1500, 2000, 2500, 3000].randomElement()!
        isGame = true
        isDeal = true
    }
    
    func restartGame() {
        bet = 0
        isStand = false
        needToStartNewGame = false
        canDouble = true
        winnerDefined = false
        isDouble = false
        playerWin = false
        isWinEnd = false
        isFired = false
        timerStopflag = false
        notAbleToBring = false
        isBlackJack = false
        openDillerCards = false
        isLoosed = false
       // cancelAllTimers()
        stake()
    }
    
    
    func setUpLiveTimer() {
        liveTimerCount = 0
         liveTimer = Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                if !isPaused {
                    self.liveTimerCount += 1
                }
                if self.liveTimerCount >= 150 {
                    if self.lives > 1 {
                        self.lives -= 1
                    } else {
                        self.lives -= 1
                        self.needToStartNewGame = false
                        self.showEndText = false
                        if balance >= 2500 {
                            self.isLoosed = true
                            cancelAllTimers()
                        } else {
                            self.isFired = true
                            cancelAllTimers()
                        }
                    }
                    self.liveTimer?.cancel()
                }
            }
        }
    
    
    func setUpDeadTimer() {
        deadTimerCount = 0
         deadTimer = Timer
            .publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                if !isPaused {
                    self.deadTimerCount += 1
                }
                if self.deadTimerCount >= 200 {
                    if self.lives > 1 {
                        withAnimation {
                            self.lives -= 1
                        }
                    } else {
                        self.needToStartNewGame = false
                        self.showEndText = false
                        withAnimation {
                            self.lives -= 1
                        }
                        if balance >= 2500 {
                            self.isLoosed = true
                        } else {
                            self.isFired = true
                        }
                       cancelAllTimers()
                    }
                    deadTimerCount = 0
                    self.deadTimer?.cancel()
                }
            }
        }
    
    func countdown() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                if !isPaused {
                    remainingTime -= 1
                }
                if (remainingTime <= 0 && isGame && lives > 0)  || timerStopflag {
                    
                    print("TIME IS OVER!")
                   
                    isGame = false
                    isDeal = false
                    isWinEnd = true
                    
                    level += 1
                    record = max(record, level)
                    bet = 0
                    count = 0
                    cancelAllTimers()
                    // GAME OVER
                    for item in cancellables {
                        item.cancel()
                    }
             
                }
            }
            .store(in: &cancellables)
    }
    
    func setUpAnimation(whoWin: String, isTimeOut: Bool = false) {
        liveTimer?.cancel()
        liveTimerCount = 0
        isAnimationRound = true
        bet = 0
        result = whoWin
        praiseEndGame = isTimeOut ? "" : (praise.randomElement() ?? "Great job!")
         animTimer = Timer
            .publish(every: 0.2, on: .main, in: .common)
            .autoconnect()
            .sink { [unowned self] _ in
                if !isPaused {
                    self.animCount += 1
                    if animCount > 2 {
                        showEndText = true
                    }
                    if animCount > 10 {
                        showEndText = false
                    }
                    if animCount > 12 {
                        animCount = 0
                        isAnimationRound = false
                        needToStartNewGame = true
                        self.animTimer?.cancel()
                    }
                }
            }
        }
    func cancelAllTimers() {
        liveTimer?.cancel()
        deadTimer?.cancel()
        animTimer?.cancel()
        for item in cancellables {
            item.cancel()
        }
        
    }

    func resetToDefault() {
       // cancelAllTimers()
        animCount = 0
        bet = 0
        isDeal = false
        isGame = false
        isStand = false
        canDouble = true
        isDouble = false
        isLoosed = false
        playerWin = false
        remainingTime = 180
        isWinEnd = false
        isFired = false
        timerStopflag = false
        winnerDefined = false
        notAbleToBring = false
        isBlackJack = false
        openDillerCards = false
        deadTimerCount = 0
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
