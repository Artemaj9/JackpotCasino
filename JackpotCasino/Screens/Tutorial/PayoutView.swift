//
//  PayoutView.swift
//  JackpotCasino
//
//  Created by Artem on 23.12.2023.
//

import SwiftUI
import UniformTypeIdentifiers

private let chips = [1, 5, 100, 500]
let columns: [GridItem] = [
    GridItem(.flexible(), spacing: -30, alignment: nil),
    GridItem(.flexible(), spacing: -40, alignment: nil),
    GridItem(.flexible(), spacing: -50, alignment: nil),
    GridItem(.flexible(), spacing: -50, alignment: nil),
    GridItem(.flexible(), spacing: -70, alignment: nil),
]

struct PayoutView: View {
    
    @StateObject var gameLogic = GameViewModel()
    @EnvironmentObject var gm: LogicModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BackgroundView()
            Image("table")
                .resizable()
                .offset(y: 150)
            VStack() {
                Button {
                    withAnimation {
                        gm.isTutorialShown = true
                    }
                } label: {
                    BrightButton(text: "CONTINUE", fontSize: 28)
                        .padding(.horizontal, 64)
                        .padding()
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
                                Text(String(gameLogic.sum))
                                    .foregroundColor(.white)
                                    .font(Font.custom("RobotoCondensed-Bold",size: gm.size.width < 380 ? 32 : 36))
                            })
                  
                Spacer()
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
                                .foregroundColor(.white.opacity(0.2))
                                .offset(y: 45)
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
                        .onChange(of: gameLogic.draggedChips.count) { newValue in
                            if gameLogic.sum == gameLogic.userMoney {
                            }
                            if gameLogic.sum > gameLogic.userMoney {
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
        .preferredColorScheme(.dark)
    }
}


struct PayoutView_Previews: PreviewProvider {
    static var previews: some View {
        PayoutView()
            .environmentObject(LogicModel())
    }
}
