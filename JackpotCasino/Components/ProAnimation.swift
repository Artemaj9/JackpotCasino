//
//  ProAnimation.swift
//  JackpotCasino
//
//  Created by Artem on 21.12.2023.
//

import SwiftUI

private let size: CGFloat = 300
private let numLayers = 15
private let stepSize = 25

struct GeometryReaderPro: View {
    @State private var animating = false
    var body: some View {
        ZStack {
            ForEach(0..<numLayers) { index in
                ZStack {
                    Image("coin")
                        .rotationEffect(self.animating ? Angle(degrees: 90) : Angle(degrees: 0))
                        .shadow(radius: 5)
                        .frame(width: self.sizeForIndex(index), height:  self.sizeForIndex(index))
//                        .offset(x: CGFloat(Int.random(in: -150...150)), y: CGFloat(Int.random(in: -200...200)))
                        
                        .animation(Animation
                            .easeInOut(duration: 2)
                            .repeatForever()
                            .delay(self.delayForIndex(index)*0.5))
                      
                }
            }
            .onAppear {
                self.animating = true
            }
        }
       // .blur(radius:10)
       // .shadow(color: .purple, radius: 20)
        //.padding(100)
      //  .drawingGroup()
       // .frame(width: 100, height: 100)
       // .mask {
       //     Text("NUSELENOK")
       //         .font(.system(size: 55))
         //       .fontWeight(.black)
        //}
    }
    func delayForIndex(_ index: Int) -> Double {
        Double(numLayers - index) * 0.2
    }
    
    func sizeForIndex(_ index: Int) -> CGFloat {
        CGFloat((numLayers - index) * stepSize)
    }
}

private let gradient = LinearGradient(colors:[Color("wheelShadow"), Color.white], startPoint: .topLeading, endPoint: .bottomTrailing)

private struct PyramidLayer: View {
    var body: some View {
       // GeometryReader { (geo: GeometryProxy) in
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(gradient)
        }
                //.frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
      //  }
    }
}
struct GeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderPro()
    }
}


//struct ProAnimation: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct ProAnimation_Previews: PreviewProvider {
//    static var previews: some View {
//        ProAnimation()
//    }
//}
