//
//  TutorialScreenModel.swift
//  JackpotCasino
//
//  Created by Artem on 28.12.2023.
//

import Foundation

struct TutorialScreenModel {
    let image: String
    let text: String
    var showX: Bool = true
    var isTitle: Bool = false
    var title: String = "TASK 1"
    var subtitle: String = "The Dealer's Rush"
    var type: TypeTutorial
}

enum TypeTutorial {
    case task
    case game
    case men
}

//let tutorialScreens = [
//    TutorialScreenModel(image: "men", text: tutorial., type: <#T##TypeTutorial#>)
//    
//
//]
