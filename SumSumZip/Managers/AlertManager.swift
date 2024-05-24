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
    
    let breathingDuration: TimeInterval = 4.0 // 들이마시는 시간 (초)
    let pauseDuration: TimeInterval = 5.0 // 멈추는 시간 (초)
    
    static let shared = AlertManager()
    private init() {}
    
    func startAll() {
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
        
        breathingTimer = Timer.scheduledTimer(withTimeInterval: breathingDuration + pauseDuration, repeats: true) { _ in
            print("BreathTimer 생성")
            self.hapticControl.playHaptic(hapURL: "HapticWave_2")
        }
        
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
