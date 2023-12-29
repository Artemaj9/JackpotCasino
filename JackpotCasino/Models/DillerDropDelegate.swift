//
//  DillerDropDelegate.swift
//  JackpotCasino

import SwiftUI
import UniformTypeIdentifiers

class DillerDropDelegate: ObservableObject,DropDelegate {
    
    @Published var dillerSum = 0
    @Published var draggedCards = [CardModel]()
    @Published var aces = 0
    
    func performDrop(info: DropInfo) -> Bool {
        for provider in info.itemProviders(for: [UTType.url]) {
            if provider.canLoadObject(ofClass: URL.self) {
                let _ = provider.loadObject(ofClass: URL.self) { (url, error) in
                    DispatchQueue.main.async {
                        withAnimation(.easeOut) {
                            self.draggedCards.append(CardModel(id: UUID(), image: "\(url!)", isFlipped: false))
                            self.dillerSum += self.draggedCards.last?.number ?? 0
                            if ["Acec", "Aceh", "Aced", "Aces"].contains("\(url!)") {
                                self.aces += 1
                            }
                            if self.dillerSum > 21 && self.aces >= 1 {
                                self.dillerSum -= 10
                                self.aces -= 1
                            }
                        }
                    }
                }
            }
        }
        return true
    }
}
