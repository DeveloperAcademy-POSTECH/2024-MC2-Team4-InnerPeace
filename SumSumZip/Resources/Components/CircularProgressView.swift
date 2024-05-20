//
//  CircularProgressView.swift
//  SumSumZip
//
//  Created by 신승아 on 5/18/24.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 4)
                
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(Color.green, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.5)
}

