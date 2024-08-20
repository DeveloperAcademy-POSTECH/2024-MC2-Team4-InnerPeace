//
//  SumSumZipApp.swift
//  SumSumZip
//
//  Created by 신승아 on 5/14/24.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct SumSumZipApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true

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

            OnboardingView(isPresented: $isPresented)
                .onOpenURL { url in
                    
                    print("Received URL: \(url.absoluteString)")
                    print("Path components: \(url.pathComponents)")
                    
                    if url.host(percentEncoded: true) == "target" {
                        
                        NotificationCenter.default.post(name: NSNotification.Name("NavigateToTargetView"), object: nil)
                        print("앱 첫 화면에서 위젯 눌렸는지 분기 확인")
                    } else {
                        print("URL에 target이 포함되어 있지 않음")
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Firebase 초기 설정
        FirebaseApp.configure()

        return true
      }
    
    func applicationWillTerminate(_ application: UIApplication) {
        EmergencyLiveActivityManager.shared.endAllActivities()
    }
}

