//
//  SumSumZipApp.swift
//  SumSumZip
//
//  Created by 신승아 on 5/14/24.
//

import SwiftUI
import SwiftData

@main
struct SumSumZipApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SummaryView()
        }
        .modelContainer(sharedModelContainer)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationWillTerminate(_ application: UIApplication) {
        EmergencyLiveActivityManager.shared.endAllActivities()
    }
}

