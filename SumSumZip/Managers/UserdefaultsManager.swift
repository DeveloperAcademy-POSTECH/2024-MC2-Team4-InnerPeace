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
    
}
