//
//  AlertManager.swift
//  SumSumZip
//
//  Created by 신승아 on 5/23/24.
//

import SwiftUI
import Combine

class BreathTimeManager: ObservableObject {
    @Published var hapticControl = HapticControl()
    private var hapticTimer: Timer?
    private var isHapticActive = false
    private var isHapticEnabled = true // 진동 활성화 여부를 나타내는 플래그
    private var hapticStateDuration = 4.0 // 진동 시간
    
    static let shared = BreathTimeManager()
    
    private init() {
        print("BreathTimeManager initialize")
        hapticControl.prepareHaptics()
    }
    
    func startHaptic() {
        print("startHaptic: \(isHapticActive)")
        hapticStateDuration = 1 // 첫 번째 상태는 진동
        isHapticActive = true
        isHapticEnabled = true // 진동을 활성화합니다.
        resetTimer() // 타이머 재설정
    }
    
    func stopTimer() {
        hapticTimer?.invalidate()
        hapticTimer = nil
        isHapticActive = false
    }
    
    func disableHaptic() {
        isHapticEnabled = false
        hapticControl.stopHaptic()
    }
    
    func enableHaptic() {
        isHapticEnabled = true
    }
    
    private func resetTimer() {
        hapticTimer?.invalidate()
        hapticTimer = Timer.scheduledTimer(timeInterval: hapticStateDuration, target: self, selector: #selector(toggleHapticState), userInfo: nil, repeats: false)
    }
    
    @objc private func toggleHapticState() {
        // 진동 상태를 토글하기 전에 진동을 멈추는 로직을 처리
        if !isHapticActive {
            hapticControl.stopHaptic()
            hapticStateDuration = 6.0 // 정적 후 진동 시간
        } else if isHapticEnabled {
            hapticControl.playHaptic(hapURL: "HapticWave_1")
            hapticStateDuration = 11.0 // 진동 후 정적 시간
        }

        isHapticActive.toggle()
        
        resetTimer()
    }

}

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
