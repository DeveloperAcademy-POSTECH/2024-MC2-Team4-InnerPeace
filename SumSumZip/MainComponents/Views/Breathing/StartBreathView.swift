//
//  StartBreathView.swift
//  SumSumZip
//
//  Created by 신승아 on 7/13/24.
//

import SwiftUI

struct StartBreathView: View {
    
    @State private var isVibrateOff: Bool = false
    
    @Binding var isShowingFirstView: Bool
    
    var body: some View {
        
        VStack {
            // 종료하기
            HStack {
                Spacer()
                
                stopButton()
                    .padding(.trailing, 17)
                    .padding(.bottom, 36)
    
            }
            
            // 경과 시간
            timeElapsedTitle()
                .padding(.top, 36)
                .foregroundStyle(AppColors.green02)
            
            timerText()
                .padding(.bottom, 20)
                .foregroundStyle(AppColors.green02)
            
            // 거북이 움짤
            turtleGIF()
                .padding(.bottom, 144)
            
            // 진동 버튼
            vibrateButton()
        }
    }
    
    @ViewBuilder
    func stopButton() -> some View {
        Button(action: {
            isShowingFirstView.toggle()
        }, label: {
            Text("종료하기")
                .fontWeight(.light)
                .font(.system(size: 17))
                .foregroundStyle(AppColors.green01)
        })
    }
    
    @ViewBuilder
    func timeElapsedTitle() -> some View {
        Text("경과 시간")
            .fontWeight(.regular)
            .font(.system(size: 14))
    }
    
    @ViewBuilder
    func timerText() -> some View {
        Text("임의:임의")
            .fontWeight(.thin)
            .font(.system(size: 50))
    }
    
    @ViewBuilder
    func turtleGIF() -> some View {
        Rectangle()
            .frame(width: 189, height: 221)
    }
    
    @ViewBuilder
    func vibrateIcon() -> some View {
        Image(systemName: "iphone.gen1.radiowaves.left.and.right")
            .font(.system(size: 50))
            .foregroundStyle(isVibrateOff ? AppColors.gray01 : AppColors.white)
    }
    
    @ViewBuilder
    func vibrateTitle() -> some View {
        Text("진동 끄기")
            .fontWeight(.regular)
            .font(.system(size: 14))
            .foregroundStyle(isVibrateOff ? AppColors.gray01 : AppColors.white)
        
    }
    
    @ViewBuilder
    func vibrateButton() -> some View {
        Button(action: {
            isVibrateOff.toggle()
        }, label: {
            VStack {
                vibrateIcon()
                    .padding(.bottom, 10)
                
                vibrateTitle()
            }
        })
    }
}
