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
    
    func startActivity(title: String, firstSubtitle: String, secondSubtitle: String) {
        let attributes = EmergencyLiveActivityAttributes(title: title, firstSubtitle: firstSubtitle, secondSubtitle: secondSubtitle)
        let initialContentState = EmergencyLiveActivityAttributes.ContentState(progress: 0.0)

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
    
    func endActivity(activity: Activity<EmergencyLiveActivityAttributes>) {
        let content = EmergencyLiveActivityAttributes.ContentState(progress: 1.0)

            Task {
                await activity.end(using: content, dismissalPolicy: .immediate)
                print("Ended Live Activity with ID: \(activity.id)")
            }
        }
    
    func endAllActivities() {
        for activity in Activity<EmergencyLiveActivityAttributes>.activities {
            endActivity(activity: activity)
        }
    }
    
    func updateActivity(progress: Double) {
        guard let activity = activity else {
            print("No active Live Activity to update.")
            return
        }

        let updatedContentState = EmergencyLiveActivityAttributes.ContentState(progress: progress)

        Task {
            await activity.update(using: updatedContentState)
            print("Updated Live Activity with new emoji.")
        }
    }
}
