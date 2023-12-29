//
//  PayoutGameView.swift
//

import SwiftUI
import UniformTypeIdentifiers

private let chips = [1, 5, 100, 500]

struct PayoutGameView: View {
    
    @StateObject var gameLogic = GameViewModel()
    @EnvironmentObject var gm: LogicModel
    
    var userMoney: Int
    @Binding var endFlag: Bool
    var coef: Double = 1
    
    var body: some View {
        ZStack {
            Image("table")
                .resizable()
                .offset(y: 150)

            VStack {
                Spacer()
                Text("State: \(gameLogic.state), summ: \(gameLogic.sum), endFlag: \(endFlag.description)")
                    .foregroundColor(.clear)
                    .font(.largeTitle)
                    .id(gameLogic.sum)
                    .background(
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                if gameLogic.sum == gameLogic.userMoney {
                                    endFlag = true
                                    gm.setUpAnimation(whoWin: "Player wins!")
                                }
                                
                                if gameLogic.sum > gameLogic.userMoney {
                                    gm.liveTimer?.cancel()
                                    gm.setUpAnimation(whoWin: "User stole casino money!", isTimeOut: true)
                                    gm.setUpDeadTimer()
                                }
                            }
                        })
            }
            
            VStack(spacing: 50) {
                Spacer()
                Spacer()
                ZStack {
                    Rectangle().frame(width:300, height: 500).opacity(0.001)
                                        .layoutPriority(-1)
                    NeonRectangle()
                        .offset(y: 60)
                    Text("DRAG\nHERE")
                                .font(Font.custom("RobotoCondensed-Bold",size: 64))
                                .foregroundColor(.white.opacity(0.3))
                                .offset(y: 35)
                                .opacity(0.5)
                    if  gm.isBlackJack {
                        if  gm.isBlackJack {
                            StrokedNeonText(text: "BLACKJACK!", color:   Color("lightPinkNeon"), shadowColor:  Color("lightPinkNeon").opacity(0.1), size: 45)
                                .opacity(0.6)
                                .offset(y: 200)
                            
                        }
                    }
                }
                .onDrop(of: [UTType.url], delegate: gameLogic)
                .overlay(
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 0
                    ) {
                        ForEach(gameLogic.draggedChips) { chip in
                            Image(chip.image)
                                .resizable()
                                .scaledToFit()
                                .offset(y: 100)
                        }
                    })
                .padding()
               
                Spacer()
             
                HStack() {
                    ForEach(gameLogic.initialChips) { chip in
                        Image(chip.image)
                            .resizable()
                            .scaledToFit()
                            .onDrag {
                                NSItemProvider(item: .some(URL(string: String(chip.image))! as NSSecureCoding), typeIdentifier: UTType.url.identifier)
                            }
                    }
                }
                .offset(y: -50)
            }
        }
        .onAppear {
            gameLogic.userMoney = gm.isBlackJack ? Int(1.5 * Double(gm.bet)) : gm.bet
            gameLogic.state = 0
            gameLogic.draggedChips = []
            gameLogic.sum = 0
            gm.setUpLiveTimer()
        }
        .preferredColorScheme(.dark)
    }
}
