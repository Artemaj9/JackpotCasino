//
//  GameViewModel.swift
//

import SwiftUI
import UniformTypeIdentifiers

class GameViewModel: ObservableObject, DropDelegate {
    
    @Published var sum = 0
    @Published var aces = 0
    @Published var draggedChips = [ChipModel]()
    @Published var endFlag = false
    @Published var userMoney = 0
    @Published var state = 0
    
    let chips = ["chip1", "chip5", "chip100", "chip500"]
    
    var initialChips = [ChipModel(image: "chip1"), ChipModel(image: "chip5"), ChipModel(image: "chip100"), ChipModel(image: "chip500")]
    
    func performDrop(info: DropInfo) -> Bool {
   
        for provider in info.itemProviders(for: [UTType.url]) {
            if provider.canLoadObject(ofClass: URL.self) {
                let _ = provider.loadObject(ofClass: URL.self) { (url, error) in
                    if self.chips.contains("\(url!)") {
                        DispatchQueue.main.async {
                            self.draggedChips.append(ChipModel(id: UUID(), image: "\(url!)"))
                            self.sum += self.draggedChips.last!.number
                            if self.sum == self.userMoney {
                                self.state = 1
                            }
                            if self.sum > self.userMoney {
                                self.state = -1
                            }
                        }
                        
                    }
                }
            }
        }
        return true
    }    
}
