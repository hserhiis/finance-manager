import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@main
struct finance_managerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var globalState: GlobalState = GlobalState()

    init() {
        // Ensure Firebase is configured at the earliest point possible
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalState)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // FirebaseApp.configure() is called in the @main struct's initializer
        // Adjust Firestore settings
        return true
    }
}
