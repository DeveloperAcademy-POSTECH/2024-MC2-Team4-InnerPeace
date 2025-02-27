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
    var progressTimer: Timer?
    
    @Environment(\.scenePhase) var scenePhase
    @Published var isLiveActivityRunning = false
    
    private init() {}
    
    func startActivity(title: String, firstSubtitle: String, secondSubtitle: String, isPresented: Binding<Bool>, duration: Int) {
        let attributes = EmergencyLiveActivityAttributes(title: title, firstSubtitle: firstSubtitle, secondSubtitle: secondSubtitle)
        let initialContentState = EmergencyLiveActivityAttributes.ContentState(progress: 0.0)
        
        if !isLiveActivityRunning {
            do {
                activity = try Activity<EmergencyLiveActivityAttributes>.request(
                    attributes: attributes,
                    contentState: initialContentState,
                    pushType: nil
                )
                print("Started Live Activity with ID: \(activity?.id ?? "unknown")")
            
                startProgressUpdates(isPresented: isPresented, duration: duration)
                isLiveActivityRunning = true
            } catch {
                print("Failed to start Live Activity: \(error.localizedDescription)")
            }
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
                timer.invalidate()
                self.progressTimer = nil
                isPresented.wrappedValue = true
                return
            }
            
            currentProgress += progressIncrement
            self.updateActivity(progress: currentProgress)
        }
    }
    
    func endTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
        updateActivity(progress: 1.0)
    }

    
    func endActivity(activity: Activity<EmergencyLiveActivityAttributes>) {
        let content = EmergencyLiveActivityAttributes.ContentState(progress: 1.0)

        Task {
            await activity.end(using: content, dismissalPolicy: .immediate)
            print("Ended Live Activity with ID: \(activity.id)")
        }
    }
    
    func endAllActivities() {
        endTimer()
        
        for activity in Activity<EmergencyLiveActivityAttributes>.activities {
            endActivity(activity: activity)
        }
        
        isLiveActivityRunning = false
    }
    
    func updateActivity(progress: Double) {
        guard let activity = activity else {
            print("No active Live Activity to update.")
            return
        }

        let updatedContentState = EmergencyLiveActivityAttributes.ContentState(progress: progress)
        print("Updating Dynamic Island with progress: \(progress)")

        Task {
            await activity.update(using: updatedContentState)
            print("Updated Dynamic Island with progress.")
        }
    }
}
