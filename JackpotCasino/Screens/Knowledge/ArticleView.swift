//
//  ArticleView.swift
//

import SwiftUI

struct ArticleView: View {
    let article: [String]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BackgroundView()
           
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text(article[0])
                        .foregroundColor(Color("articleTitle"))
                        .font(Font.custom("RobotoCondensed-Bold",size: 32))
                        .padding(.bottom)
                    ForEach(1..<article.count, id: \.self) { index in
                        Text(article[index])
                            .foregroundColor(.white)
                            .font(Font.custom("RobotoCondensed-Bold",size: index % 2 == 0 ? 24 : 16))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom,index % 2 == 0 ? 4 : 12)
                    }
                }
                .padding()
                .preferredColorScheme(.dark)
            }
            VStack(alignment: .leading){
            
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill( Color.purple.opacity(0.001))
                                .frame(width: 50, height: 50)
                            Image("back")
                                .resizable()
                                .frame(width: 36, height: 36)
                        }
                    }
                }
                .padding(.horizontal, 4)
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: article[3])
    }
}
