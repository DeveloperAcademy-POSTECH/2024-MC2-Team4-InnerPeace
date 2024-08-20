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
    private let firebase = FirebaseAnalyticsManager()
    
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
        firebase.logBreathingTimeSelection(time: "\(breathTime)")
    }
    
    func toggleIsShowingFirstView() {
        isShowingFirstView.toggle()
    }
    
    func logButtonClickEvent() {
        firebase.logBreathingStartClick()
    }
}

// MARK: - 호흡 연습하기 화면 View

struct PracticeBreathingIntro: View {
    @StateObject var viewModel: PracticeBreathingIntroViewModel
    @ObservedObject var screenSize = ScreenSize.shared // 스크린 사이즈 측정용 기능 모음
    
    init(viewModel: PracticeBreathingIntroViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        // scale 관련 값들 추출
//        let screenWidth = screenSize.screenWidth
        let screenHeight = screenSize.screenHeight
        let scaleFactor = screenSize.scaleFactor
//        let tabBarHeight = screenSize.tabBarHeight // 얘는 탭바만큼 미리보기 탭 올리는 용도
        
        ZStack {
            let bgImage = Image("BG_SettingView")
            let imageSize = UIImage(named: "BG_SettingView")?.size ?? CGSize.zero
            
            // 배경 이미지 설정
            bgImage
                .resizable()
                .frame(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
                .scaledToFit()
                .ignoresSafeArea()
            
            VStack {
                if viewModel.isShowingFirstView {
                    IntroView(viewModel: viewModel)
                        .frame(height: screenHeight)
                } else {
                    StartBreathView(isShowingFirstView: $viewModel.isShowingFirstView, breathTime: $viewModel.breathTime)
                        .frame(height: screenHeight)
                }
            }
        }
    }
}

struct IntroView: View {
    @ObservedObject var viewModel: PracticeBreathingIntroViewModel
    @ObservedObject var screenSize = ScreenSize.shared // 스크린 사이즈 측정용 기능 모음
    
    var body: some View {
        
        // scale 관련 값들 추출
        let screenWidth = screenSize.screenWidth
        let screenHeight = screenSize.screenHeight
        let scaleFactor = screenSize.scaleFactor
        //         let tabBarHeight = screenSize.tabBarHeight  얘는 탭바만큼 미리보기 탭 올리는 용도
        
        VStack {
            VStack {
                HStack {
                    Text("호흡 연습하기")
                        .fontWeight(.bold)
                        .font(.system(size: 32))
                        .padding(.leading, 17)
                        .foregroundStyle(AppColors.green01)
                    Spacer().frame(height: 55)
                }
                
                HStack {
                    Text("편안한 자세로 매일 조금씩 연습해보세요")
                        .font(.system(size: 17))
                        .padding(.leading, 17)
                        .foregroundStyle(AppColors.green01)
                    Spacer()
                }
            }
            .frame(height: 80)
            .safeAreaInset(edge: .top) {
                UIScreen.main.bounds.height < 700 ? Color.clear.frame(height: 100) : Color.clear.frame(height: 60)
            }
            
            Spacer()
            
            // Turtle 그림 사이즈
            let turtleImage = Image("BreathintTurtleIntro")
            let imageTurtleIntro = UIImage(named: "BreathintTurtleIntro")!
            let imageSize = imageTurtleIntro.size
            let widthScaleFactor = screenWidth / imageSize.width
            let heightScaleFactor = screenHeight / imageSize.height
            let scaleFactor = max(widthScaleFactor, heightScaleFactor)
            
            turtleImage
                .resizable()
                .scaledToFit()
                .padding(.bottom, screenHeight < 700 ? 86 : 64)
                .padding(.top, screenHeight < 700 ? 64 : 86)
            
            Spacer()
            
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
    @ObservedObject var screenSize = ScreenSize.shared // 스크린 사이즈 측정을 위한 기능들 모음
    
    var body: some View {
        
        let screenWidth = screenSize.screenWidth
        
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
                .frame(width: screenWidth - 32, height: 60) // 좌우패딩 16씩
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

struct PracticeBreathingIntro_Preview: PreviewProvider{
    @ObservedObject static var screenSize = ScreenSize.shared // 스크린 사이즈 측정을 위한 기능들 모음
    
    static var previews: some View {
        ZStack{
            GeometryReadingViewModel()
            PracticeBreathingIntro(viewModel: PracticeBreathingIntroViewModel(useCase: PracticeBreathingIntroUseCase()))
        }
    }
}

