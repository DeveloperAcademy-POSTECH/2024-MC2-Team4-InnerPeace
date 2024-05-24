//
//  LiveActivityManager.swift
//  SumSumZip
//
//  Created by 신승아 on 5/17/24.
//

import ActivityKit
import SwiftUI

class EmergencyLiveActivityManager {
    
    static let shared = EmergencyLiveActivityManager()
    private var activity: Activity<EmergencyLiveActivityAttributes>?
    private var progressTimer: Timer?
    
    @Environment(\.scenePhase) var scenePhase
    
    private init() {}
    
    func startActivity(title: String, firstSubtitle: String, secondSubtitle: String, isPresented: Binding<Bool>, duration: Int) {
        let attributes = EmergencyLiveActivityAttributes(title: title, firstSubtitle: firstSubtitle, secondSubtitle: secondSubtitle)
        let initialContentState = EmergencyLiveActivityAttributes.ContentState(progress: 0.0)

        do {
            activity = try Activity<EmergencyLiveActivityAttributes>.request(
                attributes: attributes,
                contentState: initialContentState,
                pushType: nil
            )
            print("Started Live Activity with ID: \(activity?.id ?? "unknown")")
            
            startProgressUpdates(isPresented: isPresented, duration: duration)
        } catch {
            print("Failed to start Live Activity: \(error.localizedDescription)")
        }
    }
    
    func startProgressUpdates(isPresented: Binding<Bool>, duration: Int) {
        progressTimer?.invalidate()
        var currentProgress: Double = 0.0
        let duration: Double = Double(duration) // Duration in seconds
        let updateInterval: Double = 0.1 // Timer interval in seconds
        let progressIncrement = updateInterval / duration // Calculate the increment based on the desired duration
        
        progressTimer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { timer in
            guard currentProgress < 1.0 else {
//                self.endAllActivities()
                timer.invalidate()
                isPresented.wrappedValue = true
                
                return
            }
            
            currentProgress += progressIncrement
            self.updateActivity(progress: currentProgress)
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
        progressTimer?.invalidate()
        
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
        print("Updated Dynamic Island with progress: \(progress)")

        Task {
            await activity.update(using: updatedContentState)
            print("Updated Dynamic Island with progress.")
        }
    }
}
