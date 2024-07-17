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

    
    var body: some View{
        ZStack{
            
            // 배경컬러 사이즈 조절: 좌우, 상하중에 확대율 더 큰쪽에 맞춰서 resizable을 진행.(빈틈없이 가득채우기)
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                let image = Image("BG_SettingView")
                let imageSize = UIImage(named: "BG_SettingView")?.size ?? CGSize.zero
                
                // 스케일팩터 계산하기(좌우, 상하)
                let widthScaleFactor = screenWidth / imageSize.width
                let heightScaleFactor = screenHeight / imageSize.height
                
                // 큰 스케일에 맞춰서 resizable
                let scaleFactor = max(widthScaleFactor, heightScaleFactor)
                
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
                    .position(x: screenWidth / 2, y: screenHeight / 2)
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                // 미리보기 위에 따로 띄우는 뷰
                Text(" ")
//                    .frame(height: 20)
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
                                
                                CustomToggleSet(text: "플래시", isToggled: $bellToggled)
                                
                                CustomToggleSet(text: "진동", isToggled: $bellToggled)
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
                
                }
                // Scroll 영역 끝
                
                Button(action: {
                    // 미리보기 뷰 띄우기
                    isPresentedSOSMessageView = true
                }, label: {
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [AppColors.blue01, AppColors.green07]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                            .frame(width: .infinity, height: 60)
                            .cornerRadius(68)
                            .padding(.leading, 36)
                            .padding(.trailing, 36)
                        
                        Text("미리 보기")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundStyle(Color(.white))
                    }
                })
                .padding(12)
                
                // 미리보기 아래의 강제 띄우는 칸
                Text(" ")
                    .frame(height: 16)
            }
            .sheet(isPresented: $isPresentedSOSMessageView, content: {PreviewView(isPresentedSOSMessageView: $isPresentedSOSMessageView, SOSMessage: message)})
        }
    }
}


struct SettingView_Preview: PreviewProvider{
    @State static var message = "긴급 메시지"
    @State static var hospitalInfo = "병원정보"
    @State static var medicineInfo = "자주가는 병원"
    
    static var previews: some View{
        SettingView(message: message, hospitalInfo: hospitalInfo, medicineInfo: medicineInfo)
    }
}


