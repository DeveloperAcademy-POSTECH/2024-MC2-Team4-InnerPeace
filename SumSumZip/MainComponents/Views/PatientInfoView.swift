//
//  PatientInfoView.swift
//  SumSumZip
//
//  Created by 신승아 on 5/22/24.
//

import SwiftUI

struct PatientInfoView: View {
    // PatientInfoView로 화면전환할 때, 파라미터에 해당 Userdefaults 값 넘겨주세요
    @Binding var hospitalInfo: String
    @Binding var medicineInfo: String
    @Binding var isShownPatientInfo: Bool

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            TitleView()
            
            ContentView()
            
            Spacer()

            CustomXButton(action: {
                // 화면 전환 로직
                isShownPatientInfo = false
            })
            .padding(.bottom, 30)
        }
        .background(Color.black.opacity(0.82))
        .background(ClearBackground())
//        .background(Color.black.opacity(0.82))
    }
    
    @ViewBuilder
    private func TitleView() -> some View {
        Text("환자 정보")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 20)
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    private func ContentView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            InfoSection("자주 가는 병원", $hospitalInfo)
                .padding(.bottom, 49)
            InfoSection("복용 중인 약", $medicineInfo)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(radius: 5))
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func InfoSection(_ infoTitle: String, _ infoContent: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            
            SettingQuestionLabel(text: infoTitle)
            
            TextEditor(text: infoContent)
                .frame(height: 90)
                .padding(10)
                .background(AppColors.paleGreen.opacity(1))
                .cornerRadius(10)
                .scrollContentBackground(.hidden)
                .disabled(true)
        }
    }
}

//#Preview(body: {
//    PatientInfoView()
//})
