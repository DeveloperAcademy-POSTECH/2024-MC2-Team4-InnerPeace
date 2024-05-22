//  Assignee: Leo
//  SOS_Physical_Alert.swift
//
//  Test View
//
//  Created by Leo Yoon on 5/21/24.
//
import SwiftUI
import AVFoundation // #1. Torch 컨트롤용
import CoreHaptics // #2. Haptic 컨트롤용
import AVKit // # 3. Sound 컨트롤용


// #1. Torch 컨트롤용
class TorchControl: ObservableObject {
    
    // #1-1. torch 밝기값 선언
    @Environment(\.scenePhase) var scenePhase // torch 컨트롤용
    @Published var torchBrightness: Float = 0.0 { // torch 기본값 0.0 설정
        didSet{ // 밝기 값 범주 0.0~0.1 사이 조정
            guard torchBrightness <= 1.0 else {
                torchBrightness = 1.0
                return
            }
            guard torchBrightness >= 0.0 else {
                torchBrightness = 0.0
                return
            }
            setTorch(torchBrightness)
        }
    }
    
    // #1-2. torch 시동 켜기&끄기
    private func setTorch(_ torchBrightness: Float) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else{
            return
        }
        do {
            try device.lockForConfiguration()
            if torchBrightness == 0.0 {
                device.torchMode = .off // 플래시 꺼버리기
            } else{
                try device.setTorchModeOn(level: torchBrightness)
            }
            device.unlockForConfiguration()
        } catch {
            print(#function, error.localizedDescription)
        }
    }
    
}

// #2. Haptic 컨트롤용
class HapticControl: ObservableObject {
    
    private var engine: CHHapticEngine? // 햅틱 엔진
    @Published var hapURL = "HapticWave_1" // 햅틱 ahap 파일 불러오기 - (Project Name) - Build&Phases - Copy Bundle Resources
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Haptics are not supported on this device.")
            return
        }
        
        do {
            engine = try CHHapticEngine()
            engine?.resetHandler = { // 엔진 리셋 핸들러... 안정용이라는데 구체적으로는 모름.
                print("The engine reset --> Restarting...")
                do {
                    try self.engine?.start()
                } catch {
                    print("Failed to restart the engine: \(error.localizedDescription)")
                }
            }
            try engine?.start()
            print("Haptic engine started successfully.")
        } catch {
            print("Failed to start the engine: \(error.localizedDescription)")
        }
    }
    
    // #2-2. 햅틱 구동(진동 1회 - 부우웅~)
    func playHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Haptics are not supported on this device.")
            return
        }
        guard let url = Bundle.main.url(forResource: hapURL, withExtension: "ahap") else {
            print("Haptic file not found.")
            return
        }
        
        do {
            let pattern = try CHHapticPattern(contentsOf: url)
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate)
            print("Haptic pattern played successfully.")
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

// # 3. Sound 컨트롤용
class SoundControl: ObservableObject {
    static let instance = SoundControl()
    var player: AVAudioPlayer?
    
    var soundURL = "windows-xp-startup-sound" // sound 파일 불러오기
    
    func playSound() { // 왜 func이 class안에 들어있을까?
        guard let url = Bundle.main.url(forResource: soundURL, withExtension: ".mp3") else {return}
        
        do {
            //AVAudioSession 초기화 및 활성화
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true, options: [])
            try player = AVAudioPlayer(contentsOf: url) // Q. 왜 try일까?? 에러나기 쉬운 종류인걸까...?
            player?.play()
        } catch let error{
            print("Sound Error occured: \(error.localizedDescription)")
        }
    }
}
