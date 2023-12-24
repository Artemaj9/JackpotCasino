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
        case "2c", "2d", "2h", "2s": return 2
        case "3c", "3d", "3h", "3s": return 3
        case "4c", "4d", "4h", "4s": return 4
        case "5c", "5d", "5h", "5s": return 5
        case "6c", "6d", "6h", "6s": return 6
        case "7c", "7d", "7h", "7s": return 7
        case "8c", "8d", "8h", "8s": return 8
        case "9c", "9d", "9h", "9s": return 9
        case "Acec", "Aced", "Aceh", "Aces": return 11
        default: return 10
        }
    }
    var isFlipped = false
}
