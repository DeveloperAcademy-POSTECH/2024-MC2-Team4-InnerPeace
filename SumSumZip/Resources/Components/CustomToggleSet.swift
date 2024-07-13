//
//  CustomToggleSet.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/13/24.
//

import SwiftUI

struct CustomToggleSet: View{
    var text: String
    @Binding var isToggled: Bool
    
    var body: some View {
        HStack{
            Text(text)
                .padding(.leading, 4)
                .foregroundColor(AppColors.systemGray)
            Spacer()
            Toggle(isOn: $isToggled, label: {})
                .padding(.trailing, 8)
                .labelsHidden()
        }
    }
}
