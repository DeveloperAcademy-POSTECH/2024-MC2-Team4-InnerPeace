//
//  PracticeBreathingIntro.swift
//  SumSumZip
//
//  Created by 신승아 on 7/13/24.
//

import SwiftUI

struct PracticeBreathingIntro: View {
    
    @State var breathTime: Int = UserdefaultsManager.breathingPracticeInfo
    
    @State private var isShowingFirstView: Bool = true
    
    var body: some View {
        VStack {
            
            if isShowingFirstView {
                // 제목
                HStack {
                    Text("호흡 연습하기")
                        .fontWeight(.bold)
                        .font(.system(size: 32))
                        .padding(.leading, 17)
                        .foregroundStyle(AppColors.green01)
                    
                    Spacer()
                        .frame(height: 55)
                }
                
                HStack {
                    // 부제
                    Text("편안한 자세로 매일 조금씩 연습해보세요")
                        .font(.system(size: 17))
                        .padding(.leading, 17)
                        .foregroundStyle(AppColors.green01)
                    
                    Spacer()
                }
                
                // 거북이 움짤
                Rectangle()
                    .frame(width: 189, height: 221)
                    .padding(.bottom, 86)
                    .padding(.top, 64)
                
                // 정보
                TimerSelectionGroup(breathTime: $breathTime)
                    .padding(.bottom, 72)
                
                // 시작하기 버튼
                StartBreathButton(isShowingFirstView: $isShowingFirstView)
            } else {
                StartBreathView(isShowingFirstView: $isShowingFirstView)
            }
            
        }
    }
}

struct StartBreathButton: View {
    @Binding var isShowingFirstView: Bool
    
    var body: some View {
        Button(action: {
            // 버튼 액션 처리
            withAnimation(.easeInOut(duration: 0.5)) {
                isShowingFirstView.toggle()
            }
            
        }) {
            Text("시작하기")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .frame(width: 293, height: 62)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [AppColors.green07, AppColors.blue01]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(68) // 둥근 모서리
                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5) // 그림자 추가
        }
    }
}


struct TimerSelectionGroup: View {
    @Binding var breathTime: Int
    
    let times: [Int] = [1, 3, 5, 8, 10] 
    
    var body: some View {
        VStack {
            ZStack {
                // 중앙 줄
                middleLine()
                
                // 원들
                circles()
            }
        }
    }
    
    @ViewBuilder
    func middleLine() -> some View {
        Rectangle()
            .fill(AppColors.green06)
            .frame(width: 250,height: 6)
            .offset(y: -21)
            .padding(.horizontal, 43)
    }
    
    @ViewBuilder
    func circles() -> some View {
        HStack(spacing: 40) {
            ForEach(times, id: \.self) { time in
                TimeCircle(time: time, isSelected: time == breathTime)
                    .onTapGesture {
                        withAnimation {
                            breathTime = time
                        }
                    }
            }
        }
    }
}

struct TimeCircle: View {
    let time: Int
    let isSelected: Bool
    
    var body: some View {
        VStack {
            
            if isSelected {
                
                clickedCircle()
                
                Spacer().frame(height: 18)
                
            } else {
                defaultCircle()
                
                Spacer().frame(height: 21)
            }

            Text("\(time)분")
                .foregroundColor(AppColors.darkGreen)
        }
    }
    
    @ViewBuilder
    func clickedCircle() -> some View {
        Circle()
            .overlay {
                Image("TimerButton")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.blue)
            }
            .frame(width: 20, height: 20)
    }
    
    @ViewBuilder
    func defaultCircle() -> some View {
        Circle()
            .fill(AppColors.green06)
            .frame(width: 17, height: 17)
            .scaleEffect(1.0)
            .animation(.easeInOut, value: isSelected)
            .overlay(
                Circle()
                    .stroke(
                        .white,
                        lineWidth: 3
                    )
                    .scaleEffect(0)
            )
    }
}

#Preview {
    PracticeBreathingIntro()
}
