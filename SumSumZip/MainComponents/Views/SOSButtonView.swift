//
//  SOSButtonView.swift
//  SumSumZip
//
//  Created by 원주연 on 7/13/24.
//

import SwiftUI

struct SOSButtonView: View {
    
    //SOSMessageView로 전환
//    @Binding var isPresentedSOSMessageView: Bool
    @State var isPresentedSOSMessageView = false
    
    // 구조 타이밍 가져오기 (30초 고정)
    @State private var waitingTime: Int = 30
    // 30초 뒤 시작합니다 Alert
    @State private var showingWaitingTimeAlert = false
    
    let firebase = FirebaseAnalyticsManager()
    

    var body: some View {
        ZStack{
            Image("SOSButtonView")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack(){
                
                Spacer().frame(maxHeight:50)
                
                Text("공황증상이 올 것 같다면\n지금 바로 눌러주세요")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(AppColors.green02)
                    .font(.title2)
                
                Spacer().frame(maxHeight:200)
                
                //SOS Button
                Button{
                    showingWaitingTimeAlert = true
                    EmergencyLiveActivityManager.shared.startActivity(
                        title: Strings.LiveActivityView.title,
                        firstSubtitle: Strings.LiveActivityView.firstSubtitle,
                        secondSubtitle: Strings.LiveActivityView.secodSubtitle, isPresented: $isPresentedSOSMessageView, duration: waitingTime)
                    
                    // Firebase - SOS 버튼 클릭
                    firebase.logSOSButtonClick()
                    
                } label: {
                    Image("SOSButton")
                }
                .alert("\(waitingTime)초 뒤 시작", isPresented: $showingWaitingTimeAlert) {
                    Button("취소", role: .cancel) {
                        EmergencyLiveActivityManager.shared.endAllActivities()
                    }
                    
                    Button("바로 시작", role: .destructive) {
//                                    EmergencyLiveActivityManager.shared.endAllActivities()
                        // 타이머 멈추자
                        EmergencyLiveActivityManager.shared.endTimer()
                        isPresentedSOSMessageView = true
                    }
                } message: {
                    Text("\(waitingTime)초 뒤 자동으로 SOS 알람이 시작됩니다.")
                }
            }
        }
        .fullScreenCover(isPresented: $isPresentedSOSMessageView, content: {
            SOSMessageView(isPresentedSOSMessageView: $isPresentedSOSMessageView, SOSMessage: "")
        })
    }
}

//struct SOSButtonView_Previews: PreviewProvider {
//    @State static var isPresentedSOSMessageView: Bool = false
//
//    static var previews: some View {
//        SOSButtonView(isPresentedSOSMessageView: $isPresentedSOSMessageView)
//    }
//}
