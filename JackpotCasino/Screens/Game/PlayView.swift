//
//  PlayView.swift
//

import SwiftUI
import UniformTypeIdentifiers
import MobileCoreServices

struct PlayView: View {
    
    @State var size: CGSize = .zero
    @StateObject var vm = CardDropDelegate()
    @StateObject var dillerDrop = DillerDropDelegate()
    @EnvironmentObject var gm: LogicModel
    @State var bet = 0
    let tableRatio = 0.2
    
    @State var gameMode = -1
    @State var endFlag = false
    
    var body: some View {
        ZStack {
            BackgroundView()
                .background(
                    GeometryReader() { geo in
                        Color.clear.onAppear {
                            self.size = geo.size
                            print("width:  \(size.width)")
                            print("height: \(size.height)")
                        }
                        })
            
           
                VStack(spacing: 40) {
                    HStack(spacing: 30) {
                        GameHeaderCell(image: "heart", text: "10")
                        GameHeaderCell(image: "watches", text: "\(gm.remainingTime/60):\(gm.remainingTime%60/10)\(gm.remainingTime%60%10)", dashPhase: 22)
                        PauseCell(textMode: gm.playerWin ? "Payout" : "Dealing")
                    }
                    .offset(y: 50)

                        RoundedRectangle(cornerRadius: 6)
                            .strokeBorder(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [60, 30, 100, 20], dashPhase: 0))
                            .foregroundColor(Color("whitePink"))
                            .frame(width: 200, height: 50)
                            .shadow(color: Color("lightPinkNeon"), radius: 4)
                            .shadow(color: Color("lightPinkNeon"), radius: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color("pinkBg"))
                                    .shadow(color: Color("lightPinkNeon"), radius: 1, x: -5)
                                    .overlay {
                                        Text(String(gm.bet))
                                            .foregroundColor(.white)
                                            .font(Font.custom("RobotoCondensed-Bold",size: 36))
                                            .animation(.easeInOut, value: gm.bet)
                                            .onChange(of: gm.bet, perform: { newValue in
                                                gameMode = 1
                                            })
                                            .onTapGesture {
                                                startGame()
                                            }
                                    }
                                
                            )
                    if !gm.playerWin {
                        GameModeView(selected: $gameMode)
                            .environmentObject(gm)
                    }
                }
                .offset(y: -size.height * 0.4)
            
            if !gm.playerWin {
                Image("table")
                    .resizable()
                    .offset(y: tableRatio * size.height)
                
                ZStack {
                    Image("carddeck")
                        .resizable()
                        .scaleEffect(0.5)
                }
                .offset(x: -size.width*0.25,y: size.height * 0.1)
                
                ZStack {
                    Rectangle().frame(width:300, height: 300)
                        .opacity(0.001)
                        .offset(x: 100)
                        .layoutPriority(-1)
                    NeonRect(color: Color("redNeon"), shadow: Color("redNeon"), strokeCoeff: 0.5)
                        .frame(width: size.height * 0.23, height: size.height * 0.23)
                        .rotationEffect(Angle(degrees: 15))
                        .offset(x: size.width * 0.19)
                    
                    ZStack {
                        ForEach(vm.draggedCards.indices, id: \.self) { i in
                            CardView(needToRotate: true,image: vm.draggedCards[i].image, width: 80, height: 120)
                                .rotationEffect(Angle(degrees: CGFloat(2)), anchor: .topLeading)
                                .rotationEffect(Angle(degrees: CGFloat(15 * i)), anchor: .topLeading)
                                .offset(x: size.width * 0.31)
                        }
                    }
                    .onChange(of: vm.draggedCards.count) { newValue in
                        
                       
                        if !gm.isDeal {
                            standOrHit()
                        }
                        
                        if gm.isStand && dillerDrop.dillerSum > 16 {
                            checkWinner()
                        }
                        
                        if gm.isDeal {
                            if newValue == 2 && dillerDrop.draggedCards.count == 2 {
                                print("Success")
                                gm.isDeal = false
                                standOrHit()
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
                            CardView(needToRotate: i == 0 ? false : true,image: dillerDrop.draggedCards[i].image, width: 80, height: 120)
                                .rotationEffect(Angle(degrees: CGFloat(-15)), anchor: .bottomTrailing)
                                .rotationEffect(Angle(degrees: CGFloat(15 * i)), anchor: .bottomTrailing)
                                .offset(x: size.width * -0.08, y: size.height*0.4)
                        }
                    }
                    .onChange(of: dillerDrop.draggedCards.count) { newValue in
                        vm.allDeckCards.shuffle()
                        dillerDrop.draggedCards.reverse()
                        if gm.isDeal {
                            if newValue == 2 && vm.draggedCards.count == 2 {
                                print("Success")
                                gm.isDeal = false
                                standOrHit()
                            }
                        }
                        
                        if gm.isStand && dillerDrop.dillerSum > 16 {
                            checkWinner()
                        }
                        
//                        if gm.isStand && dillerDrop.dillerSum > 16 && dillerDrop.dillerSum <= 21 {
//                            if dillerDrop.dillerSum > vm.botSum  {
//                                print("DILLER WIN")
//                            } else if dillerDrop.dillerSum < vm.botSum {
//                                print("PLAYER WIN")
//                                gm.playerWin = true
//                            } else {
//                                print("DRAW")
//                                gm.playerWin = true
//
//                            }
//                        }
                        
                        
                    }
                }
                .onDrop(of: [UTType.url], delegate: dillerDrop)
                
                
                StatCell(title: "Player's Hand", color: Color("redNeon"), num: vm.botSum)
                    .offset(x: -size.width * 0.34, y: -size.height*0.07)
                
                StatCell(title: "Your's Hand", color: Color("freshBlueNeon"), num: dillerDrop.dillerSum, alignment: .trailing)
                
                    .offset(x: size.width * 0.34, y: size.height*0.25)
                
                ZStack {
                    CardView(image: "CardBack", width: 70, height: 100)
                        .onDrag {
                            NSItemProvider(item: .some(URL(string:  vm.allDeckCards[0].image)! as NSSecureCoding), typeIdentifier: UTType.url.identifier)
                        }
                        .rotationEffect(Angle(degrees: 30))
                        .offset(x: -size.width * 0.33, y: size.height * 0.15)
                }
            } else {
                PayoutGameView(userMoney: $bet, endFlag: $endFlag)
                    .environmentObject(gm)
                    .transition(.move(edge: .bottom))
                    .onChange(of: endFlag) { newValue in
                        print("OK")
                    }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        .onAppear {
            vm.addCards()
            vm.allDeckCards.shuffle()
            gm.remainingTime = 180
            gm.countdown()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                gm.stake()
                bet = gm.bet
            }
        }
    }
    
    
    func startGame() {
        vm.draggedCards = []
        dillerDrop.draggedCards = []
        vm.botSum = 0
        dillerDrop.dillerSum = 0
        gameMode = 1
        withAnimation { gm.playerWin = false }
        gm.remainingTime = 180
        gm.countdown()
        gm.restartGame()
    }
    
    func checkWinner() {
        if (dillerDrop.dillerSum > vm.botSum && dillerDrop.dillerSum <= 21) || vm.botSum > 21 {
            print("DILLER WIN")
        } else if (dillerDrop.dillerSum < vm.botSum || dillerDrop.dillerSum > 21) && vm.botSum <= 21  {
            print("PLAYER WIN")
            gm.playerWin = true
        } else {
            print("DRAW")
        }
    }
    
    
    func standOrHit()  {
        
        if vm.botSum < 9 {
            gm.decision = gm.randomNumber(probabilities: [0.1, 0.9])
            if gm.decision == 0 {
                print("I prefer to surrender!")
                gameMode = 0
            } else {
                print("I have \(vm.botSum) and prefer HIT!!!")
                gameMode = 2
            }
        }
        
        if vm.botSum >= 9 && vm.botSum < 12 {
            gm.decision = gm.randomNumber(probabilities: [0.35, 0.65])
            if gm.decision == 0 {
                print("I prefer to Double!")
                gameMode = 4
                withAnimation {
                    gm.bet = gm.bet * 2
                }
            } else {
                print("I have \(vm.botSum) and prefer HIT!!!")
                gameMode = 2
            }
        }
        
        
        if vm.botSum >= 12 && vm.botSum <= 13 {
            gm.decision = gm.randomNumber(probabilities: [0.8, 0.2])
            if gm.decision == 0 {
                print("I have \(vm.botSum) and prefer HIT!!!")
                gameMode = 2
            } else {
                print("I have \(vm.botSum) and prefer to stand!!")
                gameMode = 3
                gm.isStand = true
            }
        }
        
        
        
        if vm.botSum > 13 && vm.botSum < 16 {
            gm.decision = gm.randomNumber(probabilities: [0.6, 0.4])
            if gm.decision == 0 {
                print("I have \(vm.botSum) and prefer HIT!!!")
                gameMode = 2
            } else {
                print("I have \(vm.botSum) and prefer to stand!!")
                gameMode = 3
                gm.isStand = true
            }
        }
        
        
        if vm.botSum >= 16 && vm.botSum<19 {
            gm.decision = gm.randomNumber(probabilities: [0.15, 0.85])
            if gm.decision == 0 {
                print("I have \(vm.botSum) and prefer HIT!!!")
                gameMode = 2
            } else {
                print("I have \(vm.botSum) and prefer to stand!!")
                gameMode = 3
                gm.isStand = true
            }
        }
        
        if vm.botSum >= 19 && vm.botSum < 21 {
            gm.decision = gm.randomNumber(probabilities: [0.01, 0.99])
            if gm.decision == 0 {
                print("I have \(vm.botSum) and prefer HIT!!!")
                gameMode = 2
            } else {
                print("I have \(vm.botSum) and prefer to stand!!")
                gameMode = 3
                gm.isStand = true
            }
        }
        
        if vm.botSum == 21  {
            print("Of course i prefer to stand!!!")
            gameMode = 3
            gm.isStand = true
        }
        if vm.botSum > 21  {
            print("I'm loose my money")
            gameMode = -1
        }
        
        if gm.isStand && dillerDrop.dillerSum > 16 {
            checkWinner()
        }
    }
}


private let gradient  =
LinearGradient(colors: [Color("questGradLight"), Color("questGradBright")], startPoint: .leading, endPoint: .trailing)

//struct PlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayView()
//            .environmentObject(GameL)
//    }
//}



