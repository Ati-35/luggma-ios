import SwiftUI

@_silgen_name("LookinStart") func LookinStart()

@main
struct LuggmaApp: App {
    @StateObject private var router = AppRouter()
    @StateObject private var theme = LiveTheme()

    init() {
        #if DEBUG
        LookinStart()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
                .environment(\.liveTheme, theme)
        }
    }
}
