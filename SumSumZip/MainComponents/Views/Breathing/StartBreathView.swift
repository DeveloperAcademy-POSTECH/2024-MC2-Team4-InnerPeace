//
//  StartBreathView.swift
//  SumSumZip
//
//  Created by 신승아 on 7/13/24.
//

import SwiftUI

class BreathTimeViewModel: ObservableObject {
    @Published var timerRemaining: Int = 0
    private var timer: Timer?
    private var initialTime: Int
    
    init(initialTime: Int) {
        self.initialTime = initialTime
        self.timerRemaining = initialTime * 60
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timerRemaining > 0 {
                self.timerRemaining -= 1
            } else {
                self.stopTimer()
            }
            
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        self.timerRemaining = initialTime * 60
    }
    
    
}

struct StartBreathView: View {
    @State private var isAnimated = false
    
    @State private var isVibrateOff: Bool = false
    @Binding var isShowingFirstView: Bool
    @State private var showAlert: Bool = false
    
    @Binding var breathTime: Int
    @StateObject var viewModel: BreathTimeViewModel
    
    @StateObject private var breathTimerManager = BreathTimeManager.shared
    
    private let firebase = FirebaseAnalyticsManager()
    
    init(isShowingFirstView: Binding<Bool>,breathTime: Binding<Int>) {
        _isShowingFirstView = isShowingFirstView
        _breathTime = breathTime
        _viewModel = StateObject(wrappedValue: BreathTimeViewModel(initialTime: breathTime.wrappedValue))
    }
    
    var body: some View {
        VStack {
            // 종료하기
            UIScreen.main.bounds.height < 700 ? Spacer().frame(height: 20) : Spacer().frame(height: 0)
            
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
                .padding(.bottom, 72)
            
            // 진동 버튼
            vibrateButton()
                .padding(.bottom, 26)
        }
        .onAppear {
//            print("start breathing timer")
            viewModel.startTimer()
        }
        .onDisappear {
            viewModel.stopTimer()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("완벽해요!"),
                message: Text("하루하루 더 나아지는 자신을 느껴보세요"),
                dismissButton: .default(Text("종료")) {
                    isShowingFirstView.toggle()
                    viewModel.stopTimer()
                    breathTimerManager.stopTimer()
                    firebase.logBreathingEndClick()
                }
            )
        }
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
        Text(timeString(from: viewModel.timerRemaining))
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
        ZStack {
            // Circle Animation
                Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [Color.clear, Color.white]),
                        center: .center,
                        startRadius: 50,
                        endRadius: 180
                        )
                    )
                    .shadow(radius: 10)
                    .shadow(color: .white, radius: 40)
                    .padding(.horizontal, 20)
                    .scaleEffect(isAnimated ? 1.0 : 0.4)
                    .animation(.easeIn(duration: 7).delay(2).repeatForever(),
                               value: isAnimated)
                
            
                    .onAppear(perform: {
                                isAnimated.toggle()
                            })
            // Image
            if UIScreen.main.bounds.height < 700 {
                Image("BreathintTurtleIntro")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 188)
            } else {
                Image("BreathintTurtleIntro")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 189, height: 221)
            }
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
                        .padding(.bottom, 13)
                    
                    vibrateTitle()
                }
            })
        }
    }

