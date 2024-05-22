//
//  TimeSettingModel.swift
//  SumSumZip
//
//  Created by Dongin Kang on 5/21/24.
//

import Foundation

class SOSTimeDataManager {
    static let shared = SOSTimeDataManager()
    private let timeKey = "SOSsavedTime"
    
    private init() {}
    
    func saveTime(_ time: Int) {
        UserDefaults.standard.set(time, forKey: timeKey)
    }
    
    func fetchTime() -> Int {
        return UserDefaults.standard.integer(forKey: timeKey)
    }
}

class BreathTimeDataManager {
    static let shared = BreathTimeDataManager()
    private let timeKey = "BreathsavedTime"
    
    private init() {}
    
    func saveTime(_ time: Int) {
        UserDefaults.standard.set(time, forKey: timeKey)
    }
    
    func fetchTime() -> Int {
        return UserDefaults.standard.integer(forKey: timeKey)
    }
}
