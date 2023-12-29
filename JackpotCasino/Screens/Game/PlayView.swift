//
//  PlayView.swift
//

import SwiftUI
import UniformTypeIdentifiers

struct PlayView: View {
    
    @State var size: CGSize = .zero
    @StateObject var vm = CardDropDelegate()
    @StateObject var dillerDrop = DillerDropDelegate()
    @EnvironmentObject var gm: LogicModel
    @State var bet = 0
    let tableRatio = 0.21
    
    @State var gameMode = -1
    @State var endFlag = false
    
    var body: some View {
        if gm.isTutorialShown {
            ZStack {
                BackgroundView()
                    .background(
                        GeometryReader() { geo in
                            Color.clear.onAppear {
                                self.size = geo.size
                            }
                        })
                
                
                VStack(spacing: 16) {
                    HStack(spacing: 30) {
                        GameHeaderCell(image: "heart", text: String(gm.lives))
                            .hueRotation(Angle(degrees: gm.liveTimerCount < 120 ? 0 : (2 * Double(gm.liveTimerCount) - 240)))
                            .saturation(gm.liveTimerCount < 120 ? 1 : (1/60 * Double(gm.liveTimerCount) - 1))
                            .hueRotation(Angle(degrees:  60 * abs(abs(( -Double(gm.deadTimerCount)) * 0.01 + 1) - 1)))
                            .saturation(0.5 * abs(abs(( -Double(gm.deadTimerCount)) * 0.01 + 1) - 1) + 1)
                        
                        GameHeaderCell(image: "watches", text: "\(gm.remainingTime/60):\(gm.remainingTime%60/10)\(gm.remainingTime%60%10)", dashPhase: 22)
                        Button {
                            gm.isPaused = true
                        } label: {
                            PauseCell(textMode: gm.playerWin ? "Payout" : "Dealing")
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [60, 30, 100, 20], dashPhase: 0))
                        .foregroundColor(Color("whitePink"))
                        .frame(width: 200, height: gm.size.width < 380 ? 35 : 50)
                        .shadow(color: Color("lightPinkNeon"), radius: 4)
                        .shadow(color: Color("lightPinkNeon"), radius: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color("pinkBg"))
                                .shadow(color: Color("lightPinkNeon"), radius: 1, x: -5)
                                .overlay {
                                    Text(String(gm.bet))
                                        .foregroundColor(.white)
                                        .font(Font.custom("RobotoCondensed-Bold",size: gm.size.width < 380 ? 32 : 36))
                                        .animation(.easeInOut, value: gm.bet)
                                        .onChange(of: gm.bet, perform: { newValue in
                                            //
                                            if newValue == 0 {
                                                gameMode = 0
                                            } else if !gm.isDouble {
                                                gameMode = 1
                                            }
                                        })
                                        .onTapGesture {
                                            withAnimation {
                                                startGame()
                                                gm.setUpAnimation(whoWin: "Debug win")
                                            }
                                        }
                                })
                        .offset(y: 8)
                    
                    if !gm.playerWin {
                        GameModeView(selected: $gameMode)
                            .environmentObject(gm)
                    }
                }
                .offset(y: gm.playerWin ? -gm.size.height * 0.4 : -gm.size.height * 0.37)
                
                if !gm.playerWin {
                    Image("table")
                        .resizable()
                        .offset(y: size.width < 380 ?  tableRatio * size.height * 1.15 : tableRatio * size.height)
                    
                    ZStack {
                        Image("carddeck")
                            .resizable()
                            .scaleEffect(0.5)
                    }
                    .offset(x: -size.width*0.25,y: size.height * 0.12)
                    
                    ZStack {
                        Rectangle().frame(width:300, height: 300)
                            .opacity(0.001)
                            .offset(x: 100)
                            .layoutPriority(-1)
                        NeonRect(color: Color("redNeon"), shadow: Color("redNeon"), strokeCoeff: 0.5)
                            .frame(width: size.height * 0.23, height: size.height * 0.23)
                            .rotationEffect(Angle(degrees: 15))
                            .offset(x: size.width * 0.17, y: size.height * 0.02)
                        
                        ZStack {
                            ForEach(vm.draggedCards.indices, id: \.self) { i in
                                CardView(needToRotate: true,image: vm.draggedCards[i].image, width: 80, height: 120)
                                    .rotationEffect(Angle(degrees: CGFloat(2)), anchor: .topLeading)
                                    .rotationEffect(Angle(degrees: CGFloat(15 * i)), anchor: .topLeading)
                                    .offset(x: size.width * 0.31)
                            }
                        }
                        .onChange(of: vm.draggedCards.count) { newValue in
                            
                            if gameMode == 3 {
                                gm.setUpDeadTimer()
                                gm.setUpAnimation(whoWin: "Wrong action!", isTimeOut: true)
                            } else {
                                
                                if newValue > 0 && !gm.isDouble {
                                    if !gm.isDeal {
                                        standOrHit()
                                    }
                                    
                                    if gm.isStand && dillerDrop.dillerSum > 16 {
                                        checkWinner()
                                    }
                                    
                                    if gm.isDeal {
                                        if newValue == 2 && dillerDrop.draggedCards.count == 2 {
                                            standOrHit()
                                        }
                                        
                                        if newValue == 3 {
                                            gm.setUpDeadTimer()
                                            gm.setUpAnimation(whoWin: "Wrong action!", isTimeOut: true)
                                        }
                                    }
                                }
                                
                                if gm.isDouble && !gm.notAbleToBring {
                                    gm.notAbleToBring = true
                                    gm.openDillerCards = true
                                    if dillerDrop.dillerSum > 16 {
                                        checkWinner()
                                    }
                                }
                                if gm.isDouble && vm.draggedCards.count == 4 {
                                    gm.setUpDeadTimer()
                                    gm.setUpAnimation(whoWin: "Wrong action!", isTimeOut: true)
                                }
                            }
                        }
                    }
                    .onDrop(of: [UTType.url], delegate: vm)
                    
                    ZStack {
                        Rectangle().frame(width:300, height: 500).opacity(0.001)
                            .offset(y: 500)
                            .layoutPriority(-1)
                        NeonRect(color: Color("freshBlueNeon"), shadow: Color("freshBlueNeon"), strokeCoeff: 0.5)
                            .frame(width: size.height * 0.23, height: size.height * 0.23)
                            .rotationEffect(Angle(degrees: 15))
                            .offset(x: -size.width * 0.08, y: size.height*0.38)
                        ZStack {
                            ForEach(dillerDrop.draggedCards.indices, id: \.self) { i in
                                CardView(needToRotate: i == 0 && !gm.isStand && !gm.openDillerCards ? false : true, image: dillerDrop.draggedCards[i].image, width: 80, height: 120)
                                    .rotationEffect(Angle(degrees: CGFloat(-15)), anchor: .bottomTrailing)
                                    .rotationEffect(Angle(degrees: CGFloat(15 * i)), anchor: .bottomTrailing)
                                    .offset(x: size.width * -0.08, y: size.height*0.4)
                                    .id(gm.openDillerCards)
                            }
                        }
                        .id(gm.isStand)
                        .onChange(of: dillerDrop.draggedCards.count) { newValue in
                            vm.allDeckCards.shuffle()
                            dillerDrop.draggedCards.reverse()
                            
                            if gameMode == 2 {
                                gm.setUpDeadTimer()
                                gm.setUpAnimation(whoWin: "Wrong action!", isTimeOut: true)
                            }
                            
                            if gm.isDouble && !gm.notAbleToBring {
                                gm.setUpDeadTimer()
                                gm.isDouble = false
                                gm.notAbleToBring = false
                                gm.setUpAnimation(whoWin: "Wrong action!", isTimeOut: true)
                            }
                            
                            if gm.isDeal {
                                if newValue == 2 && vm.draggedCards.count == 2 {
                                    standOrHit()
                                }
                                
                                if newValue == 3 {
                                    gm.setUpDeadTimer()
                                    gm.setUpAnimation(whoWin: "Wrong action!", isTimeOut: true)
                                }
                            }
                            
                            if gm.isStand && dillerDrop.dillerSum > 16 {
                                checkWinner()
                            }
                            
                            if gm.notAbleToBring && dillerDrop.dillerSum > 16 {
                                checkWinner()
                            }
                        }
                    }
                    .onDrop(of: [UTType.url], delegate: dillerDrop)
                    
                    
                    StatCell(title: "Player's Hand", color: Color("redNeon"), num: vm.botSum)
                        .offset(x: -size.width * 0.3, y: -size.height*0.05)
                    
                    StatCell(title: "Your's Hand", color: Color("freshBlueNeon"), num: dillerDrop.dillerSum, alignment: .trailing)
                    
                        .offset(x: size.width * 0.3, y: size.height*0.25)
                    
                    ZStack {
                        CardView(image: "CardBack", width: 70, height: 100)
                            .onDrag {
                                NSItemProvider(item: .some(URL(string:  vm.allDeckCards[0].image)! as NSSecureCoding), typeIdentifier: UTType.url.identifier)
                            }
                            .rotationEffect(Angle(degrees: 30))
                            .offset(x: -size.width * 0.33, y: size.height * 0.15)
                    }
                } else {
                    if gm.playerWin && gm.isBlackJack {
                        StrokedNeonText(text: "BLACKJACK!", color: .red, shadowColor: .blue, size: 25)
                            .opacity(0.3)
                    }
                    PayoutGameView(userMoney: bet, endFlag: $endFlag, coef: gm.isBlackJack ? 1.5 : 1)
                        .environmentObject(gm)
                }
                Rectangle()
                    .frame(width: gm.size.width, height: gm.size.height/8.2)
                    .foregroundColor(.black.opacity(0.5))
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .overlay(
                        VStack(alignment: .center) {
                            Text(gm.result)
                                .font(Font.custom("RobotoCondensed-Bold",size: 22))
                            
                            Text(gm.praiseEndGame)
                                .font(Font.custom("RobotoCondensed-MediumItalic",size: 22))
                                .foregroundColor(.white.opacity(0.9))
                        }
                            .opacity(gm.showEndText ? 1 : 0)
                            .animation(.easeIn, value: gm.showEndText)
                            .onChange(of: gm.needToStartNewGame, perform: { newValue in
                                if gm.needToStartNewGame {
                                    startGame()
                                }
                            })
                    )
                    .offset(y: gm.size.height * 0.45)
                    .offset(y: gm.animCount == 0 ? 150 : gm.size.width < 380 ? 10 :  gm.size.height * 0.04)
                    .opacity(gm.animCount == 0 ? 0 : 1)
                    .animation(.spring(), value: gm.animCount)
                
                Image("timer")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.2)
                    .overlay {
                        Text(String((159 - gm.liveTimerCount)/10))
                            .foregroundColor(.white)
                            .font(Font.custom("RobotoCondensed-Bold",size: 33))
                    }
                    .offset(x: 158, y: -110)
                    .onChange(of: gm.liveTimerCount) { newValue in
                        if gm.liveTimerCount == 150  {
                            gm.setUpAnimation(whoWin: "Time is out!", isTimeOut: true)
                        }
                    }
                
                if gm.isPaused {
                    PauseView()
                        .environmentObject(gm)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom),
                            removal: .slide))
                }
                
                if gm.isWinEnd {
                    GoodJobView()
                        .environmentObject(gm)
                }
                
                if gm.isLoosed {
                    LooseView()
                        .environmentObject(gm)
                }
                
                if gm.isFired {
                    FiredView()
                        .environmentObject(gm)
                }
            }
            .navigationBarHidden(true)
            .preferredColorScheme(.dark)
            .onAppear {
                gm.resetToDefault()
                gm.animTimer?.cancel()
                vm.addCards()
                vm.allDeckCards.shuffle()
                gm.remainingTime = 180
                gm.countdown()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    gm.stake()
                    bet = gm.bet
                    gm.setUpLiveTimer()
                }
            }
        } else {
            TutorialView(screen: 1)
        }
    }
    
    func startGame() {
        vm.draggedCards = []
        dillerDrop.draggedCards = []
        vm.botSum = 0
        vm.aces = 0
        gm.isDouble = false
        gm.canDouble = true
        dillerDrop.aces = 0
        dillerDrop.dillerSum = 0
        gameMode = 1
        gm.liveTimer?.cancel()
        gm.setUpLiveTimer()
        withAnimation { gm.playerWin = false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            gm.restartGame()
            bet = gm.bet
        }
    }
    
    func checkWinner() {
        gm.liveTimer?.cancel()
        if !gm.winnerDefined {
            if (dillerDrop.dillerSum > vm.botSum && dillerDrop.dillerSum <= 21) || vm.botSum > 21 {
                gm.bet = 0
                bet = 0
                gm.winnerDefined = true
                gm.setUpAnimation(whoWin: "Casino wins!")
            } else if (dillerDrop.dillerSum < vm.botSum || dillerDrop.dillerSum > 21) && vm.botSum <= 21  {
                gm.liveTimer?.cancel()
                gm.winnerDefined = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    gm.playerWin = true
                    gm.setUpLiveTimer()
                    
                }
            } else if dillerDrop.dillerSum == vm.botSum  {
                gm.winnerDefined = true
                gm.bet = 0
                bet = 0
                gm.setUpAnimation(whoWin: "Draw!")
            }
        }
    }
    
    
    func standOrHit()  {
        
        if gm.isDeal {
            gm.liveTimer?.cancel()
            gm.setUpLiveTimer()
            gm.isDeal = false
        }
    
        
        if vm.draggedCards.count == 2 && vm.botSum == 21 && dillerDrop.draggedCards.count == 2  {
            if dillerDrop.dillerSum == 21 {
                gm.setUpAnimation(whoWin: "Draw!")
            } else {
                gm.isBlackJack = true
                gm.playerWin = true
                gm.winnerDefined = true
            }
        }

        if vm.botSum < 9 {
            gm.decision = gm.randomNumber(probabilities: [0.4, 0.6])
            if gm.decision == 0 && vm.draggedCards.count == 2 {
                gm.setUpAnimation(whoWin: "Player surrenders!")
                gameMode = 0
            } else {
                gameMode = 2
            }
        }

        if vm.botSum >= 9 && vm.botSum < 12 {
            gm.decision = gm.randomNumber(probabilities: [0.3, 0.7])
            if gm.decision == 0 && gm.canDouble && vm.draggedCards.count == 2 {
                gameMode = 4
                gm.isDeal = false
                gm.isStand = false
                gm.isDouble = true
                gm.canDouble = false
                withAnimation {
                    gm.bet = gm.bet * 2
                    bet = bet * 2
                }
            } else {
                gameMode = 2
            }
        }


        if vm.botSum >= 12 && vm.botSum <= 13 {
            gm.decision = gm.randomNumber(probabilities: [0.8, 0.2])
            if gm.decision == 0 {
                gameMode = 2
            } else {
                gameMode = 3
                gm.isStand = true
            }
        }

        if vm.botSum > 13 && vm.botSum < 16 {
            gm.decision = gm.randomNumber(probabilities: [0.6, 0.4])
            if gm.decision == 0 {
                gameMode = 2
            } else {
                gameMode = 3
                gm.isStand = true
            }
        }


        if vm.botSum >= 16 && vm.botSum<19 {
            gm.decision = gm.randomNumber(probabilities: [0.15, 0.85])
            if gm.decision == 0 {
                gameMode = 2
            } else {
                gameMode = 3
                gm.isStand = true
            }
        }

        if vm.botSum >= 19 && vm.botSum < 21 {
            gm.decision = gm.randomNumber(probabilities: [0.01, 0.99])
            if gm.decision == 0 {
                gameMode = 2
            } else {
                gameMode = 3
                gm.isStand = true
            }
        }

        if vm.botSum == 21  {
            gameMode = 3
            gm.isStand = true
        }

        if vm.botSum > 21  {
            gameMode = -1
            gm.setUpAnimation(whoWin: "Casino wins!")
        }
        
        if gm.isStand && dillerDrop.dillerSum > 16 {
            checkWinner()
        }
        
        gm.canDouble = false
    }
}

private let gradient  =
LinearGradient(colors: [Color("questGradLight"), Color("questGradBright")], startPoint: .leading, endPoint: .trailing)
