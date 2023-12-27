//
//  MenuView.swift
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var vm: LogicModel
    @State var rotation: Angle = .degrees(0)
    @State var size: CGSize = .zero
    
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
                    .offset(y: vm.size.width < 380 ? -vm.size.height * 0.15 :  -vm.size.height * 0.17)
                    
                    VStack(spacing: size.width < 380 ? 20 : 40) {
                        HStack(spacing: 20) {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 4)
                                .foregroundColor(.white)
                                .innerShadow(using:    RoundedRectangle(cornerRadius: 8), angle: .radians(0), color: .black.opacity(0.25), width: 1, blur: 1)
                                .shadow(color: .black.opacity(0.25), radius: 1)
                                .shadow(color: Color("menuRectShadow"), radius: 4)
                                .shadow(color: Color("menuRectShadow"), radius: 2)
                                .frame(height: size.width < 380 ? 45 : 50)
                                .overlay {
                                    HStack {
                                        Text(String(vm.balance))
                                            .font(Font.custom("RobotoCondensed-Bold",size: size.width < 380 ? 24 : 27))
                                            .foregroundColor(.white)
                                        
                                        Image("coin")
                                            .resizable()
                                            .scaledToFit()
                                            .rotation3DEffect(rotation, axis: (x: 0, y: 1, z: 0))
                                            .onTapGesture {
                                                withAnimation {
                                                    
                                                    rotation =  rotation == .degrees(0) ? .degrees(360) : .degrees(0)
                                                }
                                            }
                                    }
                                    .offset(x: 16)
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
                        .padding(.top, 16)
                        Spacer()
                    }
                    
                    VStack {
                      Spacer()

                        NavigationLink {
                            PlayView()
                        } label: {
                            BrightButton(text: "PLAY", fontSize: vm.size.width < 380 ? 30 : 34)
                                .padding(.horizontal, 64)
                        }
                        VStack(spacing: vm.size.width < 380 ? 20 : 34) {
                            NavigationLink {
                                PayoutView()
                            } label: {
                                DashedMenuBtn(color: Color( "lightGreenNeon"), dash: [40, 30, 25, 10], text: "TRAINING MODE", fontSize: vm.size.width < 380 ? 26 : 30)
                            }
                            NavigationLink {
                                KnowledgeBaseView()
                            } label: {
                                DashedMenuBtn(color: Color( "lightGreenNeon"), dash: [40, 30, 25, 10], text: "KNOWLEDGE BASE", fontSize: vm.size.width < 380 ? 26 : 30)
                            }
                            NavigationLink {
                                AllRewardsView()
                            } label: {
                                DashedMenuBtn(color: Color( "lightGreenNeon"), dash: [40, 30, 25, 10], text: "REWARDS", fontSize: vm.size.width < 380 ? 26 : 30)
                            }
                        }
                        .padding(.horizontal, 64)
                        .padding(.top, vm.size.width < 380 ? 20 : 40)

                    }
                    .padding(.bottom, 16)
                }
                .onAppear {
                    vm.resetToDefault()
                    vm.cancelAllTimers()
                    withAnimation(.easeIn(duration: 1)) {
                        
                        rotation =  rotation == .degrees(0) ? .degrees(360) : .degrees(0)
                    }
                }
                .preferredColorScheme(.dark)
            }
            .navigationViewStyle(.stack)
            .navigationBarHidden(true)
        }
}

private let gradient  =
LinearGradient(colors: [Color("questGradLight"), Color("questGradBright")], startPoint: .leading, endPoint: .trailing)

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
