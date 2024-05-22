//
//  SOSView.swift
//  SumSumZip
//
//  Created by 원주연 on 5/20/24.
//

import SwiftUI

struct SOSView: View {
    @State private var isAnimating: Bool = false
    @State private var isShownSheet: Bool = false
    @State private var isShownContact: Bool = false

    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.black, AppColors.lightSage, AppColors.lightGreen]),
                               startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer().frame(height: 50)
                    Text("도움이 필요합니다")
                        .foregroundStyle(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding(.bottom, 7)
                    Text("일시적인 공황 증상 발생")
                        .foregroundStyle(Color.white)
                        .font(.title2)
                    Spacer().frame(height: 120)
                    
                    ZStack{
                        Capsule()
                            .foregroundStyle(Gradient(colors: [AppColors.lightSage, Color.white]))
                            .shadow(radius: 10)
                            .shadow(color: .white, radius: 40)
                            .padding(.horizontal, 20)
                        
                        Button(action: {
                            self.isShownSheet.toggle()
                        }, label: {
                            Rectangle()
                                .foregroundColor(.black)
                                .cornerRadius(150)
                                .overlay{
                                    VStack{
                                        Text("30분")
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.gray)
                                            .font(.title)
                                        Spacer().frame(height:10)
                                        Text("호흡 유도 시작")
                                            .fontWeight(.heavy)
                                            .foregroundStyle(Color.white)
                                            .font(.largeTitle)
                                        Spacer().frame(height:10)

                                        Text("버튼을 눌러 정상 호흡을 도와주세요")
                                            .foregroundStyle(Color.white)
                                        Spacer().frame(height:15)

                                    }
                                }
                                .padding(.vertical, 25)
                                .padding(.horizontal, 45)
                        })
                        .fullScreenCover(isPresented: $isShownSheet, content: {
                            BreathingView(isAnimating: $isAnimating, isShownSheet: $isShownSheet, isShownContact: $isShownContact)
                        })
                    }
                        
                    Spacer().frame(height: 100)
                    Text("만약 제가 의식이 없다면\n긴급연락과 119에 신고해주세요")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    Spacer().frame(height: 50)
                }
            }
            .toolbar{
                Button("상황종료"){
                    print("상황종료")
                }
                .foregroundStyle(AppColors.lightSage)
            }
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("환자 정보") {
                        print("환자 정보")
                    }
                    .foregroundStyle(Color.gray)
                    .font(.title3)
                    .fontWeight(.bold)
                    
                    Button("긴급 연락") {
                        print("긴급 연락")
                        isShownContact = true
                    }
                    .foregroundStyle(Color.red)
                    .font(.title3)
                    .fontWeight(.bold)
                }
            }
            .fullScreenCover(isPresented: $isShownContact, content: {
                ContactView(isShownContact: $isShownContact)
            })
        }
        .onAppear{
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .blur(radius: isShownContact ? 5.0 : 0)
    }
}

#Preview {
    SOSView()
}
