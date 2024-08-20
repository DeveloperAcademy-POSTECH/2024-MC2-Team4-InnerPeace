//
//  GeometryReadingViewModel.swift
//  SumSumZip
//
//  Created by Leo Yoon on 8/20/24.
//

import SwiftUI

struct GeometryReadingViewModel: View{
    var body: some View{
        @ObservedObject var screenSize = ScreenSize.shared // 스크린 사이즈 측정을 위한 기능들 모음
        
        GeometryReader {geometry in
            Color.clear
                .onAppear{
                    screenSize.updateSize(size: geometry.size)
                    let bgUIImage = UIImage(named: "BG_SettingView")
                    screenSize.handleImage(bgUIImage!)
                    screenSize.updateTabBarHeight(sizeGeometry: geometry.size)
                }
        }
    }
}
