//
//  PayoutGameView.swift
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
                    .foregroundColor(.clear)
                    .font(.largeTitle)
                    .id(gameLogic.sum)
                    .background(
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                if gameLogic.sum == userMoney {
                                    endFlag = true
                                    gm.setUpAnimation(whoWin: "Player wins!")
                                }
                                
                                if gameLogic.sum > userMoney {
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
                    }
                       
                    )
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
            gameLogic.userMoney = Int(Double(userMoney) * coef)
            gameLogic.state = 0
            gameLogic.draggedChips = []
            gameLogic.sum = 0
            gm.setUpLiveTimer()
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
