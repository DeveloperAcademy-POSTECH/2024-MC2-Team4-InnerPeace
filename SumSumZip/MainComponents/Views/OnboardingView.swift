//  Assignee: Leo
//  OnboardingView.swift
//
//  Created by Leo Yoon on 5/21/24.
//
//
//@ 완료과제: 뷰짜봄, 캐릭터 애니메이션, SummaryView로 넘어가게 함
//@ 남은과제: 없음...? 디자인 수정 필요하면 의견 부탁드립니다.


import SwiftUI
//import Combine
//
//class SharedState: ObservableObject {
//    static let shared = SharedState()
//    private init() {}
//    
//    @Published var isSummaryViewPresented: Bool = false
//}


struct OnboardingView: View {
    
    @StateObject private var alertManager = AlertManager.shared
    
    @State private var appClicked: Bool = false
    @State private var fadeInOut = false
    @State private var opacity: Double = 0.0
    
    @Binding var isPresented: Bool
    
    // 위젯용
    @State private var sosPresented: Bool = false
    @State private var widgetClicked: Bool = false
//    @ObservedObject var sharedState = SharedState.shared
    
    var body: some View {
        ZStack {
            switch (appClicked) {
//            case (true, _):
//                
//                if sharedState.isSummaryViewPresented {
//                    // 이미 화면이 뜬 상태면 그대로 유지
//                    SummaryView(isPresented: $sosPresented)
//                } else {
//                    // 아니면 새로 띄우기
//                    SummaryView(isPresented: $sosPresented)
//                        .onAppear {
//                            alertManager.stopAll()
//                            sosPresented = true
//                            sharedState.isSummaryViewPresented = true
//                        }
//                }
            case (true):
                SummaryView(isPresented: $isPresented)
                
            case (false):
                Image("BG_OnboardingView")
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
            
//            if sharedState.isSummaryViewPresented {
//                // SOS 화면이 이미 켜져 있으면 switch문을 거치지 않고 처리
//                sosPresented = true
//                widgetClicked = false
//            } else {
//                // SOS 화면이 켜져 있지 않으면 switch문을 거쳐서 화면 띄우기
//                widgetClicked = true
//                sosPresented = true
//                sharedState.isSummaryViewPresented = true
//            }
            
            
//            widgetClicked = true
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
