//
//  CustomNavigationModifier.swift
//  SumSumZip
//
//  Created by 신승아 on 5/21/24.
//

import SwiftUI

struct CustomNavigationModifier: ViewModifier {
    let title: String
    let saveAction: () -> Void

    @Environment(\.dismiss) var dismiss

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: saveAction) {
                        HStack {
                            Text("저장")
                                .fontWeight(.bold)
                                .foregroundColor(AppColors.darkGreen)
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                    .foregroundColor(AppColors.darkGreen)
                }
            }
    }
}
