//
//  SwiftUIView.swift
//  SumSumZip
//
//  Created by heesohee on 7/13/24.
//

import SwiftUI

struct OnboardingFirstView: View {
    let imageName: String
    let title: String
    let subtitle: String
    let subtitle2: String
    @Binding var currentPage: OnboardingPage
    @Binding var isFirstLaunching: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundStyle(Color(AppColors.green01))

            Text(subtitle)
                .font(.system(size: 17))
                .fontWeight(.regular)
                .foregroundStyle(Color(AppColors.gray02))

            Text(subtitle2)
                .font(.system(size: 17))
                .fontWeight(.regular)
                .foregroundStyle(Color(AppColors.gray02))

            Spacer()

            VStack {
                Button {
                    currentPage = .sosSetup
                } label: {
                    Text("숨숨집 설정 알아보기")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 365, height: 58)
                        .background(Color(AppColors.green01))
                        .cornerRadius(17)
                }

                Button {
                    isFirstLaunching = false
                } label: {
                    Text("건너뛰기")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(width: 365, height: 58)
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(17)
                }
            }
            .padding(.bottom, 40)
         //   .padding(.horizontal, 16)
        }
       
    }
}

#Preview {
    @State var currentPage: OnboardingPage = .first
    @State var isFirstLaunching: Bool = true

    return OnboardingFirstView(
        imageName: "",
        title: "반가워요!",
        subtitle: "맘편한 하루를 위한 한걸음.",
        subtitle2: "공황 환우들의 용기있는 한걸음을 응원합니다.\n위기 상황에 대비 할 수 있도록\nSOS 화면을 설정 하는 법을 알려드릴게요!",
        currentPage: $currentPage,
        isFirstLaunching: $isFirstLaunching
    )
}
