import SwiftUI

@main
struct LuggmaApp: App {
    @StateObject private var router = AppRouter()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
                .preferredColorScheme(nil)
        }
    }
}
