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

struct EmergencyLiveActivityLiveActivity: Widget {
    
    // 우선은 임시로 30초컷..?
//    @State private var timerInterval = Date()...Date().addingTimeInterval(30)
        
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EmergencyLiveActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            activityView(context: context, isForDynamicIsland: false)
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
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(AppColors.lightCyan)
            } compactTrailing: {
                sosProgressView()
            } minimal: {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
    
    private func sosProgressView() -> some View {
        // 여기서 시간이 0이 되는 시점을 어떻게 잡을 수 있지...???
        ProgressView(timerInterval: Date()...Date().addingTimeInterval(30),
                     countsDown: true, label: { EmptyView() },
                     currentValueLabel: { EmptyView() })
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
                        .padding(.top, isForDynamicIsland ? 0 : 34)
                    
                    Text(context.attributes.title)
                        .bold()
                        .padding(.top, isForDynamicIsland ? 0 : 29)
                        .font(.system(size: 22))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                    .frame(height: isForDynamicIsland ? 14 : 36)
                
                VStack {
                    Text(context.attributes.firstSubtitle)
                        .padding(.bottom, isForDynamicIsland ? 0 : 5)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 19)
                    
                    Text(context.attributes.secondSubtitle)
                        .padding(.bottom, 23)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 19)
                        .foregroundColor(AppColors.lightCyan)
                }
            }
            .activitySystemActionForegroundColor(Color.black)
        }
}
