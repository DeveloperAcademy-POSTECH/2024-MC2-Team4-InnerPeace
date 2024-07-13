//
//  OnboardingFisrtView.swift
//  Sum2
//
//  Created by heesohee on 7/13/24.
//

//
//  SwiftUIView.swift
//  Sum2
//
//  Created by heesohee on 7/13/24.
//

//  OnboardingPageView.swift

import SwiftUI

struct OnboardingFisrtView: View {
    let imageName: String
    let title: String
    let subtitle: String
    let subtitle2: String
    
    var body: some View {
            VStack (alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                Text(subtitle)
                    .font(.system(size: 27))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(AppColors.green01))
                Text(subtitle2)
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                    .foregroundStyle(Color(AppColors.gray02))
                //            Image(systemName: imageName)
                //                .font(.system(size: 200))
                
                
            } //VStack
         //   .frame(width: 400)
         //   .padding(.leading, 16)
            .padding(.bottom, 460)
        
        // 왼쪽 패딩 16 줘야함!
    }
}


#Preview {
    OnboardingFisrtView(
        imageName: "",
        title: "",
        subtitle: "",
        subtitle2: ""
    )
}

