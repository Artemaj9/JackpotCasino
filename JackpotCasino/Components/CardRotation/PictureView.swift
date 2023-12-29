//
//  PictureView.swift
//

import SwiftUI

struct PictureView: View {
    let width : CGFloat
    let height : CGFloat
    let image: String
    @Binding var degree : Double
    
    var body: some View {
        Image(image)
        .resizable()
        .frame(width: width, height: height)
        .shadow(color: .gray, radius: 2, x: 0, y: 0)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
