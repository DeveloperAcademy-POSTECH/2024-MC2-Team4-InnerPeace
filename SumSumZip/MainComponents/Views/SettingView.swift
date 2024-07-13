//
//  SettingView.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/13/24.
//

import SwiftUI

struct SettingView: View{
    @Binding var message : String // 긴급메시지 저장 전에
    @Binding var hospitalInfo : String // 자주가는 병원
    @Binding var medicineInfo : String
    
    @State private var numOfRelation = ContactsManager.shared.fetchContacts().last ?? "0"
    
    @State var bellToggled: Bool = false // 알람소리 On/Off
    
    var body: some View{
        ZStack{
            Image("BG_SettingView")
        VStack{
            Text(" ")
            HStack {
                Text("사용자 설정")
                    .font(.system(size:32))
                    .bold()
                    .foregroundStyle(Color(.green))
                Spacer()
                Text(" ")
            }.padding(16)
            
            // Scroll 영역 시작
            ScrollView{
                VStack(alignment: .leading){
                    
                    SettingQuestionLabel(text: "SOS 알람")
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(17)
                        VStack(alignment:.center){
                            HStack{
                                Text("알람 소리")
                                Spacer()
                                Toggle(isOn: $bellToggled, label: {})
                                    .padding(.trailing, 20)
                                    .labelsHidden()
                            }
                            HStack{
                                Text("플래시")
                                Spacer()
                                Toggle(isOn: $bellToggled, label: {})
                                    .padding(.trailing, 20)
                                    .labelsHidden()
                            }
                            HStack{
                                Text("진동")
                                Spacer()
                                Toggle(isOn: $bellToggled, label: {})
                                    .padding(.trailing, 20)
                                    .labelsHidden()
                            }
                        }
                        .padding(16)
                    }
                    Text(" ")
                    
                    SettingQuestionLabel(text: "긴급 메시지")
                    CustomTextEditorView(message: $message)
                    Text(" ")
                    
                    SettingQuestionLabel(text: "자주 가는 병원") // 단순 TextField로 바꾸기?
                    CustomTextEditorSimpleView(message: $medicineInfo)
                    Text(" ")
                    
                    // Q. 약정보 한 줄로 처리하기?
                    SettingQuestionLabel(text: "약 정보") // 단순 TextField로 바꾸기?
                    CustomTextEditorSimpleView(message: $medicineInfo)
                    Text(" ")
                    
                    SettingQuestionLabel(text: "긴급 메시지")
                    CustomTextEditorView(message: $message) // 바꿔주세요...
                    Text(" ")
                    
                    SettingQuestionLabel(text: "긴급 연락처")
                    PatientContactEditorView(numOfRelation: $numOfRelation)
                }
            }
            .padding(16)
            // Scroll 영역 끝

            Button(action: {
                // 미리보기 뷰 띄우기
            }, label: {
                ZStack{
                    LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        .frame(width: 300, height: 60)
                        .cornerRadius(68)
                    
                    Text("미리보기")
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
