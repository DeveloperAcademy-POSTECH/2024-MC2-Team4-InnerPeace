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
    @State private var showAlert: Bool = false
    
    @Binding var breathTime: Int
    @State private var timeRemaining: Int = 0
    @State private var timer: Timer?
    
    @StateObject private var breathTimerManager = BreathTimeManager.shared
    
    private let firebase = FirebaseAnalyticsManager()
    
    var body: some View {
        VStack {
            // 종료하기
            HStack {
                Spacer()
                
                stopButton()
                    .padding(.trailing, 17)
                    .padding(.top, 17)
    
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
                .foregroundStyle(.clear)
                .padding(.bottom, 144)
            
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
                            firebase.logBreathingEndClick()
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
    func turtleGIF() -> some View {
        if UIScreen.main.bounds.height < 700 {
            GifImageViewer("BreathingSumSum")
                .frame(width: 160, height: 188)
        } else {
            GifImageViewer("BreathingSumSum")
                .frame(width: 189, height: 221)
        }
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
                    .padding(.bottom, 20)
                
                vibrateTitle()
            }
        })
    }
}
