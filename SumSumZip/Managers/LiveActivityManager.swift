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
    private var imgTimer: Timer?
    private let images = ["SOS_1", "SOS_2", "SOS_3"]
    private var currentIndex = 0
    
    private init() {}
    
    func startActivity(title: String, firstSubtitle: String, secondSubtitle: String, isPresented: Binding<Bool>) {
        let attributes = EmergencyLiveActivityAttributes(title: title, firstSubtitle: firstSubtitle, secondSubtitle: secondSubtitle)
        let initialContentState = EmergencyLiveActivityAttributes.ContentState(progress: 0.0, imageName: images[currentIndex])

        do {
            activity = try Activity<EmergencyLiveActivityAttributes>.request(
                attributes: attributes,
                contentState: initialContentState,
                pushType: nil
            )
            print("Started Live Activity with ID: \(activity?.id ?? "unknown")")
            
            startProgressUpdates(isPresented: isPresented)
            startImageUpdates()
        } catch {
            print("Failed to start Live Activity: \(error.localizedDescription)")
        }
    }
    
    func startProgressUpdates(isPresented: Binding<Bool>) {
        progressTimer?.invalidate()
        var currentProgress: Double = 0.0
        let duration: Double = 30.0 // Duration in seconds
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
            self.updateActivity(progress: currentProgress, imgName: nil)
        }
    }
    
    func startImageUpdates() {
        imgTimer?.invalidate()
        
        imgTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.changeImgInx()
        }
    }

    func changeImgInx() {
        currentIndex = (currentIndex + 1) % images.count
        print("🍎 변경된 이미지: \(images[currentIndex])")
        self.updateActivity(progress: nil, imgName: images[currentIndex])
    }
    
    func updateActivity(progress: Double?, imgName: String?) {
        guard let activity = activity else {
            print("No active Live Activity to update.")
            return
        }

        let currentState = activity.contentState ?? EmergencyLiveActivityAttributes.ContentState(progress: 0.0, imageName: images[currentIndex])
        
        let updatedProgress = progress ?? currentState.progress
        let updatedImageName = imgName ?? currentState.imageName
        
        let updatedContentState = EmergencyLiveActivityAttributes.ContentState(progress: updatedProgress, imageName: updatedImageName)
        print("Updated Dynamic Island with progress: \(String(describing: updatedProgress)), imageName: \(String(describing: updatedImageName))")

        Task {
            await activity.update(using: updatedContentState)
            print("Updated Dynamic Island with new content state.")
        }
    }
    
    func endActivity(activity: Activity<EmergencyLiveActivityAttributes>) {
        let content = EmergencyLiveActivityAttributes.ContentState(progress: 1.0, imageName: "SOS_1")

        Task {
            await activity.end(using: content, dismissalPolicy: .immediate)
            print("Ended Live Activity with ID: \(activity.id)")
        }
    }
    
    func endAllActivities() {
        progressTimer?.invalidate()
        imgTimer?.invalidate()
        
        for activity in Activity<EmergencyLiveActivityAttributes>.activities {
            endActivity(activity: activity)
        }
    }
}
