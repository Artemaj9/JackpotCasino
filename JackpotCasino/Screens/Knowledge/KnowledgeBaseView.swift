//
//  KnowledgeBaseView.swift
//

import SwiftUI

struct KnowledgeBaseView: View {
    
    @State private var width: CGFloat = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack {
                BackgroundView()
                    .background(
                        GeometryReader() { geo in
                            Color.clear.onAppear {
                                self.width = geo.size.width
                                print(width)
                            }
                        }
                    )
                VStack(spacing: width < 380 ? -16 : -24) {
                        HStack {
                            Spacer()
                            Button {
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill( Color.purple.opacity(0.001))
                                        .frame(width: 50, height: 50)
                                    Button {
                                        dismiss()
                                    } label: {
                                        Image("back")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    }
                                }
                                .padding([.trailing], width < 380 ? 8 : 16)
                            }
                            .offset(x: 4)
                        }
                        VStack (spacing: 8) {
                            Text("KNOWLEDGE BASE")
                                .foregroundColor(.white)
                                .font(Font.custom("RobotoCondensed-Medium",size: width < 380 ? 35 : 36))
                            
                            ScrollView(showsIndicators: false) {
                                ForEach (1..<5) { h in
                                    HStack(spacing: 8) {
                                        ForEach (1..<3) { w in
                                            NavigationLink {
                                                ArticleView(article:article[w+(h - 1)*2 - 1])
                                            } label: {
                                                Image(KnowledgeBase.sections[w+(h - 1)*2 - 1])
                                                    .resizable()
                                                    .scaledToFill()
                                            }
                                        }
                                    }
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 2)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                
            }
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
        }
    }

struct KnowledgeBaseView_Previews: PreviewProvider {
    static var previews: some View {
        KnowledgeBaseView()
    }
}
