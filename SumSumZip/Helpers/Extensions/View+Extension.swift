//
//  View+Extension.swift
//  SumSumZip
//
//  Created by 신승아 on 5/21/24.
//

import SwiftUI

extension View {
    func customNavigation(title: String, saveAction: @escaping () -> Void) -> some View {
        self.modifier(CustomNavigationModifier(title: title, saveAction: saveAction))
    }
    
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
