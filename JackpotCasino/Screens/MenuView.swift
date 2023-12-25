//
//  MenuView.swift
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var vm: LogicModel
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                Rectangle()
                    .fill(Color("infoRibbon").opacity(0.08))
                    .frame(width: 25)
                    .scaleEffect(4)
                    .rotationEffect(Angle.radians(-.pi/4))
                    .offset(y: -100)
                
                VStack(spacing: 40) {
                    HStack(spacing: 20) {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 4)
                            .foregroundColor(.white)
                            .innerShadow(using:    RoundedRectangle(cornerRadius: 8), angle: .radians(0), color: .black.opacity(0.25), width: 1, blur: 1)
                            .shadow(color: .black.opacity(0.25), radius: 1)
                            .shadow(color: Color("menuRectShadow"), radius: 4)
                            .shadow(color: Color("menuRectShadow"), radius: 2)
                            .frame(height: 50)
                            .overlay {
                                HStack {
                                    Text(String(vm.balance))
                                        .font(Font.custom("RobotoCondensed-Bold",size: 27))
                                        .foregroundColor(.white)
                                    
                                    Image("coin")
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                        NavigationLink {
                            InfoWelcome()
                        } label: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(gradient)
                                .shadow(color: Color("questGradBright"), radius: 8)
                            
                                .frame(width: 50,height: 50)
                                .overlay(
                                    Image("quest")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(10))
                        }
                    }
                    .padding(16)
                    .offset(y: 20)
                    
                    ZStack {
                        LightningRect()
                            .overlay(
                                LightningRect()
                                    .scaleEffect(0.85))
                        StrokedNeonText(text: "CAREER\nMODE", color: Color("purpleText"), shadowColor: Color("purpleText"), size: 64)
                    }
                    .overlay() {
                        Image("cloud")
                            .resizable()
                            .scaleEffect(0.3)
                            .overlay {
                                Text(String(vm.level))
                                    .font(Font.custom("RobotoCondensed-Bold",size: 30))
                                    .foregroundColor(Color("cloudNum"))
                            }
                            .offset(y: -104)
                    }
                    .offset(y: 20)
                    
                    NavigationLink {
                        PlayView()
                    } label: {
                        BrightButton(text: "PLAY", fontSize: 34)
                            .padding(.horizontal, 64)
                    }
                    .offset(y: 20)
                    
                    VStack(spacing: 34) {
                        NavigationLink {
                         PayoutView()
                        } label: {
                            DashedMenuBtn(color: Color( "lightGreenNeon"), dash: [40, 30, 25, 10], text: "TRAINING MODE")
                        }
                        NavigationLink {
                           KnowledgeBaseView()
                        } label: {
                            DashedMenuBtn(color: Color( "lightGreenNeon"), dash: [40, 30, 25, 10], text: "KNOWLEDGE BASE")
                        }
                        NavigationLink {
                            AllRewardsView()
                        } label: {
                            DashedMenuBtn(color: Color( "lightGreenNeon"), dash: [40, 30, 25, 10], text: "REWARDS")
                        }
                    }
                    .padding(.horizontal, 64)
                    .padding(.top, 40)
                    
                    Spacer()
                }
                }
            .preferredColorScheme(.dark)
        }
        .navigationViewStyle(.stack)
    }
}

private let gradient  =
LinearGradient(colors: [Color("questGradLight"), Color("questGradBright")], startPoint: .leading, endPoint: .trailing)

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
