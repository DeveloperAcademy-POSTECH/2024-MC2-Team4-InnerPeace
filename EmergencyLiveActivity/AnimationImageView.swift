//
//  AnimationImageView.swift
//  SumSumZip
//
//  Created by 신승아 on 5/21/24.
//

import SwiftUI
import WebKit
import ActivityKit

// 방법1 - GIF로
struct GifReaderView: UIViewRepresentable {

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = Bundle.main.url(forResource: "SOS", withExtension: "gif"),
           let data = try? Data(contentsOf: url) {
            webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        } else {
            print("Error: GIF file not found or could not be loaded.")
        }
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No update needed for static GIF
    }
}

// 방법2 - 이미지 업데이트
struct ImageCyclerView: View {
    let context: Activity<EmergencyLiveActivityAttributes>

    let images = ["SOS", "image2", "image3"]

    var body: some View {
        VStack {
            
        }
//        Image(images[context.content.state.currentImageIndex])
//            .resizable()
//            .scaledToFit()
//            .frame(width: 100, height: 100)
    }
}

#Preview {
    GifReaderView()
}


