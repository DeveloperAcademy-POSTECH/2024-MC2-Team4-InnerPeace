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
    
    @Binding var hospitalInfo_tmp : String
    @Binding var medicineInfo_tmp : String
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,
                   spacing: 6) {
                SettingQuestionLabel(text: "자주 가는 병원을 적어주세요")
                    .padding(.top, 20)
                CustomTextEditorView(message: $hospitalInfo_tmp)
                    .padding(.bottom, 45)
                
                SettingQuestionLabel(text: "복용 중인 약의 정보를 적어주세요")
                CustomTextEditorView(message: $medicineInfo_tmp)
                Spacer()
            }
                   .navigationBarTitleDisplayMode(.inline)
                   .toolbar {
                       ToolbarItem(placement: .principal) {
                           Text("환자 정보")
                               .fontWeight(.bold)
                               .font(.headline)
                               .foregroundColor(AppColors.darkGreen)
                       }
                       ToolbarItem(placement: .navigationBarLeading) {
                           HStack(spacing: 0){
                               Button(action: {
                                   hospitalInfo_tmp = UserdefaultsManager.hospitalInfo
                                   medicineInfo_tmp = UserdefaultsManager.medicineInfo
                                   dismiss()
                               }) {
                                   Text("취소")
                                       .foregroundColor(AppColors.darkGreen)
                               }
                           }
                       }
                       ToolbarItem(placement: .navigationBarTrailing) {
                           Button(action: {
                               hospitalInfo = hospitalInfo_tmp
                               medicineInfo = medicineInfo_tmp
                               UserdefaultsManager.hospitalInfo = hospitalInfo
                               UserdefaultsManager.medicineInfo = medicineInfo
                               dismiss()
                           }) {
                               Text("저장")
                                   .foregroundColor(AppColors.darkGreen)
                           }
                       }
                   }
//                   .customNavigation(title: "환자 정보") {
//                       // 환자 정보 저장 로직
//                       UserdefaultsManager.hospitalInfo = hospitalInfo
//                       UserdefaultsManager.medicineInfo = medicineInfo
//                       dismiss()
//                   }
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden ()
        .onAppear {
            hospitalInfo = hospitalInfo != "" ? hospitalInfo : ""
            medicineInfo = medicineInfo != "" ? medicineInfo : ""
        }
    }
}

struct PatientInfoSetting_Previews: PreviewProvider {
    @State static var hospitalInfo = "자주 가는 병원"
    @State static var medicineInfo = "투약정보"
    @State static var hospitalInfo_tmp = "자주 가는 병원"
    @State static var medicineInfo_tmp = "투약정보"
    
    static var previews: some View {
        PatientInfoSettingView(hospitalInfo: $hospitalInfo, medicineInfo: $medicineInfo, hospitalInfo_tmp: $hospitalInfo_tmp, medicineInfo_tmp: $medicineInfo_tmp)
    }
}
