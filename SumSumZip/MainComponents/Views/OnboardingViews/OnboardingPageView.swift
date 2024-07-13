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
    
    var body: some View {
        VStack (alignment: .center, spacing: 20){
            VStack (alignment: .center, spacing: 20) {
                Text(title)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(AppColors.green01))
                
                Text(subtitle)
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                    .foregroundStyle(Color(AppColors.gray02))
            }.frame(height: 131)
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 292)
        } //VStack
        .padding(.top, 60)
    }
}

#Preview {
    OnboardingPageView(
        imageName: "",
        title: "",
        subtitle: ""
    )
}

