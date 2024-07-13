//
//  SOSButtonView.swift
//  SumSumZip
//
//  Created by 원주연 on 7/13/24.
//

import SwiftUI

struct SOSButtonView: View {
    var body: some View {
//        ZStack{
            Image("SOSButtonView")
            .overlay(){
                SOSButtonOverlayView()
            }
        }
//    }
}

struct SOSButtonOverlayView: View {
    var body: some View{
        VStack(){

            Spacer().frame(maxHeight:50)

            Text("공황증상이 올 것 같다면\n지금 바로 PUSH")
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColors.green02)
                .font(.title2)
                
            Spacer().frame(maxHeight:200)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
                   label: {
                Image("SOSButton")
            })
        }
    }
}

#Preview {
    SOSButtonView()
}
