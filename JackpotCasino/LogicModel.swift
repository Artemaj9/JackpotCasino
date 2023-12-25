//
//  GameViewModel.swift
//  JackpotCasino
//
//  Created by Artem on 25.12.2023.
//

import SwiftUI

class LogicModel: ObservableObject {
    
    @Published var isSplash = true
    @AppStorage("firstStart") var firstStart = true
}
