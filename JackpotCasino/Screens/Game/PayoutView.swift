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
    
    var body: some View {
        ZStack {
            BackgroundView()
            Image("table")
                .resizable()
                .offset(y: 150)
            VStack() {
                BrightButton(text: "CONTINUE", fontSize: 28)
                    .padding(.horizontal, 64)
                    .padding()
                DashedMenuBtn(color: Color( "lightPinkNeon"), dash: [40, 30, 25, 10], text: "2500")
                    .padding(.horizontal, 84)
                Text("\(gameLogic.sum)")
                    .font(Font.custom("RobotoCondensed-Bold",size: 44))
                    .foregroundColor(.white)
            
                  
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
                                .foregroundColor(.white.opacity(0.3))
                                .offset(y: 35)
                               // .padding(100)
                   
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
    }
}
