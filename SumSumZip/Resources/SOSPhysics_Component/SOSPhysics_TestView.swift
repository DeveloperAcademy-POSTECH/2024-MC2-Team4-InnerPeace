//  Assignee: Leo
//  SOSPhysics_TestView.swift
//
//  Created by Leo Yoon on 5/21/24.
//

import SwiftUI
import AVFAudio

struct SOSPhysics_TestView: View {
    
    @StateObject private var torchControl = TorchControl()
    @StateObject private var hapticControl = HapticControl()
    @StateObject private var soundControl = SoundControl()
    @State private var isRunning = false
    @State private var audioPlayer = AVAudioPlayer.self // self랑 ?랑 무슨차이지??
    @State private var flashTimer: Timer?
    @State private var hapticTimer: Timer?
    @State private var soundTimer: Timer?
    
    func startAll() {
        flashTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ _ in
            self.torchControl.torchBrightness = self.torchControl.torchBrightness == 0.0 ? 1.0 : 0.0
        }
        self.hapticControl.prepareHaptics()
        hapticTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true){ _ in
            self.hapticControl.playHaptic()
        }
        soundTimer = Timer.scheduledTimer(withTimeInterval: 9, repeats: true){ _ in
            self.soundControl.playSound()
        }
    }
    
    func stopAll() {
        flashTimer?.invalidate()
        hapticTimer?.invalidate()
        soundTimer?.invalidate()
        self.torchControl.torchBrightness = 0.0
        
    }
    
    var body: some View {
        Button{
            self.isRunning = true
            self.startAll()
        } label:{
            Text("Start all")
        }
        .frame(width: 200, height: 40)
        .background(Color(AppColors.lightBlue))
        .clipShape(RoundedRectangle(cornerRadius: 90, style: .circular))
        Text(" ")
        
        Button{
            self.isRunning = false
            self.stopAll()
        } label: {
            Text("Stop all")
        }
        .frame(width: 200, height: 40)
        .background(Color(AppColors.systemGray))
        .clipShape(RoundedRectangle(cornerRadius: 90, style: .circular))
        Text(" ")
        
        Text(isRunning ? "작동 중" : "정지상태")
        
    }
}

#Preview {
    SOSPhysics_TestView()
}
