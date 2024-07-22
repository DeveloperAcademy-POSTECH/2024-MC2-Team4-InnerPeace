//
//  ScreenSizeReadingModel.swift
//  SumSumZip
//
//  Created by Leo Yoon on 7/21/24.
//

import SwiftUI


class ScreenSize: ObservableObject {
    static let shared = ScreenSize()
    
    @Published var screenWidth: CGFloat = 0
    @Published var screenHeight: CGFloat = 0
    @Published var scaleFactor: CGFloat = 0
    @Published var tabBarHeight: CGFloat = 0
    
    private init() {
        updateSize(size: CGSize())
    }
    
    func updateSize(size: CGSize) {
        self.screenWidth = size.width
        self.screenHeight = size.height
    }
    
    func handleImage(_ bgImage: UIImage) {
        let imageSize = bgImage.size
        let widthScaleFactor = screenWidth / imageSize.width
        let heightScaleFactor = screenHeight / imageSize.height
        let scaleFactor = max(widthScaleFactor, heightScaleFactor)
        
        self.scaleFactor = scaleFactor
        }
    
    func updateTabBarHeight(sizeGeometry: CGSize) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                let tabBarHeight = window.rootViewController?.tabBarController?.tabBar.frame.height ?? 49
                self.tabBarHeight = tabBarHeight
            }
        }
}


//
// 사용방법: View 내부에, 아래의 샘플코드처럼 넣어서 사용가능.
// --> 자세한 내용은 SettingView에서 사용된 예시들 참조하기 바랍니다.
//
//GeometryReader {geometry in
//    Color.clear
//        .onAppear{
//            screenSize.updateSize(size: geometry.size)
//            let bgUIImage = UIImage(named: "BG_SettingView")
//            screenSize.handleImage(bgUIImage!)
//            screenSize.updateTabBarHeight(sizeGeometry: geometry.size)
//        }
//}
