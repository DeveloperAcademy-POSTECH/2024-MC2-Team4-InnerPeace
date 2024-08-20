//
//  CustomTextEditorSimpleView.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/13/24.
//

import SwiftUI

struct SettingTextField: View {
    @Binding var message: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(AppColors.white.opacity(1))
                .frame(height: 44)
                .cornerRadius(17)
            
            TextField("", text: $message)
                .padding(16)
                .scrollContentBackground(.hidden)
                .font(.system(size: 15))
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(AppColors.systemGray)
                .frame(height: 44)
                .cornerRadius(17)
        }
    }
}
