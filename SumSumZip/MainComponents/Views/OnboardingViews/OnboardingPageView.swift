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
    @Binding var currentPage: OnboardingPage
    @Binding var isFirstLaunching: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            VStack(alignment: .center, spacing: 20) {
                Text(title)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(AppColors.green01))

                Text(subtitle)
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                    .foregroundStyle(Color(AppColors.gray02))
            }
            .frame(height: 131)

            Spacer()

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 292)

            Spacer()

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
        currentPage: $currentPage,
        isFirstLaunching: $isFirstLaunching
    )
}
