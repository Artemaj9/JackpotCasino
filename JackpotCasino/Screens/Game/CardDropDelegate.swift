//
//  CardDropDelegate.swift
//

import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers


class CardDropDelegate: ObservableObject, DropDelegate {
    
    @Published var draggedCards = [CardModel]()
    @Published var sum = 0
    @Published var allDeckCards = [CardModel]()
    
    let cardNames = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
    let shortCards = ["Jack"]
    
    func addCards() {
        for cardName in shortCards {
            allDeckCards.append(CardModel(image: cardName + "s"))
            allDeckCards.append(CardModel(image: cardName + "d"))
            allDeckCards.append(CardModel(image: cardName + "h"))
            allDeckCards.append(CardModel(image: cardName + "c"))
        }
    }

    func performDrop(info: DropInfo) -> Bool {
        for provider in info.itemProviders(for: [UTType.url]) {
            if provider.canLoadObject(ofClass: URL.self) {
                let _ = provider.loadObject(ofClass: URL.self) { (url, error) in
                        DispatchQueue.main.async {
                            withAnimation(.easeOut) {
                                self.draggedCards.append(CardModel(id: UUID(), image: "\(url!)"))
                                self.sum += self.draggedCards.last?.number ?? 0
                            }
                        }
                    }
                }
        }
        return true
    }
}

