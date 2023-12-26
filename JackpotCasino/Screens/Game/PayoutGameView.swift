//
//  PayoutGameView.swift
//  JackpotCasino
//
//  Created by Artem on 26.12.2023.
//
//
//  PayoutView.swift
//  JackpotCasino
//
//  Created by Artem on 23.12.2023.
//

import SwiftUI
import UniformTypeIdentifiers

private let chips = [1, 5, 100, 500]
////let columns: [GridItem] = [
//    GridItem(.flexible(), spacing: -30, alignment: nil),
//    GridItem(.flexible(), spacing: -40, alignment: nil),
//    GridItem(.flexible(), spacing: -50, alignment: nil),
//    GridItem(.flexible(), spacing: -50, alignment: nil),
//    GridItem(.flexible(), spacing: -70, alignment: nil),
//]

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
                    .foregroundColor(.pink)
                    .font(.largeTitle)
                    .id(gameLogic.sum)
                    .background(
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                if gameLogic.sum == userMoney {
                                    endFlag = true
                                    gm.setUpAnimation(whoWin: "Player wins!")
                                }
                            }
                        })
                    
            }
//
//                .onChange(of: gameLogic.state) { newValue in
//                    endFlag = true
//                }
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
                }
               // .contentShape(Rectangle())
                
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
                    }
                       
                    )
                .padding()
            //    .id(gameLogic.sum)
//                .onChange(of: gameLogic.sum) { newValue in
//                    if  gameLogic.sum == userMoney {
//                        endFlag = true
//                    }
//                }
//                .onChange(of: gameLogic.state) { newValue in
//                    if  gameLogic.sum == userMoney {
//                        endFlag = true
//                    }
//                }
                
               
                
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
            
            Image("timer")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.3)
                .overlay {
                    Text("10")
                        .foregroundColor(.white)
                        .font(Font.custom("RobotoCondensed-Bold",size: 33))
                }
                .offset(x: 158, y: -75)
    
        }
        .onAppear {
            gameLogic.userMoney = Int(Double(userMoney) * coef)
            gameLogic.state = 0
            gameLogic.draggedChips = []
            gameLogic.sum = 0
        }
        .preferredColorScheme(.dark)
    }
}

//
//struct PayoutGameView_Previews: PreviewProvider {
//    static var previews: some View {
////        PayoutGameView(userMoney: .constant(100), endFlag: .constant(false))
//    }
//}
