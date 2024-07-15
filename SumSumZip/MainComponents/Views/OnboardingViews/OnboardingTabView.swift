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
                switch currentPage {
                case .first:
                    Image("BG_Onboarding1")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                default:
                    Image("BG_Onboarding2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                }

                VStack {
                    TabView(selection: $currentPage) {
                        OnboardingFirstView(
                            imageName: "",
                            title: "반가워요!",
                            subtitle: "맘편한 하루를 위한 한걸음.",
                            subtitle2: "공황 환우들의 용기있는 한걸음을 응원합니다.\n위기 상황에 대비 할 수 있도록\nSOS 화면을 설정 하는 법을 알려드릴게요!",
                            currentPage: $currentPage,
                            isFirstLaunching: $isFirstLaunching
                        )
                        .tag(OnboardingPage.first)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 16)

                        OnboardingPageView(
                            imageName: "Img_Onboarding1",
                            title: "SOS창 설정하기",
                            subtitle: "하단의 사용자 설정 탭에서\nSOS창에 대한 모든 설정을 할 수 있습니다.",
                            currentPage: $currentPage,
                            isFirstLaunching: $isFirstLaunching
                        )
                        .tag(OnboardingPage.sosSetup)
                        .multilineTextAlignment(.center)

                        OnboardingPageView(
                            imageName: "Img_Onboarding2",
                            title: "긴급 메시지 기능",
                            subtitle: "위기 상황 발생 시 SOS 버튼을 누르면\n도움을 요청하기 위한 긴급 메시지가 나타납니다.",
                            currentPage: $currentPage,
                            isFirstLaunching: $isFirstLaunching
                        )
                        .tag(OnboardingPage.emergencyMessage)
                        .multilineTextAlignment(.center)

                        OnboardingPageView(
                            imageName: "Img_Onboarding1",
                            title: "호흡 연습하기",
                            subtitle: "심호흡 연습은 긴장을 낮추고\n불안정한 호흡을 바로 잡을 수 있습니다.\n숨숨이를 따라 호흡 연습을 해보세요.",
                            currentPage: $currentPage,
                            isFirstLaunching: $isFirstLaunching
                        )
                        .tag(OnboardingPage.breathingExercise)
                        .multilineTextAlignment(.center)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .padding(.bottom, 80)
            }
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
