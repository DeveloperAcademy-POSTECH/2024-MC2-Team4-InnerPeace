//
//  CustomTextEditorView.swift
//  SumSumZip
//
//  Created by 신승아 on 5/21/24.
//

import SwiftUI

struct CustomTextEditorView: View {
    @State private var message = ""
    var body: some View {
        TextEditor(text: $message)
            .padding(4)
            .background(AppColors.paleGreen.opacity(1))
            .frame(width: 359, height: 90)
            .cornerRadius(10)
            .scrollContentBackground(.hidden)
    }
}

