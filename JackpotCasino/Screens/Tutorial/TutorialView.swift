//
//  TutorialView.swift
//  JackpotCasino
//
//  Created by Artem on 28.12.2023.
//

import SwiftUI

struct TutorialView: View {
    
    @EnvironmentObject var gm: LogicModel
    @State var screen = 1
    
    var body: some View {
        ZStack {
            switch screen {
            case 1:  MenTypeView(screen: $screen, text: Tutorial.welcomeText, image: "men", showX: true)
                    .environmentObject(gm)
            case 2: TaskTutorialView(screen: $screen)
                    .environmentObject(gm)
            case 3: TaskTutorialView(screen: $screen, image: "task1Hit", text: Tutorial.hitText)
                    .environmentObject(gm)
            case 4: TaskTutorialView(screen: $screen, image: "task1Stand", text: Tutorial.standText)
                    .environmentObject(gm)
            case 5: PlayTutorialView(screen: $screen)
                    .environmentObject(gm)
            case 6: MenTypeView(screen: $screen, text: Tutorial.casinoText, image: "nightcasino", showX: true)
                    .environmentObject(gm)
            case 7: TaskTutorialView(screen: $screen, title: "TASK 2", subTitle: "The Payout Precision", image: "task2", text: Tutorial.payoutText)
                    .environmentObject(gm)
            case 8: PayoutView()
                    .environmentObject(gm)
                
            default: BackgroundView()
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
