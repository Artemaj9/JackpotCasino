//
//  CardView.swift
//  JackpotCasino
//
//  Created by Artem on 24.12.2023.
//

import SwiftUI

struct CardView: View {
    //MARK: Variables
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false

    var needToRotate = false
    
    let image: String
    let width : CGFloat
    let height : CGFloat
    let durationAndDelay : CGFloat = 0.3

    //MARK: Flip Card Function
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    //MARK: View Body
    var body: some View {
        ZStack {
            PictureView(width: width, height: height,image: image, degree: $frontDegree)
            BackView(width: width, height: height, degree: $backDegree)
        }.onTapGesture {
            flipCard ()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if needToRotate {
                    flipCard()
                }
            }
        }
    }
}
