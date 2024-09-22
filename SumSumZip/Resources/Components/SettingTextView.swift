//
//  CustomTextEditorView.swift
//  SumSumZip
//
//  Created by 신승아 on 5/21/24.
//

import SwiftUI

struct SettingTextView: View {
    @Binding var message: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(AppColors.white.opacity(1))
                .frame(height: 126)
                .cornerRadius(17)
            
            TextEditor(text: $message)
                .padding(8)
                .foregroundColor(AppColors.systemGray)
                .frame(height: 126)
                .font(.system(size:15))
                .cornerRadius(10)
                .scrollContentBackground(.hidden)
                .overlay(alignment: .topLeading) { // TextField의 placeholder 기능 대체
                    Text("""
                         긴급메세지를 작성해주세요.
                         ex)가방 안에 응급약이 있습니다.
                         ex)010-xxxx-xxxx로 전화해주세요.
                        """)
                        .foregroundStyle(message.isEmpty ? .gray : .clear)
                        .font(.system(size: 15))
                        .padding(14)
                }
        }
        .onDisappear(){ //데이지작성
            MessageManager.shared.saveMessage(message)
        }
    }
}

