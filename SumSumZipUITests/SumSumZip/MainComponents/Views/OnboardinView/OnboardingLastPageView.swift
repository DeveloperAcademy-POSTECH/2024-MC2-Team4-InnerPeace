//
//  SwiftUIView.swift
//  Sum2
//
//  Created by heesohee on 7/13/24.
//


import SwiftUI

struct OnboardingLastPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
//    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        VStack (alignment: .center, spacing: 20){
       
            Text(title)
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundStyle(Color(AppColors.green01))
        
            Text(subtitle)
                .font(.system(size: 17))
                .fontWeight(.regular)
                .foregroundStyle(Color(AppColors.gray02))
           
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 292)
        } //VStack
        .padding(.top, 60)
    }
}

