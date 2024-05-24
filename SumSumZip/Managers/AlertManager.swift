//
//  AlertManager.swift
//  SumSumZip
//
//  Created by 신승아 on 5/23/24.
//

import SwiftUI

class AlertManager: ObservableObject {
    
    @Published var torchControl = TorchControl()
    @Published var hapticControl = HapticControl()
    @Published var soundControl = SoundControl()
    
    private var flashTimer: Timer?
    private var hapticTimer: Timer?
    private var soundTimer: Timer?
    var breathingTimer: Timer?
    
    var checkBreath = false
    var endButtonClicked = false
    
    static let shared = AlertManager()
    private init() {}
    
    func startAll() {
        // endButton 초기화
        endButtonClicked = false
        flashTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.torchControl.torchBrightness = self.torchControl.torchBrightness == 0.0 ? 1.0 : 0.0
        }
        
        hapticControl.prepareHaptics()
        
        if checkBreath {
            // 호흡용이면
            hapticTimer = Timer.scheduledTimer(withTimeInterval: 9, repeats: true) { [weak self] _ in
                self?.hapticControl.playHaptic(hapURL: "HapticWave_1")
            }
        } else {
            hapticTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
                self?.hapticControl.playHaptic(hapURL: "HapticWave_1")
            }
        }
        
        soundTimer = Timer.scheduledTimer(withTimeInterval: 9, repeats: true) { [weak self] _ in
            self?.soundControl.playSound()
        }
        
    }
    
    func changeToBreath() {
        checkBreath = true
        startBreathingCycle()
    }
    
    private func startBreathingCycle() {
        // 4초 진동 실행
        hapticControl.playHaptic(hapURL: "HapticWave_2")
        print("진동 시작")
        
        // 5초 후에 멈춤
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            print("진동 멈춤")
            self.stopHaptic()
            
            // 5초 후에 다시 시작
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if !self.endButtonClicked {
                    self.startBreathingCycle()
                }
            }
        }
    }
    
    func stopHaptic() {
        // 진동 멈춤 로직이 필요하면 여기에 추가합니다.
        // 예: hapticControl.stopHaptic()
        print("진동 멈춤")
    }
    
    func stopAll() {
        flashTimer?.invalidate()
        hapticTimer?.invalidate()
        soundTimer?.invalidate()
        breathingTimer?.invalidate()
        
        torchControl.torchBrightness = 0.0
        hapticControl.stopHaptic()
        soundControl.stopSound()
    }
}
