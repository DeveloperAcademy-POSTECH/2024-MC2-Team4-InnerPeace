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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .onChange(of: scenePhase, { oldValue, newValue in
            switch newValue {
            case .active:
                print("Active")
                EmergencyLiveActivityManager.shared.endActivity()
            case .inactive:
                print("Inactive")
            case .background:
                print("Background")
                EmergencyLiveActivityManager.shared.startActivity(name: "안녕", emoji: "이너피스")
            default:
                print("scenePhase err")
            }
        })
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationWillTerminate(_ application: UIApplication) {
        // 앱이 종료될 때 호출
        print("Appdelegate applicationwillTerminate")
        EmergencyLiveActivityManager.shared.endActivity()
    }
}
