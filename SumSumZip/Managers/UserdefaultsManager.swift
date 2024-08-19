//
//  UserdefaultsManager.swift
//  SumSumZip
//
//  Created by 신승아 on 5/22/24.
//

import SwiftUI

class UserdefaultsManager {
    
    private static let hospitalInfoKey = "hospitalInfo"
    private static let medicineInfoKey = "medicineInfoKey"
    private static let breathingPracticeTimeKey = "breathingPracticeTimeKey"
    private static let bellToggled = "bellToggled"
    private static let torchToggled = "torchToggled"
    private static let vibrationToggle = "vibrationToggled"
    
    static var hospitalInfo: String {
        get {
            UserDefaults.standard.string(forKey: hospitalInfoKey) ?? ""
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: hospitalInfoKey)
        }
    }
    
    static var medicineInfo: String {
        get {
            UserDefaults.standard.string(forKey: medicineInfoKey) ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: medicineInfoKey)
        }
    }
    
    static var breathingPracticeInfo: Int {
        get {
            UserDefaults.standard.integer(forKey: breathingPracticeTimeKey)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: breathingPracticeTimeKey)
        }
    }
    
    static var bellToggledInfo: Bool {
        get {
            UserDefaults.standard.bool(forKey: bellToggled)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: bellToggled)
        }
    }
    
    static var torchToggledInfo: Bool {
        get {
            UserDefaults.standard.bool(forKey: torchToggled)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: torchToggled)
        }
    }
    
    static var vibrationToggleInfo: Bool {
        get {
            UserDefaults.standard.bool(forKey: vibrationToggle)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: vibrationToggle)
        }
    }
    
    
}
