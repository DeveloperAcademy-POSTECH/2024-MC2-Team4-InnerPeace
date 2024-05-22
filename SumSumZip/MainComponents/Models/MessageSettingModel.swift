//
//  MessageSaveModel.swift
//  RainP
//
//  Created by heesohee on 5/22/24.
//

import Foundation

class MessageManager {
    static let shared = MessageManager()
    private let messageKey = "savedMessage"
    
    private init() {}
    
    func saveMessage(_ message: String) {
        UserDefaults.standard.set(message, forKey: messageKey)
        print("메세지 저장함수")
    }
    
    func fetchMessage() -> String {
        return UserDefaults.standard.string(forKey: messageKey) ?? "기본 메세지"
    }
}
