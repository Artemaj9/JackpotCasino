//
//  CardDropDelegate.swift
//

import SwiftUI
import UniformTypeIdentifiers

class CardDropDelegate: ObservableObject, DropDelegate {
    
    @Published var draggedCards = [CardModel]()
    @Published var botSum = 0
    @Published var allDeckCards = [CardModel]()
    @Published var aces = 0
    
    let cardNames = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
    @Published var cardTitles = [String]()
    
    func addCards() {
        for cardName in cardNames {
            allDeckCards.append(CardModel(image: cardName + "s"))
            allDeckCards.append(CardModel(image: cardName + "d"))
            allDeckCards.append(CardModel(image: cardName + "h"))
            allDeckCards.append(CardModel(image: cardName + "c"))
            cardTitles.append(cardName + "s")
            cardTitles.append(cardName + "d")
            cardTitles.append(cardName + "h")
            cardTitles.append(cardName + "c")
        }
    }
    
    func performDrop(info: DropInfo) -> Bool {
        for provider in info.itemProviders(for: [UTType.url]) {
            if provider.canLoadObject(ofClass: URL.self) {
                let _ = provider.loadObject(ofClass: URL.self) { (url, error) in
                    DispatchQueue.main.async {
                        withAnimation(.easeOut) {
                            if self.cardTitles.contains("\(url!)") {
                                self.draggedCards.append(CardModel(id: UUID(), image: "\(url!)", isFlipped: false))
                                self.botSum += self.draggedCards.last?.number ?? 0
                                self.allDeckCards.shuffle()
                                if ["Acec", "Aceh", "Aced", "Aces"].contains("\(url!)") {
                                    self.aces += 1
                                }
                                if self.botSum > 21 && self.aces >= 1 {
                                    self.botSum -= 10
                                    self.aces -= 1
                                }
                            }
                        }
                    }
                }
            }
        }
        return true
    }
}

