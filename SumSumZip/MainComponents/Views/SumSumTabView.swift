//
//  TabView.swift
//  SumSumZip
//
//  Created by 원주연 on 7/13/24.
//

import SwiftUI

struct SumSumTabView: View {
    @State var message : String = ""// 긴급메시지 저장 전에
    @State var hospitalInfo : String = ""// 자주가는 병원
    @State var medicineInfo : String = ""
    
    var body: some View {
        
        TabView {
            SOSButtonView()
                .tabItem {
                    Image(systemName: "staroflife.circle")
                    Text("SOS")
                }
            PracticeBreathingIntro()
                .tabItem {
                    Image(systemName: "person.wave.2.fill")
                    Text("호흡 연습하기")
                }
            SettingView(message: $message, hospitalInfo: $hospitalInfo, medicineInfo: $medicineInfo)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("사용자 설명")
                }
        }
    }
}

//#Preview {
//    TabView()
//}
