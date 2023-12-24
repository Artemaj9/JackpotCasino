//
//  PlayView.swift
//  JackpotCasino
//
//  Created by Artem on 24.12.2023.
//

import SwiftUI
import UniformTypeIdentifiers
import MobileCoreServices

struct PlayView: View {
    
    @State var size: CGSize = .zero
    @StateObject var vm = CardDropDelegate()
    let tableRatio = 0.2
    
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
                Rectangle().frame(width:300, height: 500).opacity(0.001)
                    .layoutPriority(-1)
                NeonRect(color: Color("redNeon"), shadow: Color("redNeon"), strokeCoeff: 0.5)
                    .frame(width: size.height * 0.23, height: size.height * 0.23)
                    .rotationEffect(Angle(degrees: 15))
                    .offset(x: size.width * 0.19)
                    .overlay {
                        HStack {
                            ForEach(vm.draggedCards) { card in
                                CardView(image: card.image, width: 70, height: 100)
                                
                            }
                        }
                    }
            }
                .onDrop(of: [UTType.url], delegate: vm)
            
       
            
            NeonRect(color: Color("freshBlueNeon"), shadow: Color("freshBlueNeon"), strokeCoeff: 0.5)
                .frame(width: size.height * 0.23, height: size.height * 0.23)
                .rotationEffect(Angle(degrees: 15))
                .offset(x: -size.width * 0.08, y: size.height*0.38)
            StatCell(title: "Player's Hand", color: Color("redNeon"), num: 7)
            .offset(x: -size.width * 0.34, y: -size.height*0.07)
            
            StatCell(title: "Your's Hand", color: Color("freshBlueNeon"), num: 21, alignment: .trailing)
            .offset(x: size.width * 0.34, y: size.height*0.25)
            
            
            
            ZStack {
                ForEach(vm.allDeckCards) { card in
            
                    CardView(image: card.image, width: 70, height: 100)
                        .onDrag {
                            NSItemProvider(item: .some(URL(string: card.image)! as NSSecureCoding), typeIdentifier: UTType.url.identifier)
                        }
                        .rotationEffect(Angle(degrees: 30))
                        .offset(x: -size.width * 0.33, y: size.height * 0.15)
                        
                }
            }
                
        }
        .preferredColorScheme(.dark)
        .onAppear {
            vm.addCards()
            vm.allDeckCards.shuffle()
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
