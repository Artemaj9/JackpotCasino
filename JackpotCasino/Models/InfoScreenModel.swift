//
//  InfoScreenModel.swift
//

import Foundation

struct InfoScreenModel {
    let image: String
    let text: String
    var showX: Bool = false
    var isTitle: Bool = false
}

let infoScreens = [
    InfoScreenModel(image: "infoCareer", text: Info.career),
    InfoScreenModel(image: "infoChallenge", text: Info.challenge),
    InfoScreenModel(image: "infoRewards", text: Info.rewards),
    InfoScreenModel(image: "infoCardDistribution", text: Info.cardDistribution, isTitle: true),
    InfoScreenModel(image: "infoPayout", text: Info.payoutCalculation, isTitle: true),
    InfoScreenModel(image: "infoMistake", text: Info.mistakeManagement, isTitle: true)
]
