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
    @Binding var isAnimating: Bool
    @State private var showAlert: Bool = false
    
    @Binding var breathTime: Int
    @State private var timeRemaining: Int = 0
    @State private var timer: Timer?
    
    @StateObject private var breathTimerManager = BreathTimeManager.shared
    
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
            turtleWithCircle()
//                .foregroundStyle(.clear)
                .padding(.bottom, 100)
            
            // 진동 버튼
            vibrateButton()
        }
        .onAppear {
            print("start breathing timer")
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("완벽해요!"),
                        message: Text("하루하루 더 나아지는 자신을 느껴보세요"),
                        dismissButton: .default(Text("종료")) {
                            isShowingFirstView.toggle()
                            stopTimer()
                            breathTimerManager.stopTimer()
                        }
                    )
                }
    }
    
    func startTimer() {
        print("start timer: \(breathTime)")
        breathTimerManager.startHaptic()
        
        timeRemaining = breathTime * 60 // breathTime을 초 단위로 변환
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                isShowingFirstView.toggle()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        breathTimerManager.stopTimer()
        timer = nil
    }
    
    @ViewBuilder
    func stopButton() -> some View {
        Button(action: {
            // 알림 뜨기
            showAlert.toggle()
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
        Text(timeString(from: timeRemaining))
            .fontWeight(.thin)
            .font(.system(size: 50))
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @ViewBuilder
    func turtleWithCircle() -> some View {
        ZStack{
            Circle()
                .foregroundStyle(Gradient(colors: [Color.white, Color("PointColor2")]))
                .shadow(radius: 10)
                .shadow(color: .white, radius: 40)
                .padding(.horizontal, 20)
                .scaleEffect(isAnimating ? 0.8 : 1.5)
                .animation(.easeOut(duration: 7).delay(1).repeatForever(),
                           value: isAnimating)
            Circle()
                .foregroundStyle(.clear)
                .frame(width: 300, height: 300)
            Image("BreathintTurtleIntro")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.clear)
                .frame(width: 189, height: 221)
                .padding(.bottom, 86)
                .padding(.top, 64)
        }
        .onAppear(perform: {
            isAnimating.toggle()
                            })
        
//                            Spacer().frame(height: 20)
    }
    
    @ViewBuilder
    func vibrateIcon() -> some View {
        Image(systemName: "iphone.gen1.radiowaves.left.and.right")
            .font(.system(size: 50))
            .foregroundStyle(isVibrateOff ? AppColors.gray01 : AppColors.white)
    }
    
    @ViewBuilder
    func vibrateTitle() -> some View {
        Text(isVibrateOff ? "진동켜기" : "진동끄기")
            .fontWeight(.regular)
            .font(.system(size: 14))
            .foregroundStyle(isVibrateOff ? AppColors.gray01 : AppColors.white)
    }
    
    @ViewBuilder
    func vibrateButton() -> some View {
        Button(action: {
            isVibrateOff.toggle()
            if isVibrateOff {
                breathTimerManager.disableHaptic()
            } else {
                breathTimerManager.enableHaptic()
            }
        }, label: {
            VStack {
                vibrateIcon()
                    .padding(.bottom, 10)
                
                vibrateTitle()
            }
        })
    }
}
