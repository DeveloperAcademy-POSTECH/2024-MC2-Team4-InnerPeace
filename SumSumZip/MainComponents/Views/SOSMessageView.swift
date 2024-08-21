//
//  SOSMessageView.swift
//  SumSumZip
//
//  Created by 원주연 on 7/13/24.
//

import SwiftUI

struct SOSMessageView: View {
    //상황종료 Alert
    @State private var showingSOSEndAlert: Bool = false
    
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
    
    //SOSMessageView를 띄울 시간 (30분 고정)
    @State var SOSTime: Int = 30 //test 3분
    
    @State private var timer: Timer? = nil
    @State private var count: Int = 1
    @State private var finishedText: String? = nil
    @State private var futureData: Date = Date()
    @State private var progressTimeRemaining: String = "00:00"
    
    
    @State var isAfter20Min: Bool = false
    
    func updateTimeRemaining() {
        let now = Date()
        let remaining = Calendar.current.dateComponents([.minute, .second], from: now, to: futureData)
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        
        // 경과된 시간을 계산
        let totalTime = Double(SOSTime * 60)
        let elapsedTime = totalTime - Double(minute * 60 + second)
        
        // progressTimeRemaining: 누적된 시간 계산 (1초 추가)
        let startTime = futureData.addingTimeInterval(-totalTime)
        let elapsedInterval = now.timeIntervalSince(startTime) + 1
        let elapsedMinute = Int(elapsedInterval) / 60
        let elapsedSecond = Int(elapsedInterval) % 60
        progressTimeRemaining = String(format: "%02d : %02d", elapsedMinute, elapsedSecond)
        
        if minute == 0 && second == 0 {
            showingSOSEndAlert = true
            timer?.invalidate() // Timer 무효화
        }
        
        if elapsedTime >= (20 * 60) {
            isAfter20Min = true
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
                isAfter20Min ? Image("BG_SOSMessageView_red") : Image("BG_SOSMessageView_green")
                
                VStack{
                    UIScreen.main.bounds.height < 700 ? Spacer().frame(height: 10) : Spacer().frame(height: 70)
                    Text("공황 증상 발생")
                        .foregroundStyle(AppColors.white)
                        .fontWeight(.black)
                        .font(.largeTitle)
                        .padding(1)
                    Text("도움이 필요합니다")
                        .foregroundStyle(isAfter20Min ? AppColors.red03 : AppColors.paleGreen02)
                        .font(.title)
                    
                    Spacer().frame(height: 50)
                    
                    
                    // 환자의 SOS 메세지
                    RoundedRectangle(cornerRadius: 17)
                        .frame(width: 350, height: UIScreen.main.bounds.height < 700 ? 180 : 220)
                        .foregroundStyle(AppColors.black.opacity(0.35))
                        .overlay{
                            Text(SOSMessage)
                                .foregroundStyle(AppColors.white)
                                .fontWeight(.bold)
                                .font(.title2)
                        }
                    
                    Spacer().frame(height: 40)
                    
                    
                    // 경과 시간 (타이머)
                    Text("경과시간")
                        .foregroundStyle(isAfter20Min ? AppColors.red03 : AppColors.paleGreen02)
                    Text(progressTimeRemaining)
                        .foregroundStyle(isAfter20Min ? AppColors.red03 : AppColors.paleGreen02)
                        .font(.system(size: 45))
                        .fontWeight(.thin)
                    
                    UIScreen.main.bounds.height < 700 ? Spacer().frame(height: 30) : Spacer().frame(height: 60)
                    
                    
                    // 119 신고 메세지
                    Text("환자의 의식이 없다면 119에 신고해주세요")
                        .foregroundStyle(isAfter20Min ? AppColors.red03 : AppColors.paleGreen02)
    
                    Spacer().frame(height: 30)
                    
//                    Button(action: {isShownPatientInfo_Contact = true},
                    
                    // 환자 정보 확인 버튼
                    Button(action: {isShownPatientInfo_Contact = true},
                           label: {RoundedRectangle(cornerRadius: 17)
                            .frame(width: 350, height: 60)
                            .foregroundStyle(isAfter20Min ? AppColors.red03.opacity(0.25) :AppColors.cyan03.opacity(0.25))
                            .overlay{
                                Text("환자 정보 확인")
                                    .foregroundStyle(isAfter20Min ? AppColors.red03 : AppColors.cyan03)
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
                    showingSOSEndAlert = true
                }
                .foregroundStyle(isAfter20Min ? AppColors.red03 : AppColors.cyan02)
                .alert(isPresented: $showingSOSEndAlert){
                    Alert(title: Text("도와주셔서 감사합니다."), message: Text("당신은 영웅입니다."), primaryButton: .destructive(Text("상황종료"), action: {
                        isPresentedSOSMessageView = false
                        print("isPresented: \(isPresentedSOSMessageView)")
                        alertManager.stopAll()
                        EmergencyLiveActivityManager.shared.endAllActivities()
                    }), secondaryButton: .cancel(Text("취소")))
                }

            }//상황종료
            .fullScreenCover(isPresented: $isShownPatientInfo_Contact, content: {
                PatientInfo_ContactView(hospitalInfo: $hospitalInfo, medicineInfo: $medicineInfo, isShownPatientInfo_Contact: $isShownPatientInfo_Contact)

            }) // 환자정보 창 띄우기
        }
        .onAppear{
            let message = MessageManager.shared.fetchMessage()
            SOSMessage = message != "" ? message : ""
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .blur(radius: isShownPatientInfo_Contact ? 5.0 : 0)

        .onAppear {
            // 물리동작 시작
            alertManager.startAll()
            startTimer()
        }

    }
}

//
//#Preview {
//    SOSMessageView(isPresentedSOSMessageView: )
//}
