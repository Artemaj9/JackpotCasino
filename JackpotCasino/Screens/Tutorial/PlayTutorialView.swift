//
//  PlayTutorialView.swift
//  JackpotCasino
//
//  Created by Artem on 28.12.2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct PlayTutorialView: View {
    
    @State var size: CGSize = .zero
    @StateObject var vm = CardDropDelegate()
    @StateObject var dillerDrop = DillerDropDelegate()
    @EnvironmentObject var gm: LogicModel
    @State var bet = 0
    @Binding var screen: Int
    let tableRatio = 0.21
    
    @State var gameMode = 1
    @State var endFlag = false
    @State var text = "Deal 2 cards to the player!"
    
    var body: some View {
        ZStack {
            BackgroundView()
                .background(
                    GeometryReader() { geo in
                        Color.clear.onAppear {
                            self.size = geo.size
                            print("width Play:  \(size.width)")
                            print("height Play: \(size.height)")
                        }
                    })
            VStack() {
                Button {
                    screen += 1
                } label: {
                    BrightButton(text: "CONTINUE", fontSize: 24)
                        .padding(.horizontal, 64)
                        .padding([.horizontal, .top])
                }
                
                GameModeView(selected: $gameMode)
                    .environmentObject(gm)
                
                Text(text)
                    .font(Font.custom("RobotoCondensed-Bold",size: 18))
                
                Spacer()
            }
            
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
                    if vm.draggedCards.count == 2 {
                        gameMode = 2
                        text = "Good! Deal another card to the player."
                    }
                    
                    if vm.draggedCards.count == 3 {
                        gameMode = 3
                        text = "Excellent! Now take yourself one card!"
                        gm.openDillerCards = true
                    }
                    
                    if gameMode == 3 && vm.draggedCards.count == 4 {
                        vm.botSum -= vm.draggedCards[3].number
                        vm.draggedCards.remove(at: 3)
                        
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
                        
//                        CardView(needToRotate: i == 0 || gameMode != 3 ? false : true, image: dillerDrop.draggedCards[i].image, width: 80, height: 120)
                        CardView(needToRotate: i != 0 || gm.openDillerCards ? true : false, image: dillerDrop.draggedCards[i].image, width: 80, height: 120)
                            .rotationEffect(Angle(degrees: CGFloat(-15)), anchor: .bottomTrailing)
                            .rotationEffect(Angle(degrees: CGFloat(15 * i)), anchor: .bottomTrailing)
                            .offset(x: size.width * -0.08, y: size.height*0.4)
                            .id(gm.openDillerCards)
                    }
//
//                    CardView(needToRotate: false, image: "Kings", width: 80, height: 120)
//                        .rotationEffect(Angle(degrees: CGFloat(-15)), anchor: .bottomTrailing)
//                        .offset(x: size.width * -0.08, y: size.height*0.4)
//
//                    CardView(needToRotate:  true, image: "Kings", width: 80, height: 120)
//                        .rotationEffect(Angle(degrees: CGFloat(-15)), anchor: .bottomTrailing)
//                        .rotationEffect(Angle(degrees: CGFloat(15 * 1)), anchor: .bottomTrailing)
//                        .offset(x: size.width * -0.08, y: size.height*0.4)
                    //  .id(gm.openDillerCards)
                }
                .id(gm.isStand)
                .onChange(of: dillerDrop.draggedCards.count) { newValue in
                    if dillerDrop.draggedCards.count > 2, gameMode != 3 {
                       dillerDrop.dillerSum -= dillerDrop.draggedCards[newValue - 1].number
                        dillerDrop.draggedCards.remove(at: newValue - 1)
                        
                    }
                    
                    if gameMode == 3 && dillerDrop.draggedCards.count == 3 {
                       text = "Perfect!"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            screen += 1
                        }
                    }
                  //  vm.allDeckCards.shuffle()
                    //dillerDrop.draggedCards.reverse()
                }
            }
            .onDrop(of: [UTType.url], delegate: dillerDrop)
            
            Group {
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
        }

            Rectangle()
                .frame(width: size.width, height: size.height/8.2)
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
                )
                .offset(y: size.height * 0.45)
                .offset(y: gm.animCount == 0 ? 150 : -10)
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
                
        }
        .preferredColorScheme(.dark)
        .onAppear {
            vm.addCards()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                dillerDrop.draggedCards.append(CardModel(image: "3d"))
                dillerDrop.draggedCards.append(CardModel(image: "4h"))
                dillerDrop.dillerSum = 7
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
    }
}


private let gradient  =
LinearGradient(colors: [Color("questGradLight"), Color("questGradBright")], startPoint: .leading, endPoint: .trailing)
