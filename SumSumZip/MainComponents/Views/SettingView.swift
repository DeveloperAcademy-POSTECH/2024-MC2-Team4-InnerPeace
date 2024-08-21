//
//  SettingView.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/13/24.
//

import SwiftUI

struct SettingView: View {
    
    // 유저 디폴트값 불러오기
    @State var message: String = UserdefaultsManager.savedMessage
    @State var hospitalInfo: String = UserdefaultsManager.hospitalInfo
    @State var medicineInfo: String = UserdefaultsManager.medicineInfo
    @State private var numOfRelation = ContactsManager.shared.fetchContacts().last ?? "0"
    
    @State private var bellToggled = UserdefaultsManager.bellToggledInfo
    @State private var torchToggled = UserdefaultsManager.torchToggledInfo
    @State private var vibrationToggled = UserdefaultsManager.vibrationToggleInfo
    
    @State var isPresentedSOSMessageView: Bool = false
    @ObservedObject var screenSize = ScreenSize.shared // 스크린 사이즈 측정용 기능 모음
    
    private let firebase = FirebaseAnalyticsManager()
    
    
    var body: some View {
        
        // scale 관련 값들 추출
        let screenWidth = screenSize.screenWidth
        let screenHeight = screenSize.screenHeight
        let scaleFactor = screenSize.scaleFactor
        let tabBarHeight = screenSize.tabBarHeight // 얘는 탭바만큼 미리보기 탭 올리는 용도
        
        ZStack {
            let bgImage = Image("BG_SettingView")
            let imageSize = UIImage(named: "BG_SettingView")?.size ?? CGSize.zero
            
            // 배경 이미지 설정
            bgImage
                .resizable()
                .frame(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
                .scaledToFit()
                .ignoresSafeArea()
            
            VStack {
                // Safe Area를 고려하여 헤더뷰가 너무 위로 가지 않도록 조정
                VStack(alignment: .trailing) {
                    Spacer()
                    
                    HStack(alignment: .center) { // alignment를 center로 설정
                        Text("사용자 설정")
                            .font(.system(size: 32))
                            .fontWeight(.bold)
                            .foregroundStyle(AppColors.green01)
                        
                            
                        
                        Spacer()
                        
                        Image("Img_SettingTitle")
                    }
                    .padding(.horizontal, 16) // 수평 패딩 추가
                    .padding(.top, 50)
                    Spacer()
                }
                .frame(height: 80)
                .safeAreaInset(edge: .top) {
                    
                    UIScreen.main.bounds.height < 700 ? Color.clear.frame(height: 100) : Color.clear.frame(height: 60)
                    
                }
                
                // Scroll 영역 시작
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        SettingQuestionLabel(text: "SOS 알람")
                            .padding(.horizontal, 16)
                            .padding(.top, 26)
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(17)
                                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                            VStack(alignment: .center) {
                                CustomToggleSet(text: "알람소리", isToggled: $bellToggled)
                                    .onChange(of: bellToggled) { _, newValue in
                                        UserdefaultsManager.bellToggledInfo = newValue
                                        firebase.logAlarmToggleChange(isOn: newValue)
                                    }
                                
                                CustomToggleSet(text: "플래시", isToggled: $torchToggled)
                                    .onChange(of: torchToggled) { _, newValue in
                                        UserdefaultsManager.torchToggledInfo = newValue
                                        firebase.logFlashToggleChange(isOn: newValue)
                                    }
                                
                                CustomToggleSet(text: "진동", isToggled: $vibrationToggled)
                                    .onChange(of: vibrationToggled) { _, newValue in
                                        UserdefaultsManager.vibrationToggleInfo = newValue
                                        firebase.logVibrationToggleChange(isOn: newValue)
                                    }
                            }
                            .padding(12)
                        }
                        .padding(.horizontal, 16)
                        Text(" ")
                        
                        SettingQuestionLabel(text: "긴급 메시지")
                            .padding(.horizontal, 16)
                        
                        SettingTextView(message: $message)
                            .padding(.horizontal, 16)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                            .onChange(of: message) { oldValue, newValue in
                                UserdefaultsManager.savedMessage = newValue
                            }
                        Text(" ")
                        
                        SettingQuestionLabel(text: "자주 가는 병원")
                            .padding(.horizontal, 16)
                        
                        SettingTextField(message: $hospitalInfo)
                            .padding(.horizontal, 16)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                        Text(" ")
                            .onChange(of: hospitalInfo) { oldValue, newValue in
                                UserdefaultsManager.hospitalInfo = newValue
                            }
                        
                        SettingQuestionLabel(text: "약 정보")
                            .padding(.horizontal, 16)
                        SettingTextField(message: $medicineInfo)
                            .padding(.horizontal, 16)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                        Text(" ")
                            .onChange(of: medicineInfo) { oldValue, newValue in
                                UserdefaultsManager.medicineInfo = newValue
                            }
                        
                        SettingQuestionLabel(text: "긴급 연락처")
                            .padding(.horizontal, 16)
                        PatientContactEditorView(numOfRelation: $numOfRelation)
                            .padding(.horizontal, 16)
                        
                        Spacer(minLength: tabBarHeight + 110)
                    }
                } // Scroll 영역 끝
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            UIApplication.shared.endEditing(true)
                        }
                )
                .frame(height: screenHeight - tabBarHeight)
                
                Spacer() // 미리보기 버튼을 아래로 밀어줌
                
            }
            .frame(height: screenHeight) // 뷰 크기 고정
            .safeAreaInset(edge: .bottom) {
                
                UIScreen.main.bounds.height < 700 ? Color.clear.frame(height: 60) : Color.clear.frame(height: 20)
                
            }
            .sheet(isPresented: $isPresentedSOSMessageView) {
                PreviewView(isPresentedSOSMessageView: $isPresentedSOSMessageView, SOSMessage: message)
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    // 미리보기 뷰 띄우기
                    isPresentedSOSMessageView = true
                    //         print(scaleFactor)
                    //         print(imageSize.width)
                }, label: {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [AppColors.blue01, AppColors.green07]), startPoint: .leading, endPoint: .trailing)
                            .frame(height: 60)
                            .cornerRadius(68)
                            .padding(.horizontal, 16)
                        
                        Text("미리 보기")
                            .font(.system(size: 24))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color(.white))
                    }
                })
                .padding(.bottom, tabBarHeight - 10) // Safe Area 고려한 하단 여백
            }
            .frame(height: screenHeight) // 버튼위치 고정
        }
        .frame(height: screenHeight)
        .onDisappear {
            firebase.logEmergencyMessageInput(isEmpty: message.isEmpty)
            firebase.logFrequentHospitalInput(isEmpty: hospitalInfo.isEmpty)
            firebase.logMedicineInfoInput(isEmpty: medicineInfo.isEmpty)
            firebase.logEmergencyContactInput(isEmpty: numOfRelation.isEmpty)
        }
    }
}

struct SettingView_Preview: PreviewProvider {
    @State static var message = "긴급 메시지"
    @State static var hospitalInfo = "병원정보"
    @State static var medicineInfo = "자주가는 병원"
    @ObservedObject static var screenSize = ScreenSize.shared // 스크린 사이즈 측정을 위한 기능들 모음
    
    static var previews: some View {
        ZStack{
            GeometryReadingViewModel()
            SettingView()
        }
    }
}
