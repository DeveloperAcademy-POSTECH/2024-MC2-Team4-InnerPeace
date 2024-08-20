//
//  PracticeBreathingIntro.swift
//  SumSumZip
//
//  Created by 신승아 on 7/13/24.
//

import SwiftUI
import FirebaseAnalytics

// MARK: - 호흡 연습하기 화면 Protocol

protocol PracticeBreathingIntroProtocol {
    var breathTime: Int { get }
    func setBreathTime(_ time: Int)
}

// MARK: - 호흡 연습하기 화면 UseCase

class PracticeBreathingIntroUseCase: PracticeBreathingIntroProtocol {
    private(set) var breathTime: Int = 1

    func setBreathTime(_ time: Int) {
        breathTime = time
    }
}

// MARK: - 호흡 연습하기 ViewModel

class PracticeBreathingIntroViewModel: ObservableObject {
    private let useCase: PracticeBreathingIntroUseCase

    @Published var breathTime: Int
    @Published var isShowingFirstView: Bool

    init(useCase: PracticeBreathingIntroUseCase, breathTime: Int = 1, isShowingFirstView: Bool = true) {
        self.useCase = useCase
        self.breathTime = breathTime
        self.isShowingFirstView = isShowingFirstView
    }

    func setBreathTime(_ time: Int) {
        useCase.setBreathTime(time)
        breathTime = useCase.breathTime
    }

    func toggleIsShowingFirstView() {
        isShowingFirstView.toggle()
    }
    
    func logButtonClickEvent() {
        Analytics.logEvent("breath_start_button_click", parameters: [
            "button_name": "Breath Start Button",
            "screen_name": "PracticeBreathingIntro"
        ])
    }
}

// MARK: - 호흡 연습하기 화면 View

struct PracticeBreathingIntro: View {
    @StateObject var viewModel: PracticeBreathingIntroViewModel

    init(viewModel: PracticeBreathingIntroViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Image("BG_SettingView")

            VStack {
                if viewModel.isShowingFirstView {
                    IntroView(viewModel: viewModel)
                } else {
                    StartBreathView(isShowingFirstView: $viewModel.isShowingFirstView, breathTime: $viewModel.breathTime)
                }
            }
        }
    }
}

struct IntroView: View {
    @ObservedObject var viewModel: PracticeBreathingIntroViewModel

    var body: some View {
        VStack {
            HStack {
                Text("호흡 연습하기")
                    .fontWeight(.bold)
                    .font(.system(size: 32))
                    .padding(.leading, 17)
                    .foregroundStyle(AppColors.green01)
                Spacer().frame(height: 55)
            }
            .safeAreaInset(edge: .top) {
                UIScreen.main.bounds.height < 700 ? Color.clear.frame(height: 120) : Color.clear.frame(height: 60)
            }

            HStack {
                Text("편안한 자세로 매일 조금씩 연습해보세요")
                    .font(.system(size: 17))
                    .padding(.leading, 17)
                    .foregroundStyle(AppColors.green01)
                Spacer()
            }
            
            let screenHeight = UIScreen.main.bounds.height

            Image("BreathintTurtleIntro")
                .resizable()
                .scaledToFit()
                .frame(width: screenHeight < 700 ? 150 : 189, height: screenHeight < 700 ? 150 : 221)
                .padding(.bottom, screenHeight < 700 ? 86 : 64)
                .padding(.top, screenHeight < 700 ? 64 : 86)

            TimerSelectionGroup(viewModel: viewModel)
                .padding(.bottom, 72)

            StartBreathButton(viewModel: viewModel)
                .safeAreaInset(edge: .bottom) {
                    
                    UIScreen.main.bounds.height < 700 ? Color.clear.frame(height: 150) : Color.clear.frame(height: 70)
                }
        }
    }
}

struct StartBreathButton: View {
    @ObservedObject var viewModel: PracticeBreathingIntroViewModel

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                viewModel.toggleIsShowingFirstView()
                viewModel.logButtonClickEvent()
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
                .cornerRadius(68)
                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
        }
    }
}

struct TimerSelectionGroup: View {
    @ObservedObject var viewModel: PracticeBreathingIntroViewModel

    let times: [Int] = [1, 3, 5, 8, 10]

    var body: some View {
        VStack {
            ZStack {
                middleLine()
                circles()
            }
        }
    }

    @ViewBuilder
    private func middleLine() -> some View {
        Rectangle()
            .fill(AppColors.green06)
            .frame(width: 250, height: 6)
            .offset(y: -21)
            .padding(.horizontal, 43)
    }

    @ViewBuilder
    private func circles() -> some View {
        HStack(spacing: 40) {
            ForEach(times, id: \.self) { time in
                TimeCircle(time: time, isSelected: time == viewModel.breathTime)
                    .onTapGesture {
                        withAnimation {
                            viewModel.setBreathTime(time)
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
    private func clickedCircle() -> some View {
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
    private func defaultCircle() -> some View {
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
