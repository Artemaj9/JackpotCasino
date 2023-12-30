//
//  CardView.swift
//

import SwiftUI

struct CardView: View {

    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false

    var needToRotate = false
    
    let image: String
    let width : CGFloat
    let height : CGFloat
    let durationAndDelay : CGFloat = 0.3


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

    var body: some View {
        ZStack {
            PictureView(width: width, height: height,image: image, degree: $frontDegree)
            BackView(width: width, height: height, degree: $backDegree)
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
