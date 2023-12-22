//
//  CoinAnimation.swift
//  JackpotCasino

import SwiftUI
import Combine

final class CoinAnimation: ObservableObject {
    
    var frontCoins = [CoinAnimatableProperties]()
    var backCoins = [CoinAnimatableProperties]()
    
    func updateCoins () {
        for _ in 1...10 {
            frontCoins.append(CoinAnimatableProperties(speed: .random(in: 1.5...9.0), angularSpeed: .random(in: 0.5...10), initialXOffset:.random(in: -150...150), initialYOffset: .random(in: -4500 ... -800), number: .random(in: 1...4), axisX: .random(in: 0...1), axisY: .random(in: 0...1), axisZ: .random(in: 0...1), saturation: .random(in: 0.8...1.2), hueRotation: .random(in: -15...15)))
        }
        
        for _ in 1...10 {
            backCoins.append(CoinAnimatableProperties(speed: .random(in: 0.1...5), angularSpeed: .random(in: 0.5...15), initialXOffset:.random(in: -170...170), initialYOffset: .random(in: -1200 ... -600), number: .random(in: 1...4), axisX: .random(in: 0...1), axisY: .random(in: 0...1), axisZ: .random(in: 0...1), saturation: .random(in: 0.8...1.2), hueRotation: .random(in: -15...15)))
        }
    }
}
