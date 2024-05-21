// Assignee: Leo
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
    // SOSView로 전환될 때 사용
    @State private var isPresented = false
    // alert 뜰 때 사용
    @State private var alertShowing = false
    // 남은 시간
    @State private var timeRemaining = 30
    // 타이머 활성화 여부
    @State private var timerActive = false

    // 타이머
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .leading) {
                
                Image("BG_MainView").resizable() // ?? rㅌㅋesizable 풀고, fit 시킨다음에, Z스택문제 해결해야함.
                
                VStack(alignment: .leading){
                    Spacer()
                    
                    Text("숨숨집").font(.largeTitle)
                        .fontWeight(.bold)
                    Text("SOS 화면 설정").font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // #1: 1번버튼(긴급 메시지)
                    Button {
                        // Action 들어갈 공간(Full Screen ...)
                    } label: {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack{
                                Image(systemName: "light.beacon.max").foregroundStyle(Color("Button_1"))
                                Text("긴급 메세지").font(.system(size: 16)).foregroundStyle(Color("Button_1")).fontWeight(.bold)
                                Spacer()
                                Image(systemName:"chevron.forward").font(.system(size: 12))
                                    .foregroundStyle(Color("Button_1"))
                            }
                            Spacer()
                            Text("일시적인 공황장애 발생").font(.system(size: 17))
                                .foregroundStyle(Color("Button_2"))
                            Spacer()                                                // ?? Spacer를 min값 말고, 고정값으로는 못 쓰나?
                        }.padding(8)
                    }.frame(width:360 ,height: 88, alignment: .leading)
                        .background(.white) // @@ 흰색으로 바뀌어야함(배경 깐 뒤에 할게요오)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    
                    // #2: 2번버튼(긴급 연락처)
                    Button {
                        // Action 들어갈 공간(Full Screen ...)
                    } label: {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack{
                                Image(systemName: "phone.fill").foregroundStyle(Color("Button_1"))
                                Text("긴급 연락처").font(.system(size: 16)).foregroundStyle(Color("Button_1")).fontWeight(.bold)
                                Spacer()
                                Image(systemName:"chevron.forward").font(.system(size: 12))
                                    .foregroundStyle(Color("Button_1"))
                            }
                            Spacer()
                            HStack {
                                Text("2").font(.system(size: 30)).fontWeight(.heavy).fontDesign(.rounded)
                                    .foregroundStyle(Color("Button_2"))
                                Text("개의 연락처가 지정되어있습니다.").font(.system(size:13))
                                    .foregroundStyle(Color("Button_2sub"))
                                    .frame(height:25, alignment: .bottom)
                            }
                            Spacer()                                                // ?? Spacer를 min값 말고, 고정값으로는 못 쓰나?
                        }.padding(8)
                    }.frame(width:360 ,height: 88, alignment: .leading)
                        .background(.white) // @@ 흰색으로 바뀌어야함(배경 깐 뒤에 할게요오)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    
                    // #3: 3번버튼(환자 정보)
                    
                    NavigationLink {
                        PatientInfoSettingView()
                    } label: {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack{
                                Image(systemName: "stethoscope").foregroundStyle(Color("Button_1"))
                                Text("환자 정보").font(.system(size: 16)).foregroundStyle(Color("Button_1")).fontWeight(.bold)
                                Spacer()
                                Image(systemName:"chevron.forward").font(.system(size: 12))
                                    .foregroundStyle(Color("Button_1"))
                            }
                            Spacer()
                            HStack {
                                Text("윤혁진, 30세, 남, 공황장애, 포항성모병원").font(.system(size: 20)).fontWeight(.heavy).fontDesign(.rounded)
                                    .foregroundStyle(Color("Button_2"))
                                
                            }
                            Spacer()                                                // ?? Spacer를 min값 말고, 고정값으로는 못 쓰나?
                        }.padding(8)
                    }.frame(width:360 ,height: 88, alignment: .leading)
                        .background(.white) // @@ 흰색으로 바뀌어야함(배경 깐 뒤에 할게요오)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
            
                    
                    // #4: 4번버튼(호흡 유도 시간)
                    HStack {
                        Button {
                            // Action 들어갈 공간(Full Screen ...)
                        } label: {
                            VStack(alignment: .leading) {
                                Spacer()
                                HStack{
                                    Image(systemName: "exclamationmark.arrow.circlepath").foregroundStyle(Color("Button_1"))
                                    Text("호흡 유도 시간").font(.system(size: 16)).foregroundStyle(Color("Button_1")).fontWeight(.bold)
                                }
                                Spacer()
                                HStack {
                                    Text("2").font(.system(size: 30)).fontWeight(.heavy).fontDesign(.rounded)
                                        .foregroundStyle(Color("Button_2"))
                                    Text("분").font(.system(size:13))
                                        .foregroundStyle(Color("Button_2sub"))
                                        .frame(height:25, alignment: .bottom)
                                    Spacer()
                                    Image(systemName:"chevron.forward").font(.system(size: 12))
                                        .foregroundStyle(Color("Button_1"))
                                }
                                Spacer()                                                // ?? Spacer를 min값 말고, 고정값으로는 못 쓰나?
                            }.padding(8)
                        }.frame(width:173 ,height: 88, alignment: .leading)
                            .background(.white) // @@ 흰색으로 바뀌어야함(배경 깐 뒤에 할게요오)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                        
                        
                        // #5: 5번버튼(구조 타이밍 설정)
                        Button {
                            // Action 들어갈 공간(Full Screen ...)
                        } label: {
                            VStack(alignment: .leading) {
                                Spacer()
                                HStack{
                                    Image(systemName: "phone.fill").foregroundStyle(Color("Button_1"))
                                    Text("긴급 연락처").font(.system(size: 16)).foregroundStyle(Color("Button_1")).fontWeight(.bold)
                                }
                                Spacer()
                                HStack {
                                    Text("30").font(.system(size: 30)).fontWeight(.heavy).fontDesign(.rounded)
                                        .foregroundStyle(Color("Button_2"))
                                    Text("초").font(.system(size:13))
                                        .foregroundStyle(Color("Button_2sub"))
                                        .frame(height:25, alignment: .bottom)
                                    Spacer()
                                    Image(systemName:"chevron.forward").font(.system(size: 12))
                                        .foregroundStyle(Color("Button_1"))
                                }
                                Spacer()                                                // ?? Spacer를 min값 말고, 고정값으로는 못 쓰나?
                            }.padding(8)
                        }.frame(width:173 ,height: 88, alignment: .leading)
                            .background(.white) // @@ 흰색으로 바뀌어야함(배경 깐 뒤에 할게요오)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    }
                    Spacer()
                    
                    // ## SOS뷰 버튼
                    
                    HStack {
                        Spacer()
                        ZStack {
                            Button{
                                
                            } label:{
                                
                            }.frame(width:330, height:190).background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 90, style: .circular))
                            
                            Button{
                                // Action 들어갈 공간(Full Screen ...)
                                alertShowing = true
                                EmergencyLiveActivityManager.shared.startActivity(
                                    title: Strings.LiveActivityView.title,
                                    firstSubtitle: Strings.LiveActivityView.firstSubtitle,
                                    secondSubtitle: Strings.LiveActivityView.secodSubtitle)
                                startTimer()
                            } label: {
                                VStack{
                                    Spacer(minLength: 40)
                                    Text("도와주세요!").font(.system(size: 35)).fontWeight(.heavy)
                                        .foregroundStyle(.white)
                                    Spacer(minLength: 1)
                                    Text("공황 증상이 올 것 같다면\n지금 바로 PUSH!").font(.system(size: 14))
                                        .foregroundStyle(Color("Button_2sub"))
                                    Spacer(minLength: 40)
                                }.frame(width:310, height:167)
                                    .background(.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 90, style: .circular))
                            }
                            .alert("30초 뒤 시작", isPresented: $alertShowing) {
                                Button("취소", role: .cancel) {
                                    cancelTimer()
                                }
                                
                                Button("바로 시작", role: .destructive) {
                                    isPresented = true
                                    cancelTimer()
                                }
                            } message: {
                                Text("\(timeRemaining)초 뒤 자동으로 SOS 알람이 시작됩니다.")
                            }
                        }
                        .fullScreenCover(isPresented: $isPresented) {
                            SOSView()
                        }
                        .onReceive(timer) { _ in
                            if timerActive {
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                    print("타이머 잔여시간: \(timeRemaining)")
                                } else {
                                    timerActive = false
                                    isPresented = true
                                    cancelTimer()
                                    EmergencyLiveActivityManager.shared.endAllActivities()
                                }
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                    
                }
                .padding()
            }
        }
    }
}

/// Mark: 타이머 함수
extension SummaryView {

    func startTimer() {
        timeRemaining = 30
        timerActive = true
    }
    
    func cancelTimer() {
        timerActive = false
        alertShowing = false
        EmergencyLiveActivityManager.shared.endAllActivities()
    }
}

#Preview {
    SummaryView()
}


