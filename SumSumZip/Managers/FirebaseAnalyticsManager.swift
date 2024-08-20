//
//  FirebaseAnalyticsManager.swift
//  SumSumZip
//
//  Created by 신승아 on 8/20/24.
//

import Foundation
import FirebaseAnalytics

class FirebaseAnalyticsManager {
    
    /// 홈 - SOS 버튼 클릭
    func logSOSButtonClick() {
        Analytics.logEvent("home_sos_button_click", parameters:  [
            "button_name": "SOS Button",
            "screen_name": "SOSView"
        ])
    }

    /// 호흡 - 시작 버튼 클릭
    func logBreathingStartClick() {
        Analytics.logEvent("breathing_start_button_click", parameters:  [
            "button_name": "Breath Start Button",
            "screen_name": "PracticeBreathingIntro"
        ])
    }

    /// 호흡 - 시간 클릭
    func logBreathingTimeSelection(time: String) {
        Analytics.logEvent("breathing_time_selection", parameters: ["selected_time": time])
    }

    /// 호흡 - 종료 버튼 클릭
    func logBreathingEndClick() {
        Analytics.logEvent("breathing_end_button_click", parameters: [
            "button_name": "Breath End Button",
            "screen_name": "StartBreathView"
        ])
    }

    /// 토글 변경
    func logToggleChange(eventName: String, toggleState: Bool) {
        Analytics.logEvent(eventName, parameters: ["toggle_state": toggleState])
    }
    
    /// 사용자 설정 - 알람 소리 토글 변경
    func logAlarmToggleChange(isOn: Bool) {
        logToggleChange(eventName: "settings_toggle_alarm", toggleState: isOn)
    }

    /// 사용자 설정 - 플래시 토글 변경
    func logFlashToggleChange(isOn: Bool) {
        logToggleChange(eventName: "settings_toggle_flash", toggleState: isOn)
    }

    /// 사용자 설정 - 진동 토글 변경
    func logVibrationToggleChange(isOn: Bool) {
        logToggleChange(eventName: "settings_toggle_vibration", toggleState: isOn)
    }

    /// 텍스트 입력 유무
    func logTextFieldInput(eventName: String, isEmpty: Bool) {
        Analytics.logEvent(eventName, parameters: ["input_state": isEmpty])
    }
    
    /// 긴급 메시지 작성 유무
    func logEmergencyMessageInput(isEmpty: Bool) {
        logTextFieldInput(eventName: "emergency_message_input", isEmpty: isEmpty)
    }

    /// 자주 가는 병원 작성 유무
    func logFrequentHospitalInput(isEmpty: Bool) {
        logTextFieldInput(eventName: "frequent_hospital_input", isEmpty: isEmpty)
    }

    /// 약 정보 작성 유무
    func logMedicineInfoInput(isEmpty: Bool) {
        logTextFieldInput(eventName: "medicine_info_input", isEmpty: isEmpty)
    }

    /// 긴급 연락처 작성 유무
    func logEmergencyContactInput(isEmpty: Bool) {
        logTextFieldInput(eventName: "emergency_contact_input", isEmpty: isEmpty)
    }
}
