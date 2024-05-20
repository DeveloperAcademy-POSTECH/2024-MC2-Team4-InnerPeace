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
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EmergencyLiveActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            commonView(context: context, isForDynamicIsland: false)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here
                DynamicIslandExpandedRegion(.leading) {

                }
                DynamicIslandExpandedRegion(.trailing) {

                }
                DynamicIslandExpandedRegion(.bottom) {
                    commonView(context: context, isForDynamicIsland: true)
                }
            } compactLeading: {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(AppColors.lightCyan)
            } compactTrailing: {
                CircularProgressView(progress: 1)
            } minimal: {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
    
    private func commonView(context: ActivityViewContext<EmergencyLiveActivityAttributes>, isForDynamicIsland: Bool) -> some View {
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
