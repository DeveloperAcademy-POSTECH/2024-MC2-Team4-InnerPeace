//
//  Keyboard+Extension.swift
//  SumSumZip
//
//  Created by 신승아 on 8/19/24.
//

import Foundation
import UIKit

// 키보드를 숨기는 확장
extension UIApplication {
    func endEditing(_ force: Bool) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows
            .first { $0.isKeyWindow }?
            .endEditing(force)
    }
}
