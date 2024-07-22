//
//  SettingView.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/13/24.
//

import SwiftUI



struct SettingView: View{

    // 유저 디폴트값 불러오기
    @State var message: String = MessageManager.shared.fetchMessage()
    @State var hospitalInfo: String = UserdefaultsManager.hospitalInfo
    @State var medicineInfo: String = UserdefaultsManager.medicineInfo
    @State private var numOfRelation = ContactsManager.shared.fetchContacts().last ?? "0"
    
    @State var bellToggled: Bool = true // 알람소리 On/Off
    @State var torchToggled: Bool = true // 알람소리 On/Off
    @State var vibrationToggled: Bool = true // 알람소리 On/Off
    
    @State var isPresentedSOSMessageView: Bool = false
    
    @ObservedObject var screenSize = ScreenSize.shared // 스크린 사이즈 측정을 위한 기능들 모음
    
    var body: some View{
        ZStack{
            let bgImage = Image("BG_SettingView")
            let imageSize = UIImage(named: "BG_SettingView")?.size ?? CGSize.zero
            
            // Geometry를 통해, 스크린 사이즈 측정
            GeometryReader {geometry in
                Color.clear
                    .onAppear{
                        screenSize.updateSize(size: geometry.size)
                        let bgUIImage = UIImage(named: "BG_SettingView")
                        screenSize.handleImage(bgUIImage!)
                        screenSize.updateTabBarHeight(sizeGeometry: geometry.size)
                    }
            }
            
            // scale 관련 값들 추출
            let screenWidth = screenSize.screenWidth
            let screenHeight = screenSize.screenHeight
            let scaleFactor = screenSize.scaleFactor
            let tabBarHeight = screenSize.tabBarHeight // 얘는 탭바만큼 미리보기 탭 올리는 용도
            
            // 큰 스케일에 맞춰서 resizable(화면이 남지않게 배경으로 꽉채운다)
            bgImage
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
                .ignoresSafeArea()
            
            // 배경화면 끝난 뒤 나머지 컴포넌트들 쌓기
            VStack{
                
                Text(" ") // 자유롭게 넣었다 빼도 되는 (맨 윗줄) 빈 공백
                HStack {
                    Text("사용자 설정")
                        .font(.system(size:32))
                        .bold()
                        .foregroundStyle(AppColors.green01.opacity(1))
                    Spacer()
                    Image("Img_SettingTitle")
                    
                }.padding(16)
                    .padding(.bottom, -16)
                
                // Scroll 영역 시작
                ScrollView{
                    VStack(alignment: .leading){
                        
                        SettingQuestionLabel(text: "SOS 알람")
                            .padding(.horizontal, 16)
                        
                        ZStack{
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(17)
                                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                            VStack(alignment:.center){
                                CustomToggleSet(text: "알람소리", isToggled: $bellToggled)
                                
                                CustomToggleSet(text: "플래시", isToggled: $torchToggled)
                                
                                CustomToggleSet(text: "진동", isToggled: $vibrationToggled)
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
                        // 여기 shadow는 컴포넌트 내부에 있습니다.
                    }
                    .onChange(of: hospitalInfo, initial: true) { // hospitalInfo 내용바뀌면 Userdefaults 값 업데이트
                        UserdefaultsManager.hospitalInfo = hospitalInfo
                    }
                    .onChange(of: medicineInfo, initial: true) { // medicineInfo 내용바뀌면 Userdefaults 값 업데이트
                        UserdefaultsManager.medicineInfo = medicineInfo
                    }
                }// Scroll 영역 끝
                
                Button(action: {
                    // 미리보기 뷰 띄우기
                    isPresentedSOSMessageView = true
                }, label: {
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [AppColors.blue01, AppColors.green07]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                            .frame(width: screenWidth-36, height: 60) // 더 깔쌈한 방법 없을까? -36 아쉽네...
                            .cornerRadius(68)
                        
                        Text("미리 보기")
                            .font(.system(size: 24))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color(.white))
                    }
                })
                
                // 미리보기 버튼 아래공간 만들기.
                Text(" ")
                    .frame(height: tabBarHeight + 16)
            }
            .frame(height: screenHeight)
            .sheet(isPresented: $isPresentedSOSMessageView, content: {PreviewView(isPresentedSOSMessageView: $isPresentedSOSMessageView, SOSMessage: message)})
        }
    }
}


struct SettingView_Preview: PreviewProvider{
    @State static var message = "긴급 메시지"
    @State static var hospitalInfo = "병원정보"
    @State static var medicineInfo = "자주가는 병원"
    
    static var previews: some View{
        SettingView()
    }
}


