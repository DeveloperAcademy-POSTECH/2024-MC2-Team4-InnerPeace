//
//  CustomXButton.swift
//  SumSumZip
//
//  Created by 신승아 on 5/22/24.
//

import SwiftUI

struct CustomXButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
            
        }) {
            Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundStyle(Color.secondary)
                .background(Color.white).clipShape(Circle())
        }
        .padding(.bottom, 20)
    }
}
