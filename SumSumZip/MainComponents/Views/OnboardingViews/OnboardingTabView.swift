//
//  OnboardingTabView.swift
//  SumSumZip
//
//  Created by heesohee on 7/13/24.
//


import SwiftUI

enum OnboardingPage: Int, CaseIterable {
    case first
    case sosSetup
    case emergencyMessage
    case breathingExercise
}

struct OnboardingTabView: View {
    @Binding var isFirstLaunching: Bool
    @State private var currentPage: OnboardingPage = .first

    var body: some View {
        if isFirstLaunching {
            ZStack {
                
                GeometryReader { geometry in
                    switch currentPage {
                    case .first:
                        Image("BG_Onboarding1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    default:
                        Image("BG_Onboarding2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)

                    }

                }
                
                VStack {
                    TabView(selection: $currentPage) {
                        OnboardingFirstView(
                            imageName: "",
                            title: "반가워요!",
                            subtitle: "맘편한 하루를 위한 한걸음.",
                            subtitle2: "공황 환우들의 용기있는 한걸음을 응원합니다.\n위기 상황에 대비 할 수 있도록",
                            subtitle3: "SOS 화면을 설정 하는 법을 알려드릴게요!",
                            currentPage: $currentPage,
                            isFirstLaunching: $isFirstLaunching
                        )
                        .tag(OnboardingPage.first)
                        .multilineTextAlignment(.leading)
                        .kerning(-0.3)
                       
                        OnboardingPageView(
                            imageName: "Img_Onboarding1",
                            title: "SOS창 설정하기",
                            subtitle: "하단의 사용자 설정 탭에서\nSOS창에 대한 모든 설정을 할 수 있습니다.",
                            pageCount: 3, // 전체 페이지 수
                            currentPageIndex: 0, // 현재 페이지 인덱스
                            currentPage: $currentPage,
                            isFirstLaunching: $isFirstLaunching
                        )
                        .tag(OnboardingPage.sosSetup)
                        .multilineTextAlignment(.center)
                        .kerning(-0.3)

                        OnboardingPageView(
                            imageName: "Img_Onboarding2",
                            title: "긴급 메시지 기능",
                            subtitle: "위기 상황 발생 시 SOS 버튼을 누르면\n도움을 요청하기 위한 긴급 메시지가 나타납니다.",
                            pageCount: 3, // 전체 페이지 수
                            currentPageIndex: 1, // 현재 페이지 인덱스
                            currentPage: $currentPage,
                            isFirstLaunching: $isFirstLaunching
                        )
                        .tag(OnboardingPage.emergencyMessage)
                        .multilineTextAlignment(.center)

                        OnboardingPageView(
                            imageName: "Img_Onboarding1",
                            title: "호흡 연습하기",
                            subtitle: "심호흡 연습은 긴장을 낮추고\n불안정한 호흡을 바로 잡을 수 있습니다.\n숨숨이를 따라 호흡 연습을 해보세요.",
                            pageCount: 3, // 전체 페이지 수
                            currentPageIndex: 2, // 현재 페이지 인덱스
                            currentPage: $currentPage,
                            isFirstLaunching: $isFirstLaunching
                        )
                        .tag(OnboardingPage.breathingExercise)
                        .multilineTextAlignment(.center)
                        .kerning(-0.3)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .padding(.top, 120)
                
                
            
            } // zstack
        } else {
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
