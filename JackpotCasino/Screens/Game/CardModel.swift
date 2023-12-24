//
//  CardModel.swift
//  JackpotCasino
//
//  Created by Artem on 24.12.2023.
//

import Foundation

struct CardModel: Identifiable {
    
    var id = UUID()
    var image: String
    var number: Int {
        switch image {
        case "chip1": return 1
        case "chip5": return 5
        case "chip100": return 100
        case "chip500": return 500
        default: return 0
        }
    }
}
