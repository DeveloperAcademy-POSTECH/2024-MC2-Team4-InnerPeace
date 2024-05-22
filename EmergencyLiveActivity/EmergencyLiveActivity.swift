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
        var imageName: String
    }

    var title: String
    var firstSubtitle: String
    var secondSubtitle: String
}

struct EmergencyLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EmergencyLiveActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
//            activityView(context: context, isForDynamicIsland: false)
//                .background(AppColors.black)
            VStack {
                Text(context.state.imageName)
                Image(context.state.imageName)
                
            }
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here
                DynamicIslandExpandedRegion(.leading) {

                }
                DynamicIslandExpandedRegion(.trailing) {

                }
                DynamicIslandExpandedRegion(.bottom) {
                    activityView(context: context, isForDynamicIsland: true)
//                    VStack {
//                        Text(context.state.imageName)
//                        Image(context.state.imageName)
//                        
//                    }
                    
                    
                }
            } compactLeading: {
                Image("SOS_1")
                    .resizable()
                    .scaledToFit()

            } compactTrailing: {
                // 만약 타이머가 다되었으면 숨기는 조건 필요
                if context.state.progress <= 1 {
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
        VStack {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 22))
                    .foregroundColor(AppColors.lightCyan)
                    .padding(.leading, 19)
                    .padding(.top, isForDynamicIsland ? 0 : 70)
                
                Text(context.attributes.title)
                    .bold()
                    .padding(.top, isForDynamicIsland ? 0 : 70)
                    .font(.system(size: 22))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white)
            }
            
//            Spacer()
//                .frame(height: isForDynamicIsland ? 14 : 10)
            
            HStack {
                VStack {
                    Text(context.attributes.firstSubtitle)
                        .padding(.bottom, isForDynamicIsland ? 0 : 0)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 19)
                        .foregroundStyle(.white)
                    
                    Text(context.attributes.secondSubtitle)
                        .padding(.bottom, 23)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 19)
                        .padding(.bottom, 10)
                        .foregroundColor(AppColors.lightCyan)
                }
                
                Image("SOS_1")
                    .frame(width: 90, height: 90)
                    .padding(.bottom, 30)
                    
            }
            
        }
        .activitySystemActionForegroundColor(Color.black)
    }
}
