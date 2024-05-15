//
//  EmergencyLiveActivityLiveActivity.swift
//  EmergencyLiveActivity
//
//  Created by 신승아 on 5/15/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct EmergencyLiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct EmergencyLiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: EmergencyLiveActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension EmergencyLiveActivityAttributes {
    fileprivate static var preview: EmergencyLiveActivityAttributes {
        EmergencyLiveActivityAttributes(name: "World")
    }
}

extension EmergencyLiveActivityAttributes.ContentState {
    fileprivate static var smiley: EmergencyLiveActivityAttributes.ContentState {
        EmergencyLiveActivityAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: EmergencyLiveActivityAttributes.ContentState {
         EmergencyLiveActivityAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: EmergencyLiveActivityAttributes.preview) {
   EmergencyLiveActivityLiveActivity()
} contentStates: {
    EmergencyLiveActivityAttributes.ContentState.smiley
    EmergencyLiveActivityAttributes.ContentState.starEyes
}
