//
//  LogicModel.swift
//

import SwiftUI
import Combine

class LogicModel: ObservableObject {
    
    @AppStorage("firstStart") var firstStart = true
    @Published var isSplash = true
    @Published var balance = 0
    @AppStorage("level") var level = 1
    @Published var count = 0
    @Published var isRotating = false
    @Published var rotationIsOver = false
    
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
            }
            .store(in: &cancellables)
    }
}
