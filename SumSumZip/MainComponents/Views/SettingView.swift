//
//  SettingView.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/13/24.
//

import SwiftUI

struct SettingView: View {
    
    // 유저 디폴트값 불러오기
    @State var message: String = MessageManager.shared.fetchMessage()
    @State var hospitalInfo: String = UserdefaultsManager.hospitalInfo
    @State var medicineInfo: String = UserdefaultsManager.medicineInfo
    @State private var numOfRelation = ContactsManager.shared.fetchContacts().last ?? "0"
    
    @State private var bellToggled = UserdefaultsManager.bellToggledInfo
    @State private var torchToggled = UserdefaultsManager.torchToggledInfo
    @State private var vibrationToggled = UserdefaultsManager.vibrationToggleInfo
    
    @State var isPresentedSOSMessageView: Bool = false
    
    var body: some View {
        ZStack {
            
            // 배경 이미지 설정
            Image("BG_SettingView")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                // Safe Area를 고려하여 헤더뷰가 너무 위로 가지 않도록 조정
                HStack(alignment: .center) { // alignment를 center로 설정
                    Text("사용자 설정")
                        .font(.system(size: 32))
                        .bold()
                        .foregroundStyle(AppColors.green01.opacity(1))
                    
                    Spacer()
                    
                    Image("Img_SettingTitle")
                }
                .padding(.horizontal, 16) // 수평 패딩 추가
                .safeAreaInset(edge: .top) {
                    
                    UIScreen.main.bounds.height < 700 ? Color.clear.frame(height: 100) : Color.clear.frame(height: 60)
                    
                }
                
                // Scroll 영역 시작
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        SettingQuestionLabel(text: "SOS 알람")
                            .padding(.horizontal, 16)
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(17)
                                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                            VStack(alignment: .center) {
                                CustomToggleSet(text: "알람소리", isToggled: $bellToggled)
                                    .onChange(of: bellToggled) { _, newValue in
                                        UserdefaultsManager.bellToggledInfo = newValue
                                    }
                                
                                CustomToggleSet(text: "플래시", isToggled: $torchToggled)
                                    .onChange(of: torchToggled) { _, newValue in
                                        UserdefaultsManager.torchToggledInfo = newValue
                                    }
                                
                                CustomToggleSet(text: "진동", isToggled: $vibrationToggled)
                                    .onChange(of: vibrationToggled) { _, newValue in
                                        UserdefaultsManager.vibrationToggleInfo = newValue
                                    }
                            }
                            .padding(12)
                        }
                        .padding(.horizontal, 16)
                        Text(" ")
                        
                        SettingQuestionLabel(text: "긴급 메시지")
                            .padding(.horizontal, 16)
                        
                        CustomTextEditorView(message: $message)
                            .padding(.horizontal, 16)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                        Text(" ")
                        
                        SettingQuestionLabel(text: "자주 가는 병원")
                            .padding(.horizontal, 16)
                        
                        CustomTextEditorSimpleView(message: $hospitalInfo)
                            .padding(.horizontal, 16)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                        Text(" ")
                        
                        SettingQuestionLabel(text: "약 정보")
                            .padding(.horizontal, 16)
                        CustomTextEditorSimpleView(message: $medicineInfo)
                            .padding(.horizontal, 16)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                        Text(" ")
                        
                        SettingQuestionLabel(text: "긴급 연락처")
                            .padding(.horizontal, 16)
                        PatientContactEditorView(numOfRelation: $numOfRelation)
                            .padding(.horizontal, 16)
                    }
                    .onChange(of: hospitalInfo, initial: true) { // hospitalInfo 내용바뀌면 Userdefaults 값 업데이트
                        UserdefaultsManager.hospitalInfo = hospitalInfo
                    }
                    .onChange(of: medicineInfo, initial: true) { // medicineInfo 내용바뀌면 Userdefaults 값 업데이트
                        UserdefaultsManager.medicineInfo = medicineInfo
                    }
                } // Scroll 영역 끝
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            UIApplication.shared.endEditing(true)
                        }
                )
                
                Spacer() // 미리보기 버튼을 아래로 밀어줌
                
                Button(action: {
                    // 미리보기 뷰 띄우기
                    isPresentedSOSMessageView = true
                }) {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [AppColors.blue01, AppColors.green07]), startPoint: .leading, endPoint: .trailing)
                            .frame(height: 60)
                            .cornerRadius(68)
                            .padding(.horizontal, 50)
                        
                        Text("미리 보기")
                            .font(.system(size: 24))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color(.white))
                    }
                }
                .padding(.bottom, 20) // Safe Area 고려한 하단 여백
                .padding(.bottom, 30) // 추가 여백을 더 줘서 탭바 위에 위치하도록 설정
            }
            .safeAreaInset(edge: .bottom) {
                
                UIScreen.main.bounds.height < 700 ? Color.clear.frame(height: 60) : Color.clear.frame(height: 20)
                
            }
            .sheet(isPresented: $isPresentedSOSMessageView) {
                PreviewView(isPresentedSOSMessageView: $isPresentedSOSMessageView, SOSMessage: message)
            }
        }
    }
}

struct SettingView_Preview: PreviewProvider {
    @State static var message = "긴급 메시지"
    @State static var hospitalInfo = "병원정보"
    @State static var medicineInfo = "자주가는 병원"
    
    static var previews: some View {
        SettingView()
    }
}
