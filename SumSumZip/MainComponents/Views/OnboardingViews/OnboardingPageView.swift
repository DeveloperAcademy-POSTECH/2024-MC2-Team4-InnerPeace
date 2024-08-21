//
//  OnboardingPageView.swift
//  SumSumZip
//
//  Created by heesohee on 7/13/24.
//


import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    let pageCount: Int
    let currentPageIndex: Int
    @Binding var currentPage: OnboardingPage
    @Binding var isFirstLaunching: Bool
    @ObservedObject var screenSize = ScreenSize.shared // 스크린 사이즈 측정용 기능 모음
    
    var body: some View {
        let screenWidth = screenSize.screenWidth
        GeometryReader { geometry in
            
            let isIpad = geometry.size.width > 768 // 간단하게 아이패드 여부를 판단
            VStack(alignment: .center) {
                VStack(alignment: .center, spacing: 14) {
                    Text(title)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(Color(AppColors.green01))
                    
                    Text(subtitle)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                        .foregroundColor(Color(AppColors.gray02))
                        .multilineTextAlignment(.center) // Ensures subtitle is centered and not cut off
                }
                .frame(maxWidth: .infinity)
//                .padding(.horizontal, 20)
                .padding(.bottom, 10) // Adjusted padding to provide more space for subtitle
                
                Spacer()
                
                HStack {
                    ForEach(0..<pageCount, id: \.self) { index in
                        Circle()
                            .fill(currentPageIndex == index ? Color(AppColors.green01) : Color(AppColors.gray02))
                            .frame(width: 8, height: 8)
                    }
                }
                   .padding(.bottom, 10) 
//                Spacer()
                
                VStack {
                    
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: isIpad ? geometry.size.width * 0.5 : 283) // 아이패드면 크기를 키움
                        .padding(.bottom, isIpad ? -135 : -30) // 아이패드일 경우 -40, 아니면 -20
                                            
                    //    Spacer()
                    
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
                                    .background(Color(AppColors.OnBoardingButton1))
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
                            Button(action: {
                                isFirstLaunching = false
                            }) {
                                Text("완료")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 160, height: 56)
                                    .background(Color(AppColors.green01))
                                    .cornerRadius(17)
                            }
                        }
                    }
                    .frame(height: 56)
//                    .background(
//                        LinearGradient(gradient: Gradient(colors: [Color.color, Color.color2]), startPoint: .bottom, endPoint: .top)
//                    )
                    .padding(.bottom, 30)
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 0)
            }
        }
    }
}

#Preview {
    @State var currentPage: OnboardingPage = .first
    @State var isFirstLaunching: Bool = true

    return OnboardingPageView(
        imageName: "",
        title: "",
        subtitle: "",
        pageCount: 4, // 전체 페이지 수
        currentPageIndex: 0, // 현재 페이지 인덱스
        currentPage: $currentPage,
        isFirstLaunching: $isFirstLaunching
    )
}
