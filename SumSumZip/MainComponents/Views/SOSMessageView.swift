//
//  SOSMessageView.swift
//  SumSumZip
//
//  Created by 원주연 on 7/13/24.
//

import SwiftUI

struct SOSMessageView: View {
    @State private var showingAlert: Bool = false
    
    //SOSMessageView 보여주는지 여부
    //    @State var isPresentedSOSMessageView: Bool = true
    @Binding var isPresentedSOSMessageView: Bool
    
    //환자 정보 & 연락처
    @State var medicineInfo = UserdefaultsManager.medicineInfo
    @State var hospitalInfo = UserdefaultsManager.hospitalInfo
    @State private var isShownPatientInfo_Contact: Bool = false
//    @State private var isShownContact: Bool = false
    
    //햅틱, 사운드 등등 관리자
    @StateObject private var alertManager = AlertManager.shared
    
    //환자의 SOSMessage
    @State var SOSMessage: String
    
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
        let totalTime = Double(SOSTime)
        let elapsedTime = totalTime - Double(minute * 60 + second)
        
        // progressTimeRemaining: 누적된 시간 계산 (1초 추가)
        let startTime = futureData.addingTimeInterval(-totalTime)
        let elapsedInterval = now.timeIntervalSince(startTime) + 1
        let elapsedMinute = Int(elapsedInterval) / 60
        let elapsedSecond = Int(elapsedInterval) % 60
        progressTimeRemaining = String(format: "%02d : %02d", elapsedMinute, elapsedSecond)
        
        if minute == 0 && second == 0 {
            showingAlert = true
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
        NavigationView{
            ZStack{
                Image("BG_SOSMessageView_green")
                VStack{
                    Spacer().frame(height: 70)
                    Text("공황 증상 발생")
                        .foregroundStyle(AppColors.white)
                        .fontWeight(.black)
                        .font(.largeTitle)
                        .padding(1)
                    Text("도움이 필요합니다")
                        .foregroundStyle(AppColors.paleGreen02)
                        .font(.title)
                    
                    Spacer().frame(height: 50)
                    
                    RoundedRectangle(cornerRadius: 17)
                        .frame(width: 350, height: 220)
                        .foregroundStyle(AppColors.black.opacity(0.35))
                        .overlay{
                            Text(SOSMessage)
                                .foregroundStyle(AppColors.white)
                                .fontWeight(.bold)
                                .font(.title2)
                        }
                    
                    Spacer().frame(height: 40)
                    
                    Text("경과시간")
                        .foregroundStyle(AppColors.paleGreen02)
                    Text(progressTimeRemaining)
                        .foregroundStyle(AppColors.paleGreen02)
                        .font(.system(size: 45))
                        .fontWeight(.thin)
                    
                    Spacer().frame(height: 60)
                    
                    Text("환자의 의식이 없다면 119에 신고해주세요")
                        .foregroundStyle(AppColors.paleGreen02)
                    
                    Spacer().frame(height: 30)
                    
                    Button(action: {isShownPatientInfo_Contact = true},
                           label: {RoundedRectangle(cornerRadius: 17)
                            .frame(width: 350, height: 60)
                            .foregroundStyle(AppColors.cyan03.opacity(0.25))
                            .overlay{
                                Text("환자 정보 확인")
                                    .foregroundStyle(AppColors.cyan03)
                                    .fontWeight(.bold)
                                    .font(.headline)
                            }
                    })
                }
            }
            .edgesIgnoringSafeArea(.all)
            .toolbar{
                Button("상황종료"){
                    print("상황종료")
                    AlertManager.shared.endButtonClicked = true
                    showingAlert = true
                }
                .foregroundStyle(AppColors.cyan02)
                .alert(isPresented: $showingAlert){
                    Alert(title: Text("도와주셔서 감사합니다."), message: Text("당신은 영웅입니다."),
                          dismissButton: .default(Text("상황종료"), action:{
                        isPresentedSOSMessageView = false
                        print("isPresented: \(isPresentedSOSMessageView)")
                        alertManager.stopAll()
                        EmergencyLiveActivityManager.shared.endAllActivities()
                    }))
                }
            }
            .fullScreenCover(isPresented: $isShownPatientInfo_Contact, content: {
                PatientInfo_ContactView(hospitalInfo: $hospitalInfo, medicineInfo: $medicineInfo, isShownPatientInfo_Contact: $isShownPatientInfo_Contact)
            }) // 환자정보 창 띄우기
        }
        .onAppear{
            let BreathsavedTime = BreathTimeDataManager.shared.fetchTime()
            SOSTime = BreathsavedTime != 0 ? BreathsavedTime : 30
            let message = MessageManager.shared.fetchMessage()
            SOSMessage = message != "" ? message : ""
            timeRemaining =  String(format: "%02d:00", SOSTime)
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .blur(radius: isShownPatientInfo_Contact ? 5.0 : 0)
    }
}

//
//#Preview {
//    SOSMessageView(isPresentedSOSMessageView: )
//}
