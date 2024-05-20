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
    
    @State private var isLiveActivityActive = UserDefaults.standard.bool(forKey: "LiveActivityActive")
    
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .onChange(of: scenePhase, { oldValue, newValue in
            handleScenePhaseChange(to: newValue)
        })
    }
    
    private func handleScenePhaseChange(to newValue: ScenePhase) {
        switch newValue {
        case .active:
            endLiveActiviy()
        case .inactive:
            print("Inactive")
        case .background:
            startLiveActivity()
        default:
            print("scenePhase error")
        }
    }


    private func endLiveActiviy() {
        print("Active - \(isLiveActivityActive)")
        if isLiveActivityActive {
            EmergencyLiveActivityManager.shared.endAllActivities()
            isLiveActivityActive = false
            UserDefaults.standard.setValue(false, forKey: "LiveActivityActive")
        }
    }

    private func startLiveActivity() {
        print("Background")
        if !isLiveActivityActive {
            EmergencyLiveActivityManager.shared.startActivity(
                title: Strings.LiveActivityView.title,
                firstSubtitle: Strings.LiveActivityView.firstSubtitle,
                secondSubtitle: Strings.LiveActivityView.secodSubtitle)
            isLiveActivityActive = true
            UserDefaults.standard.setValue(true, forKey: "LiveActivityActive")
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // 앱 종료되는 시점 감지
    func applicationWillTerminate(_ application: UIApplication) {
        
        EmergencyLiveActivityManager.shared.endAllActivities()
        UserDefaults.standard.setValue(false, forKey: "LiveActivityActive")
        
    }
}
