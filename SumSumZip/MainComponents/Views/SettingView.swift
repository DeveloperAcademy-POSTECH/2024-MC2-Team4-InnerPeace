//
//  SettingView.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/13/24.
//

import SwiftUI

//class ToggleViewModel: ObservableObject{
//    @Published var bellToggled: Bool = false // 알람소리 On/Off
//}

struct SettingView: View{
    @Binding var message : String // 긴급메시지 저장 전에
    @Binding var hospitalInfo : String // 자주가는 병원
    @Binding var medicineInfo : String
    
    @State private var numOfRelation = ContactsManager.shared.fetchContacts().last ?? "0"
    
    @State var bellToggled: Bool = true // 알람소리 On/Off
    @State var torchToggled: Bool = true // 알람소리 On/Off
    @State var vibrationToggled: Bool = true // 알람소리 On/Off
    
    var body: some View{
        ZStack{
            Image("BG_SettingView")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        VStack{
            Text(" ")
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
                    Text(" ")
                    
                    SettingQuestionLabel(text: "긴급 메시지")
                    CustomTextEditorView(message: $message)
                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                    
                    Text(" ")
                    
                    SettingQuestionLabel(text: "자주 가는 병원") // 단순 TextField로 바꾸기?
                    CustomTextEditorSimpleView(message: $hospitalInfo)
                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                    Text(" ")
                    
                    // Q. 약정보 한 줄로 처리하기?
                    SettingQuestionLabel(text: "약 정보") // 단순 TextField로 바꾸기?
                    CustomTextEditorSimpleView(message: $medicineInfo)
                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 4, y: 8)
                    Text(" ")
                    
                    SettingQuestionLabel(text: "긴급 연락처")
                    PatientContactEditorView(numOfRelation: $numOfRelation)
                    // 여기 shadow는 컴포넌트 내부에 있습니다.
                }
            }
            .padding(16)
            // Scroll 영역 끝

            Button(action: {
                // 미리보기 뷰 띄우기
            }, label: {
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [AppColors.blue01, AppColors.green07]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        .frame(width: .infinity, height: 60)
                        .cornerRadius(68)
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                    
                    Text("미리 보기")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundStyle(Color(.white))
                }
            })
            .padding(12)
            
            Text(" ")
                .frame(height: 12)
        }
    }
    }
}


struct SettingView_Preview: PreviewProvider{
    @State static var message = "긴급 메시지"
    @State static var hospitalInfo = "병원정보"
    @State static var medicineInfo = "자주가는 병원"
    
    static var previews: some View{
        SettingView(message: $message, hospitalInfo: $hospitalInfo, medicineInfo: $medicineInfo)
    }
}
