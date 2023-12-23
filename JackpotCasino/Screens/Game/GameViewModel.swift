//
//  GameViewModel.swift
//  JackpotCasino
//
//  Created by Artem on 23.12.2023.
//

import SwiftUI
import MobileCoreServices
import UniformTypeIdentifiers

class GameViewModel: ObservableObject, DropDelegate {
    
    @Published var sum = 0
    @Published var draggedChips = [ChipModel]()
    var initialChips: [ChipModel] = [ChipModel(id: UUID(), image: "chip1"), ChipModel(id: UUID(), image: "chip5"), ChipModel(id: UUID(), image: "chip100"), ChipModel(id: UUID(), image: "chip500")]
    func performDrop(info: DropInfo) -> Bool {
   
        for provider in info.itemProviders(for: [UTType.url]) {
            if provider.canLoadObject(ofClass: URL.self) {
                let _ = provider.loadObject(ofClass: URL.self) { (url, error) in
                        DispatchQueue.main.async {
                            withAnimation(.easeOut) {
                                self.draggedChips.append(ChipModel(id: UUID(), image: "\(url!)"))
                                self.sum += self.draggedChips.last?.number ?? 0
                            }
                        }
                    }
                }
        }
        
        return true
    }
    
}
