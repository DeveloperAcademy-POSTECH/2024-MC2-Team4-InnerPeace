//
//  UserdefaultsManager.swift
//  SumSumZip
//
//  Created by 신승아 on 5/22/24.
//

import SwiftUI

class UserdefaultsManager {
    
    private static let isInitialLaunchKey = "isInitialLaunch"
    private static let hospitalInfoKey = "hospitalInfo"
    private static let medicineInfoKey = "medicineInfoKey"
    private static let breathingPracticeTimeKey = "breathingPracticeTimeKey"
    private static let bellToggled = "bellToggled"
    private static let torchToggled = "torchToggled"
    private static let vibrationToggle = "vibrationToggled"
    private static let messageKey = "savedMessage"
    
    static func setupInitialDefaults() {
        if !UserDefaults.standard.bool(forKey: isInitialLaunchKey) {
            UserDefaults.standard.set(true, forKey: bellToggled)
            UserDefaults.standard.set(true, forKey: torchToggled)
            UserDefaults.standard.set(true, forKey: vibrationToggle)
            UserDefaults.standard.set(true, forKey: isInitialLaunchKey) // 초기 실행 표시
        }
    }

    // 긴급 메시지 저장 및 가져오기
    static var savedMessage: String {
        get {
            UserDefaults.standard.string(forKey: messageKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: messageKey)
 //           print("메세지 저장함수")
        }
    }
    
    // 병원 정보 저장 및 가져오기
    static var hospitalInfo: String {
        get {
            UserDefaults.standard.string(forKey: hospitalInfoKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: hospitalInfoKey)
        }
    }
    
    // 약 정보 저장 및 가져오기
    static var medicineInfo: String {
        get {
            UserDefaults.standard.string(forKey: medicineInfoKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: medicineInfoKey)
        }
    }
    
    // 호흡 연습 시간 저장 및 가져오기
    static var breathingPracticeInfo: Int {
        get {
            UserDefaults.standard.integer(forKey: breathingPracticeTimeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: breathingPracticeTimeKey)
        }
    }
    
    // 알람 토글 상태 저장 및 가져오기
    static var bellToggledInfo: Bool {
        get {
            UserDefaults.standard.bool(forKey: bellToggled)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: bellToggled)
        }
    }
    
    // 플래시 토글 상태 저장 및 가져오기
    static var torchToggledInfo: Bool {
        get {
            UserDefaults.standard.bool(forKey: torchToggled)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: torchToggled)
        }
    }
    
    // 진동 토글 상태 저장 및 가져오기
    static var vibrationToggleInfo: Bool {
        get {
            UserDefaults.standard.bool(forKey: vibrationToggle)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: vibrationToggle)
        }
    }
}
