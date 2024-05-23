//
//  PatientInfoSetting.swift
//  SumSumZip
//
//  Created by 신승아 on 5/21/24.
//

import SwiftUI

struct PatientInfoSettingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var hospitalInfo: String
    @Binding var medicineInfo: String
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,
                   spacing: 6) {
                SettingQuestionLabel(text: "자주 가는 병원을 적어주세요")
                    .padding(.top, 20)
                CustomTextEditorView(message: $hospitalInfo)
                    .padding(.bottom, 45)
                
                SettingQuestionLabel(text: "복용 중인 약의 정보를 적어주세요")
                CustomTextEditorView(message: $medicineInfo)
                Spacer()
            }
                   .customNavigation(title: "환자 정보") {
                       // 환자 정보 저장 로직
                       UserdefaultsManager.hospitalInfo = hospitalInfo
                       UserdefaultsManager.medicineInfo = medicineInfo
                       dismiss()
                   }
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden ()
        .onAppear {
            hospitalInfo = hospitalInfo != "" ? hospitalInfo : ""
            medicineInfo = medicineInfo != "" ? hospitalInfo : ""
        }
        }
    }
    
    struct PatientInfoSetting_Previews: PreviewProvider {
        @State static var hospitalInfo = "자주 가는 병원"
        @State static var medicineInfo = "투약정보"
        
        static var previews: some View {
            PatientInfoSettingView(hospitalInfo: $hospitalInfo, medicineInfo: $medicineInfo)
        }
    }
