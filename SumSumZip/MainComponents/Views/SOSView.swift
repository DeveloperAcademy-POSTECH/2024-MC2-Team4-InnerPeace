//
//  SOSView.swift
//  SumSumZip
//
//  Created by 원주연 on 5/20/24.
//

// BADA 수정 on 5/24/24 -> gif face 추가 하면서 패딩 값들 수정 필요한지 확인...


import SwiftUI

struct SOSView: View {
    
    @StateObject private var alertManager = AlertManager.shared

    @State var SOSmessage: String
    @State var breathTime: Int
    @State var medicineInfo = UserdefaultsManager.medicineInfo
    @State var hospitalInfo = UserdefaultsManager.hospitalInfo
    @State private var isShownPatientInfo: Bool = false
    @State private var isShownBreathing: Bool = false
    @State private var isShownContact: Bool = false
    @State private var isBreathing: Bool = false
    @State private var showingAlert: Bool = false
    
    @Binding var isPresented: Bool
    
    @State private var timer: Timer? = nil
    @State private var count: Int = 1
    @State private var finishedText: String? = nil
    @State private var timeRemaining: String = ""
    @State private var futureData: Date = Date()
    @State private var progressValue: Double = 1.0
    @State private var progressTimeRemaining: String = "00:00"
    
    func updateTimeRemaining() {
        let now = Date()
        let remaining = Calendar.current.dateComponents([.minute, .second], from: now, to: futureData)
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        // 남은 시간을 계산
        timeRemaining = String(format: "%02d:%02d", minute, second)
        
        // 경과된 시간을 계산
        let totalTime = Double(breathTime * 60)
        let elapsedTime = totalTime - Double(minute * 60 + second)
        progressValue = elapsedTime / totalTime
        
        // progressTimeRemaining: 누적된 시간 계산 (1초 추가)
        let startTime = futureData.addingTimeInterval(-totalTime)
        let elapsedInterval = now.timeIntervalSince(startTime) + 1
        let elapsedMinute = Int(elapsedInterval) / 60
        let elapsedSecond = Int(elapsedInterval) % 60
        progressTimeRemaining = String(format: "%02d:%02d", elapsedMinute, elapsedSecond)
        
        if minute == 0 && second == 0 {
            showingAlert = true
            timer?.invalidate() // Timer 무효화
        }
    }

    func startTimer() {
        futureData = Calendar.current.date(byAdding: .minute, value: breathTime, to: Date()) ?? Date()
        futureData = Calendar.current.date(byAdding: .second, value: 1, to: futureData) ?? Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
            updateTimeRemaining()
        }
    }
    
    var workoutDateRange: ClosedRange<Date> {
        Date()...Date().addingTimeInterval(Double(breathTime)*60)
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.black, AppColors.lightSage, AppColors.lightGreen]),
                               startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer().frame(height: 40)
                    Text(isBreathing ? "호흡을 도와주세요" : "도움이 필요합니다")
                        .foregroundStyle(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding(.bottom, 7)
                    Text(SOSmessage)
                        .foregroundStyle(Color.white)
                        .font(.title2)
                    Spacer().frame(height: 100)
                    
                    if isShownBreathing {
                        CircleView(isBreathing: $isBreathing)
                            .onAppear(perform: {
                                isBreathing.toggle()
                            })
                    } else {
                        CapsuleView(isShownBreathing: $isShownBreathing, breathTime: $breathTime, progressValue: $progressValue)
                    }
                    Spacer().frame(height: 40)
                    Text(timeRemaining)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        
                    Spacer().frame(height: 30)
                    Text("만약 제가 의식이 없다면\n긴급연락과 119에 신고해주세요")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    Spacer().frame(height: 20)
                    ZStack(alignment: .bottom) {
                        ProgressView(value: progressValue)
                            .padding()
                            .progressViewStyle(LinearProgressViewStyle(tint: .white))
                        Text(progressTimeRemaining)
                            .foregroundStyle(Color.gray)
                            .font(.title3)
                            .offset(x: -153, y: -25) // x와 y 값은 디자인에 맞게 조정하세요.
                    }
                }
            }
            .toolbar{
                Button("상황종료"){
                    print("상황종료")
                    showingAlert = true
                }
                .foregroundStyle(AppColors.lightSage)
                .alert(isPresented: $showingAlert){
                    Alert(title: Text("도와주셔서 감사합니다."), message: Text("당신은 영웅입니다."),
                          dismissButton: .default(Text("상황종료"), action:{
                                    isPresented = false
                                    print("isPresented: \(isPresented)")
                                    alertManager.stopAll()
                                }))
                }
            }
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("환자 정보") {
                        print("환자 정보")
                        isShownPatientInfo = true
                    }
                    .foregroundStyle(Color.gray)
                    .font(.title3)
                    .fontWeight(.bold)
                    
                    Button("긴급 연락") {
                        print("긴급 연락")
                        isShownContact = true
                    }
                    .foregroundStyle(Color.red)
                    .font(.title3)
                    .fontWeight(.bold)
                }
            }
            .fullScreenCover(isPresented: $isShownContact, content: {
                ContactView(isShownContact: $isShownContact)
            })
            .fullScreenCover(isPresented: $isShownPatientInfo, content: {
                PatientInfoView(hospitalInfo: $hospitalInfo, medicineInfo: $medicineInfo, isShownPatientInfo: $isShownPatientInfo)
            })
            .onAppear {
                // 물리동작 시작
                alertManager.startAll()
                
            }
        }
        .onAppear{
            let BreathsavedTime = BreathTimeDataManager.shared.fetchTime()
            breathTime = BreathsavedTime != 0 ? BreathsavedTime : 30
            let message = MessageManager.shared.fetchMessage()
            SOSmessage = message != "" ? message : ""
            timeRemaining =  String(format: "%02d:00", breathTime)
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onChange(of: isShownBreathing) {
            if isShownBreathing {
                startTimer()
            }
        }
        .blur(radius: isShownContact ? 5.0 : 0)
        .blur(radius: isShownPatientInfo ? 5.0 : 0)
    }
}

struct CapsuleView: View {
    
    @ObservedObject private var alertManager = AlertManager.shared
    
    @Binding var isShownBreathing: Bool
    @Binding var breathTime: Int
    @Binding var progressValue: Double
    
    var body: some View {
        ZStack{
            Capsule()
                .foregroundStyle(Gradient(colors: [AppColors.lightSage, Color.white]))
                .shadow(radius: 10)
                .shadow(color: .white, radius: 40)
                .padding(.horizontal, 20)
            
            Button(action: {
                // 모든 물리 동작 멈춤
                alertManager.stopAll()
                // 호흡전용 물리동작 실행
                alertManager.changeToBreath()
                isShownBreathing = true
                progressValue = 0.0
            }, label: {
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(150)
                    .overlay{
                        VStack{
                            Text("\(breathTime)분")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.gray)
                                .font(.title)
                            Spacer().frame(height:10)
                            Text("호흡 유도 시작")
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.white)
                                .font(.largeTitle)
                            Spacer().frame(height:10)
                            Text("버튼을 눌러 정상 호흡을 도와주세요")
                                .foregroundStyle(Color.white)
                            Spacer().frame(height:15)
                        }
                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal, 45)
            })
        }
    }
}

struct CircleView: View {
    @Binding var isBreathing: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(Gradient(colors: [AppColors.lightSage, Color.white]))
                .shadow(radius: 10)
                .shadow(color: .white, radius: 40)
                .padding(.horizontal, 20)
                .scaleEffect(isBreathing ? 0.7 : 1.2)
                .animation(.easeOut(duration: 4).delay(1).repeatForever(), value: isBreathing)
            
            Circle()
                .frame(width: 200, height: 200)
            GifImageViewer("BreathingFace_10s")
                .frame(width: 200, height: 200)
                .cornerRadius(100)
            VStack{
                Text(isBreathing ? "내쉬고" : "들이마시고")
                    .foregroundStyle(Color.primary)
                    .font(.title)
                    .fontWeight(.bold)
                    .animation(.easeOut(duration: 4).delay(1).repeatForever(), value: isBreathing)
                Spacer(minLength: 240)
            }
        }
    }
}

//#Preview{
//    SOSView()
//}
//
