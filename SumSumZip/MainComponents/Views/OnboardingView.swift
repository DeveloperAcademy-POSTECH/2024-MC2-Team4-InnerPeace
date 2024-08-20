//  Assignee: Leo
//  OnboardingView.swift
//
//  Created by Leo Yoon on 5/21/24.
//
//
//@ 완료과제: 뷰짜봄, 캐릭터 애니메이션, SummaryView로 넘어가게 함
//@ 남은과제: 없음...? 디자인 수정 필요하면 의견 부탁드립니다.


// OnboardingView.swift



import SwiftUI

struct OnboardingView: View {
    @StateObject private var alertManager = AlertManager.shared
    
    @State private var appClicked: Bool = false
    @State private var fadeInOut = false
    @State private var opacity: Double = 0.0
    
    @Binding var isPresented: Bool
    
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    // 위젯용
    @State private var sosPresented: Bool = false
    @State private var widgetClicked: Bool = false
    
    var body: some View {
        ZStack {
            GeometryReadingViewModel() // 제품사이즈의 바닥깔기
            
            if appClicked {
                OnboardingTabView(isFirstLaunching: $isFirstLaunching)
            } else {
                Image("BG_SplashView")
                    .resizable()
                    .ignoresSafeArea()
                
                Image("Img_OnboardingView")
                    .onAppear() {
                        withAnimation(Animation.easeIn(duration: 0.8)) {
                            fadeInOut.toggle()
                        }
                    }
                    .opacity(fadeInOut ? 1 : 0)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                            appClicked = true
                        }
                    }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("NavigateToTargetView"))) { _ in
            sosPresented = true
        }
    }
}

struct OnboardingView_Preview: PreviewProvider {
    @State static var isPresented = false
    
    static var previews: some View {
        OnboardingView(isPresented: $isPresented)
    }
}
