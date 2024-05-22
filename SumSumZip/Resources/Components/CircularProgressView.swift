//
//  CircularProgressView.swift
//  SumSumZip
//
//  Created by 신승아 on 5/18/24.
//

import SwiftUI

struct CircularProgressView: View {
    @State private var progress: Double = 0.0
    @State private var remainingTime: Int = 30
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 4)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(Color.green, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
        }
        .onReceive(timer) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
                progress = Double(30 - remainingTime) / 30.0
                EmergencyLiveActivityManager.shared.updateActivity(progress: progress, imgName: nil)
            } else {
                timer.upstream.connect().cancel()
            }
        }
    }
}


#Preview {
    CircularProgressView()
}

