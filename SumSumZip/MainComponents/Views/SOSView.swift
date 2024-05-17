//
//  SOSView.swift
//  SumSumZip
//
//  Created by 원주연 on 5/17/24.
//

import SwiftUI

struct SOSView: View {
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.black,Color("PointColor2"), Color("PointColor")]),
                               startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer().frame(height: 40)
                    Text("도움이 필요합니다")
                        .foregroundStyle(Color.white)
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 15)
                    Text("일시적인 공황 증상 발생")
                        .foregroundStyle(Color.white)
                        .font(.title2)
                    Spacer().frame(height: 120)
                    
                    Rectangle()
                        .foregroundStyle(Gradient(colors: [Color("PointColor2"), Color.white]))
                        .cornerRadius(150)
                        .shadow(radius: 10)
                        .shadow(color: .white, radius: 40)
                        .padding(.horizontal, 20)
                        .overlay{
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
                                   label: {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .cornerRadius(150)
                                    .overlay{
                                        VStack{
                                            Text("30분")
                                                .fontWeight(.bold)
                                                .foregroundStyle(Color.gray)
                                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
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
                            })
                            .padding(.vertical, 25)
                            .padding(.horizontal, 45)
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
                .foregroundStyle(Color("FontColor"))
            }
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar){
                    Button("환자 정보"){
                        print("환자 정보")
                    }
                    .foregroundStyle(Color.gray)
                    .font(.title3)
                    .fontWeight(.bold)
                    
                    Button("긴급 연락"){
                        print("긴급 연락")
                    }
                    .foregroundStyle(Color.red)
                    .font(.title3)
                    .fontWeight(.bold)
                }
            }
        }
    }
}
#Preview {
    SOSView()
}
