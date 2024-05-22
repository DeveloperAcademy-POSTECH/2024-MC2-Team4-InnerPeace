//
//  ContactsSettingModel.swift
//  RainP
//
//  Created by heesohee on 5/22/24.
//

import Foundation

class ContactsManager {
    static let shared = ContactsManager()
    private let contactsKey = "savedContacts"
    
    private init() {}

 func saveContacts(_ number1: String, _ number2: String, _ number3: String, _ relation1: String, _ relation2: String, _ relation3: String) {
     let contacts = [number1, number2, number3, relation1, relation2, relation3]
     UserDefaults.standard.set(contacts, forKey: contactsKey)
     print("연락처 저장 함수 실행")
 }
 
 func fetchContacts() -> [String] {
     return UserDefaults.standard.stringArray(forKey: contactsKey) ?? []
 }
}
