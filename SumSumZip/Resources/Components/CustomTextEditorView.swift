//
//  CustomTextEditorView.swift
//  SumSumZip
//
//  Created by 신승아 on 5/21/24.
//

import SwiftUI

struct CustomTextEditorView: View {
    @Binding var message: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(AppColors.white.opacity(1))
                .frame(width: .infinity, height: 126)
                .cornerRadius(17)
            
            TextEditor(text: $message)
                .padding(8)
                .foregroundColor(AppColors.systemGray)
                .frame(width: .infinity, height: 126)
                .font(.system(size:15))
                .cornerRadius(10)
                .scrollContentBackground(.hidden)
        }
        .onDisappear(){ //데이지작성
            MessageManager.shared.saveMessage(message)
        }
    }
}

