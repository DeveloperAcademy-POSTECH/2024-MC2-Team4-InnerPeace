//  Assignee: Leo
//  SummaryView.swift
//
//  Created by Leo Yoon on 5/17/24.
//

// @ 완료 과제: 1차로 뷰 짜봄
// @ 남은 과제
// 1. 다른 뷰로 연결 <-- 나중에
// 2. 배경 꽉차게 만들기 <-- 그라데이션 넣어서 해결가능(그라데이션 파먹기, 2개) --> 끝나면 바다에게 알려드리기
// 3. 데이터 끌고오는 로직 만들기
// 4. 디자인 디테일 수정 <-- 회의록 넣으면, 이상한거 알려주세요.
// 5. 자, Feature를 시작하자...(햅틱, ...)
// 6. Feature에는 종료버튼...
// 7. Color 피그마보고 맞추기
// 8. 버튼의 그림자 구현. (모르면 뷰마스터)
//
// @ 고민거리
// 1. 각각의 간격을 Spacer로 할 때, 고정값/상대값 등으로 조절하길 바람
// 2. 버튼들을 모듈화하고 싶음...(Class? Struct?) 코드가 지저분해 보여요...
// 3. 미리보기 버튼을 주세요...! // 바다 그려주세요.
//




import SwiftUI

struct SummaryView: View {
    
    // SOS View 전환용
    @Binding var isPresented: Bool // SOSView로 전환될 때 사용
    @State private var alertShowing = false // alert 뜰 때 사용

    // 타이머
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // 긴급 메시지 가져오기(완료)
    @State private var message = MessageManager.shared.fetchMessage()
    @State private var message_tmp = MessageManager.shared.fetchMessage()
    
    // 긴급 연락처 가져오기
//    @State private var pickedNumber = ContactSettingView.pickedNumber
    @State private var numOfRelation = ContactsManager.shared.fetchContacts().last ?? "0"
    
    // 환자정보 가져오기(완료)
    @State private var hospitalInfo: String = UserdefaultsManager.hospitalInfo
    @State private var medicineInfo: String = UserdefaultsManager.medicineInfo
    @State private var hospitalInfo_tmp: String = UserdefaultsManager.hospitalInfo
    @State private var medicineInfo_tmp: String = UserdefaultsManager.medicineInfo
    
    // 호흡유도시간 가져오기
//    @State private var selectedTime = BreathTimeDataManager.shared.fetchTime()
    @State private var selectedTime: Int = BreathTimeDataManager.shared.fetchTime() // != 0 ? BreathTimeDataManager.shared.fetchTime() : 30
    
    // 구조 타이밍 가져오기
    @State private var waitingTime: Int = SOSTimeDataManager.shared.fetchTime()
    
    // Preview 전환
    @State private var isShownPreview = false
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .leading) {
                
                Image("BG_SummaryView")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){
//                    Spacer().frame(height:20)
                    Spacer(minLength: 50)
                    
                    HStack{
                        Text("숨숨집")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(AppColors.darkGreen))
                        Spacer()
                        
                        Button{ // 미리보기 버튼...
                            //Action...
                            isShownPreview = true
                        } label: {
                            Text("미리보기")
                                .fontWeight(.bold)
                                .font(.system(size: 17))
                                .foregroundStyle(Color(AppColors.darkGreen))
                        }
                        .sheet(isPresented: $isShownPreview) {
                            PreviewView(SOSmessage: "", breathTime: 1)
                        }
                        .frame(width:88 ,height: 37, alignment: .center)
                            .background(Color(AppColors.white))
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
                        
                    }
                    
                    Text("SOS 화면 설정")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(AppColors.black))
                    Spacer(minLength: 40)
                    
                    // #1: 1번버튼(긴급 메시지)
                    NavigationLink {
                        MessageView(message: $message, message_tmp: $message_tmp)
                    } label: {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack{
                                Image(systemName: "light.beacon.max")
                                    .foregroundStyle(Color(AppColors.systemDarkGray))
                                Text("긴급 메세지")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(AppColors.systemDarkGray))
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName:"chevron.forward")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color(AppColors.systemGray))
                            }
                            Spacer()
                            Text(message)
                                .font(.system(size: 18))
                                .foregroundStyle(Color(AppColors.darkGreen))
                            Spacer()
                        }.padding(8)
                    }.frame(/*width:360 ,height: 88, */alignment: .leading)
                        .background(Color(AppColors.white))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
                    
                    // #2: 2번버튼(긴급 연락처)
                    NavigationLink {
                        ContactSettingView(numOfRelation: $numOfRelation)
                        // Action 들어갈 공간(Full Screen ...)
                    } label: {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack{
                                Image(systemName: "phone.fill")
                                    .foregroundStyle(Color(AppColors.systemDarkGray))
                                Text("긴급 연락처")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(AppColors.systemDarkGray))
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName:"chevron.forward")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color(AppColors.systemGray))
                            }
                            Spacer()
                            HStack {
                                Text(numOfRelation)
//                                Text("\(numOfRelation)")
                                    .font(.system(size: 30))
                                    .fontWeight(.heavy)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(Color(AppColors.darkGreen))
                                Text("개의 연락처가 지정되어있습니다.")
                                    .font(.system(size:13))
                                    .foregroundStyle(Color(AppColors.systemDarkGray))
                                    .frame(height:25, alignment: .bottom)
                            }
                            Spacer()
                        }.padding(8)
                    }.frame(/*width:360 ,height: 88,*/ alignment: .leading)
                        .background(Color(AppColors.white))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
                    
                    // #3: 3번버튼(환자 정보)
                    NavigationLink {
                        PatientInfoSettingView(hospitalInfo: $hospitalInfo, medicineInfo: $medicineInfo, hospitalInfo_tmp: $hospitalInfo_tmp, medicineInfo_tmp: $medicineInfo)
                    } label: {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack{
                                Image(systemName: "stethoscope")
                                    .foregroundStyle(Color(AppColors.systemDarkGray))
                                Text("환자 정보")
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color(AppColors.systemDarkGray))
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName:"chevron.forward")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color(AppColors.systemGray))
                            }
                            Spacer()
                            HStack {
                                Text("\(hospitalInfo=="" ? "병원정보" : hospitalInfo) & \(medicineInfo=="" ? "투약정보" : medicineInfo)")
                                    .font(.system(size: 18))
//                                    .fontWeight(.heavy)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(Color(AppColors.darkGreen))
                                
                            }
                            Spacer()
                        }.padding(8)
                    }.frame(/*width:360 ,height: 88,*/ alignment: .leading)
                        .background(Color(AppColors.white))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
            
                    
                    // #4: 4번버튼(호흡 유도 시간)
                    HStack {
                        NavigationLink {
                            BreathTimeSetting(selectedTime: $selectedTime)
                        } label: {
                            VStack(alignment: .leading) {
                                Spacer()
                                HStack{
                                    Image(systemName: "exclamationmark.arrow.circlepath")
                                        .foregroundStyle(Color(AppColors.systemDarkGray))
                                    Text("호흡 유도 시간")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color(AppColors.systemDarkGray))
                                        .fontWeight(.bold)
                                }
                                Spacer()
                                HStack {
                                    Text("\(selectedTime)")
                                        .font(.system(size: 30))
                                        .fontWeight(.heavy)
                                        .fontDesign(.rounded)
                                        .foregroundStyle(Color(AppColors.darkGreen))
                                    Text("분")
                                        .font(.system(size:13))
                                        .foregroundStyle(Color(AppColors.systemGray))
                                        .frame(height:25, alignment: .bottom)
                                    Spacer()
                                    Image(systemName:"chevron.forward")
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color(AppColors.systemGray))
                                }
                                Spacer()
                            }.padding(8)
                        }.frame(/*width:173 ,height: 88,*/ alignment: .leading)
                            .background(Color(AppColors.white))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
                        
                        Spacer()
                        
                        // #5: 5번버튼(구조 타이밍 설정)
                        NavigationLink {
                            SOSTimeSetting(waitingTime: $waitingTime)
                        } label: {
                            VStack(alignment: .leading) {
                                Spacer()
                                HStack{
                                    Image(systemName: "exclamationmark.arrow.circlepath")
                                        .foregroundStyle(Color(AppColors.systemDarkGray))
                                    Text("구조 타이밍 설정")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color(AppColors.systemDarkGray))
                                        .fontWeight(.bold)
                                }
                                Spacer()
                                HStack {
                                    Text("\(waitingTime)")
                                        .font(.system(size: 30))
                                        .fontWeight(.heavy)
                                        .fontDesign(.rounded)
                                        .foregroundStyle(Color(AppColors.darkGreen))
                                    Text("초").font(.system(size:13))
                                        .foregroundStyle(Color(AppColors.systemGray))
                                        .frame(height:25, alignment: .bottom)
                                    Spacer()
                                    Image(systemName:"chevron.forward")
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color(AppColors.systemGray))
                                }
                                Spacer()
                            }.padding(8)
                        }.frame(/*width:173 ,height: 88,*/ alignment: .leading)
                            .background(Color(AppColors.white))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
                    }
                    Spacer(minLength: 40)
                    
                    // ## SOS뷰 버튼
                    HStack {
                        Spacer()
                        ZStack {
                            Button{
                                
                            } label:{
                                
                            }.frame(width:330, height:190)
                                .background(Color(AppColors.white))
                                .clipShape(RoundedRectangle(cornerRadius: 90, style: .circular))
                                .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 2)
                            
                            Button{
                                // Action 들어갈 공간(Full Screen ...)
                                alertShowing = true
                                EmergencyLiveActivityManager.shared.startActivity(
                                    title: Strings.LiveActivityView.title,
                                    firstSubtitle: Strings.LiveActivityView.firstSubtitle,
                                    secondSubtitle: Strings.LiveActivityView.secodSubtitle, isPresented: $isPresented, duration: waitingTime)
                            } label: {
                                
                                VStack{
                                    Spacer(minLength: 40)
                                    
                                    Text("도와주세요!")
                                        .font(.system(size: 35))
                                        .fontWeight(.heavy)
                                        .foregroundStyle(Color(AppColors.white))
                                    Spacer(minLength: 1)
                                    
                                    Text("공황 증상이 올 것 같다면\n지금 바로 PUSH!")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color(AppColors.systemGray))
                                    Spacer(minLength: 40)
                                    
                                }.frame(width:310, height:167)
                                    .background(Color(AppColors.systemBlack))
                                    .clipShape(RoundedRectangle(cornerRadius: 90, style: .circular))
                                
                            }
                            .alert("\(waitingTime)초 뒤 시작", isPresented: $alertShowing) {
                                Button("취소", role: .cancel) {
                                    EmergencyLiveActivityManager.shared.endAllActivities()
                                }
                                
                                Button("바로 시작", role: .destructive) {
                                    EmergencyLiveActivityManager.shared.endAllActivities()
                                    isPresented = true
                                }
                            } message: {
                                Text("\(waitingTime)초 뒤 자동으로 SOS 알람이 시작됩니다.")
                            }
                        }
                        .fullScreenCover(isPresented: $isPresented) {
                            SOSView(SOSmessage: "", breathTime: 1, isPresented: $isPresented)
                        }
                        Spacer()
                    }
//                    Spacer()
                }
                .padding()
            }
        }.onAppear{message = MessageManager.shared.fetchMessage()}
    }
}

struct SummaryView_Previews: PreviewProvider {
    @State static var isPresented: Bool = false

    static var previews: some View {
        SummaryView(isPresented: $isPresented)
    }
}

