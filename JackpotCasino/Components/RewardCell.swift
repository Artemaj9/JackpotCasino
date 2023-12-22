//
//  RewardCell.swift
//  JackpotCasino
//
//  Created by Artem on 22.12.2023.
//

import SwiftUI

struct RewardCell: View {
    
    let index: Int
    @State var isLocked: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("r\(index)Bg").opacity(0.15))
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 4)
                .foregroundColor(.white)
                .shadow(color: Color("r\(index)Bg"), radius: 4)
                .shadow(color: Color("r\(index)Bg"), radius: 4)
                .overlay {
                    Image("reward\(index)")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .blur(radius: isLocked ? 5 : 0)
                        .overlay {
                            if isLocked {
                                ZStack {
                                    Image("cloud")
                                        .resizable()
                                        .scaledToFit()
                                        .scaleEffect(0.7)
                                        .shadow(color: Color("r\(index)Bg"), radius: 4)
                                        .shadow(color: Color("r\(index)Bg"), radius: 4)
                                    Text(index == 1 ? "1" : "\((index-1)*5)")
                                        .font(Font.custom("RobotoCondensed-Bold", size: 30))
                                        .foregroundColor(Color("cloudNum"))
                                }
                            }
                        }
                }
        }
        .padding(2)
    }
}

struct RewardCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            RewardCell(index: 1)
                .padding()
        }
    }
}
