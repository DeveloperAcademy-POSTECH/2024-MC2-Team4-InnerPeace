//
//  CustomTextEditorSimpleView.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/13/24.
//

import SwiftUI

struct CustomTextEditorSimpleView: View {
    @Binding var message: String
    
    var body: some View {
        TextEditor(text: $message)
            .padding(4)
            .background(AppColors.paleGreen.opacity(1))
            .frame(width: 359, height: 44)
            .cornerRadius(17)
            .scrollContentBackground(.hidden)
    }
}
