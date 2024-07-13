//
//  OnboardingTabView.swift
//  SumSumZip
//
//  Created by heesohee on 7/13/24.
//


import SwiftUI

enum OnboardingPage: Int {
    case first
    case sosSetup
    case emergencyMessage
    case breathingExercise
}

struct OnboardingTabView: View {
    @Binding var isFirstLaunching: Bool
    @State private var currentPage: OnboardingPage = .first
    
    var body: some View {
        
        // 조건문을 걸어서 페이지를 넘겨야 함.(버튼에 액션을 넣는다고 되지 않는다.)
        if isFirstLaunching {
            // 온보딩 배경 이미지
            ZStack {
                switch currentPage {
                case .first:
                    Image("온보딩배경1")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                default:
                    Image("온보딩배경2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                }
                
                
                // 앱 소개 맨트들
                
                VStack {
                    TabView(selection: $currentPage) {
                        // 페이지 1: 앱 소개
                        OnboardingFisrtView(
                            imageName: "",
                            title: "반가워요!",
                            subtitle: "맘편한 하루를 위한 한걸음.",
                            subtitle2: "공황 환우들의 용기있는 한걸음을 응원합니다.\n위기 상황에 대비 할 수 있도록\nSOS 화면을 설정 하는 법을 알려드릴게요!"
                        ).multilineTextAlignment(.leading)
                            .kerning(-0.3)
                            .tag(OnboardingPage.first)
                            .padding(.leading, 16)
                        
                        // 페이지 2: SOS창 설정하기
                        OnboardingPageView(
                            imageName: "온보딩이미지1",
                            title: "SOS창 설정하기",
                            subtitle: "하단의 사용자 설정 탭에서\nSOS창에 대한 모든 설정을 할 수 있습니다."
                        ).multilineTextAlignment(.center)
                            .kerning(-0.3)
                            .tag(OnboardingPage.sosSetup)
                        
                        // 페이지 3: 긴급 메세지 기능
                        OnboardingPageView(
                            imageName: "온보딩이미지2",
                            title: "긴급 메세지 기능",
                            subtitle: "위기 상황 발생시에 SOS 버튼을 누르면\n도움을 요청하기 위한 긴급 메세지가 나타납니다."
                        ).multilineTextAlignment(.center)
                            .kerning(-0.3)
                            .tag(OnboardingPage.emergencyMessage)
                        
                        // 페이지 4: 호흡 연습하기 + 온보딩 완료
                        OnboardingPageView(
                            imageName: "온보딩이미지1",
                            title: "호흡 연습하기",
                            subtitle: "심호흡 연습은 긴장을 낮추고\n불안정한 호흡을 바로 잡을 수 있습니다.\n숨숨이를 따라 호흡 연습을 해보세요."
                            //    isFirstLaunching: $isFirstLaunching
                        ).multilineTextAlignment(.center)
                            .kerning(-0.3)
                            .tag(OnboardingPage.breathingExercise)
                    }
                    //                SumSumTabView()
                    
                    //    isFirstLaunching: $isFirstLaunching
                    
                    
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                }.padding(.bottom, 80)
                
                // 아래는 버튼을 다룹니다.
                VStack {
                    Spacer()
                    if currentPage == .first {
                        VStack {
                            Button {
                                // 숨숨집 설정 알아보기 버튼 액션: 다음 페이지로 넘기기
                                
                                currentPage = OnboardingPage(rawValue: currentPage.rawValue + 1) ?? .sosSetup
                                
                            } label: {
                                Text("숨숨집 설정 알아보기")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 365, height: 58)
                                    .background(Color(AppColors.green01))
                                    .cornerRadius(17)
                            }
                            
                            Button {
                                // 건너뛰기 버튼 액션
                                isFirstLaunching = false
                            } label: {
                                Text("건너뛰기")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .frame(width: 365, height: 58)
                                    .background(Color.black.opacity(0.2))
                                    .cornerRadius(17)
                            }
                        } // VStack 1번 페이지용 버튼
                        //                    .frame(height: 160)
                    } else {
                        HStack {
                            if currentPage.rawValue > 0 {
                                Button(action: {
                                    withAnimation {
                                        currentPage = OnboardingPage(rawValue: currentPage.rawValue - 1) ?? .first
                                    }
                                }) {
                                    Text("이전")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .frame(width: 160, height: 56)
                                        .background(Color.black.opacity(0.2))
                                        .cornerRadius(17)
                                }
                            }
                            
                            Spacer()
                            
                            if currentPage.rawValue < OnboardingPage.breathingExercise.rawValue {
                                Button(action: {
                                    withAnimation {
                                        currentPage = OnboardingPage(rawValue: currentPage.rawValue + 1) ?? .breathingExercise
                                    }
                                }) {
                                    Text("다음")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(width: 160, height: 56)
                                        .background(Color(AppColors.green01))
                                        .cornerRadius(17)
                                }
                            } else {
                                
                                // AppStorage의 isFirstLaunching 값을 false로 바꾸기 때문에, 다음번에 앱을 실행할 때는 OnboardingTabView를 띄우지 않음.
                                Button(action: {
                                    isFirstLaunching = false
                                    //    isFirstLaunching.toggle()
                                    
                                }) {
                                    Text("완료")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(width: 160, height: 56)
                                        .background(Color(AppColors.green01))
                                        .cornerRadius(17)
                                }
                            }
                        } // HStack 2-4페이지 전용 버튼
                        .frame(height: 56)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.color, Color.color2]), startPoint: .bottom, endPoint: .top))
                    } // else끝
                } // VStack전체 버튼들 들어있음
                .padding(.bottom, 56)
                .padding(.horizontal, 16)
            } // zstack
        } else {
            // 완료 버튼을 눌러서 isFirstLaunching이 false가 되면 SumSumTabView를 표시
            SumSumTabView()
        }
    }
}

struct OnboardingTabView_Previews: PreviewProvider {
    @State static var isFirstLaunching = true
    
    static var previews: some View {
        OnboardingTabView(isFirstLaunching: $isFirstLaunching)
    }
}
