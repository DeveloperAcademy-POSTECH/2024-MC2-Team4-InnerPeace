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
    
    //상황종료 Alert
    @State private var showingSOSEndAlert: Bool = false

    
    //햅틱, 사운드 등등 관리자
    @StateObject private var alertManager = AlertManager.shared
    
    //SOSMessageView를 띄울 시간 (30분 고정)
    @State var SOSTime: Int = 30
    
    @State private var timer: Timer? = nil
    @State private var count: Int = 1
    @State private var finishedText: String? = nil
    @State private var timeRemaining: String = ""
    @State private var futureData: Date = Date()
    @State private var progressTimeRemaining: String = "00:00"
    
    func updateTimeRemaining() {
        let now = Date()
        let remaining = Calendar.current.dateComponents([.minute, .second], from: now, to: futureData)
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        // 남은 시간을 계산
        timeRemaining = String(format: "%02d : %02d", minute, second)
        
        // 경과된 시간을 계산
        //        let totalTime = SOSTime
        let elapsedTime = Double(SOSTime) - Double(minute * 60 + second)
        
        // progressTimeRemaining: 누적된 시간 계산 (1초 추가)
        let startTime = futureData.addingTimeInterval(-Double(SOSTime))
        let elapsedInterval = now.timeIntervalSince(startTime) + 1
        let elapsedMinute = Int(elapsedInterval) / 60
        let elapsedSecond = Int(elapsedInterval) % 60
        progressTimeRemaining = String(format: "%02d : %02d", elapsedMinute, elapsedSecond)
        
        if minute == 0 && second == 0 {
            showingSOSEndAlert = true
            timer?.invalidate() // Timer 무효화
        }
    }
    
    func startTimer() {
        futureData = Calendar.current.date(byAdding: .minute, value: Int(SOSTime), to: Date()) ?? Date()
        futureData = Calendar.current.date(byAdding: .second, value: 1, to: futureData) ?? Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
            updateTimeRemaining()
        }
    }
    var body: some View {
        ZStack{
            Image("SOSButtonView")
            VStack(){
                
                Spacer().frame(maxHeight:50)
                
                Text("공황증상이 올 것 같다면\n지금 바로 PUSH")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(AppColors.green02)
                    .font(.title2)
                
                Spacer().frame(maxHeight:200)
                
                //SOS Button
                Button{
                    // Action 들어갈 공간(Full Screen ...)
                    showingWaitingTimeAlert = true
                    EmergencyLiveActivityManager.shared.startActivity(
                        title: Strings.LiveActivityView.title,
                        firstSubtitle: Strings.LiveActivityView.firstSubtitle,
                        secondSubtitle: Strings.LiveActivityView.secodSubtitle, isPresented: $isPresentedSOSMessageView, duration: waitingTime)
                } label: {
                    Image("SOSButton")
                }
                .alert("\(SOSTime)초 뒤 시작", isPresented: $showingWaitingTimeAlert) {
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
                    Text("\(SOSTime)초 뒤 자동으로 SOS 알람이 시작됩니다.")
                }
            }
        }
        .fullScreenCover(isPresented: $isPresentedSOSMessageView, content: {
            SOSMessageView(isPresentedSOSMessageView: $isPresentedSOSMessageView, SOSMessage: "")
        })
        .onAppear {
            // 물리동작 시작
            alertManager.startAll()
            
        }
        .onChange(of: isPresentedSOSMessageView) {
            if isPresentedSOSMessageView {
                startTimer()
            }
        }
    }
}

//struct SOSButtonView_Previews: PreviewProvider {
//    @State static var isPresentedSOSMessageView: Bool = false
//
//    static var previews: some View {
//        SOSButtonView(isPresentedSOSMessageView: $isPresentedSOSMessageView)
//    }
//}
