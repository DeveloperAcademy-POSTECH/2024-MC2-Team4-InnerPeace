//
//  EmergencyLiveActivityLiveActivity.swift
//  EmergencyLiveActivity
//
//  Created by 신승아 on 5/15/24.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct EmergencyLiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var progress: Double
    }

    var title: String
    var firstSubtitle: String
    var secondSubtitle: String
}

struct EmergencyLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EmergencyLiveActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            activityView(context: context, isForDynamicIsland: false)
                .background(AppColors.black)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here
                DynamicIslandExpandedRegion(.leading) {

                }
                DynamicIslandExpandedRegion(.trailing) {

                }
                DynamicIslandExpandedRegion(.bottom) {
                    activityView(context: context, isForDynamicIsland: true)
                    
                }
            } compactLeading: {
                Image("SOS_1")
                    .resizable()
                    .scaledToFit()

            } compactTrailing: {
                // 만약 타이머가 다되었으면 숨기는 조건 필요
                if context.state.progress < 1 {
                    sosProgressView(progress: context.state.progress)
                }
                
            } minimal: {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            }
        }
    }
    
    private func sosProgressView(progress: Double) -> some View {
        ProgressView(value: progress, total: 1.0)
            .progressViewStyle(CircularProgressViewStyle())
            .tint(AppColors.lightCyan)
    }
    
    private func activityView(context: ActivityViewContext<EmergencyLiveActivityAttributes>, isForDynamicIsland: Bool) -> some View {
        VStack(spacing: 0) {  // 간격을 0으로 설정
            Text("공황 증상이 발생했습니다!")
                .bold()
                .padding(.top, isForDynamicIsland ? 0 : 35)  // 상단 패딩 조정
                .font(.system(size: 22))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.white)
//                .background(Color.red.opacity(0.3))  // 텍스트 영역 배경 추가
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {  // 간격을 0으로 설정
                    Text("환자의 의식이 없다면\n119에 신고 부탁드립니다.")
                        .padding(.top, 0)  // 상단 패딩을 0으로 설정
                        .font(.system(size: 18))
                        .foregroundColor(AppColors.lightCyan)
//                        .background(Color.blue.opacity(0.3))  // 텍스트 영역 배경 추가
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 19)
                
                Image("SOS_1")
                    .frame(width: 90, height: 90)
//                    .padding(.bottom, 30)
//                    .background(Color.gray.opacity(0.3))  // 텍스트 영역 배경 추가
            }
            .padding(.top, 0)  // 제목과 부제 사이의 간격을 0으로 설정
        }
        .activitySystemActionForegroundColor(Color.black)
    }


}
