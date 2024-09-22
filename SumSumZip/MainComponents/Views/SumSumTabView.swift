//
//  TabView.swift
//  SumSumZip
//
//  Created by 원주연 on 7/13/24.
//

import SwiftUI

struct SumSumTabView: View {

    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    var body: some View {
        TabView {
            SOSButtonView(isPresentedSOSMessageView: isFirstLaunching)
                .tabItem {
                    Image(systemName: "staroflife.circle")
                    Text("SOS")
                }
            
            PracticeBreathingIntro(viewModel: PracticeBreathingIntroViewModel(useCase: PracticeBreathingIntroUseCase()))
                .tabItem {
                    Image(systemName: "person.wave.2.fill")
                    Text("호흡 연습하기")
                }
            
            SettingView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("사용자 설정")
                }
        }
        .onAppear {
            UITabBar.appearance().shadowImage = UIImage()
            UITabBar.appearance().backgroundImage = UIImage()
            UITabBar.appearance().isTranslucent = true
            UITabBar.appearance().backgroundColor = .white
        }
        .fullScreenCover(isPresented: $isFirstLaunching, content: {
            OnboardingView(isPresented: $isFirstLaunching)
        })
    }
}

struct SumSumTabView_Previews: PreviewProvider {
    static var previews: some View {
        SumSumTabView()
    }
}
