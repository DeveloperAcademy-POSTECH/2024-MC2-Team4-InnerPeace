//
//  LiveActivityManager.swift
//  SumSumZip
//
//  Created by 신승아 on 5/17/24.
//

import ActivityKit
import Foundation

/// LiveActivity의 Start/Update/End를 관리하는 매니저
class EmergencyLiveActivityManager {
    
    static let shared = EmergencyLiveActivityManager()
    private var activity: Activity<EmergencyLiveActivityAttributes>?
    
    private init() {}
    
    func startActivity(name: String, emoji: String) {
        let attributes = EmergencyLiveActivityAttributes(name: name)
        let initialContentState = EmergencyLiveActivityAttributes.ContentState(emoji: emoji)

        do {
            activity = try Activity<EmergencyLiveActivityAttributes>.request(
                attributes: attributes,
                contentState: initialContentState,
                pushType: nil
            )
            print("Started Live Activity with ID: \(activity?.id ?? "unknown")")
        } catch {
            print("Failed to start Live Activity: \(error.localizedDescription)")
        }
    }
    
    func updateActivity(emoji: String) {
        guard let activity = activity else {
            print("No active Live Activity to update.")
            return
        }

        let updatedContentState = EmergencyLiveActivityAttributes.ContentState(emoji: emoji)

        Task {
            await activity.update(using: updatedContentState)
            print("Updated Live Activity with new emoji.")
        }
    }
    
    func endActivity() {
        guard let activity = activity else {
            print("No active Live Activity to end.")
            return
        }

        Task {
            await activity.end(dismissalPolicy: .immediate)
            print("Ended Live Activity.")
            self.activity = nil
        }
    }
}
