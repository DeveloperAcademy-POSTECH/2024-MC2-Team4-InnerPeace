//
//  PatientInfoSetting.swift
//  SumSumZip
//
//  Created by 신승아 on 5/21/24.
//

import SwiftUI

struct PatientInfoSettingView: View {

    var body: some View {
        
        VStack(alignment: .leading,
               spacing: 6) {
            SettingQuestionLabel(text: "자주 가는 병원을 적어주세요")
                .padding(.top, 20)
            CustomTextEditorView()
                .padding(.bottom, 45)

            SettingQuestionLabel(text: "복용 중인 약의 정보를 적어주세요")
            CustomTextEditorView()
            Spacer()
        }
        .customNavigation(title: "환자 정보") {
            // 환자 정보 저장 로직

        }
        
        Spacer()
        

    }
}

#Preview {
    PatientInfoSettingView()
}

