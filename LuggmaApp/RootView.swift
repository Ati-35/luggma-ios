import SwiftUI

struct RootView: View {
    @EnvironmentObject var router: AppRouter
    var body: some View {
        NavigationStack(path: $router.path) {
            AppTabView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .onboarding: Onboarding_WelcomeView()
                    case .home: HomeView()
                    case .lessons: Lessons_HomeView()
                    case .sos: SOS_HomeView()
                    case .community: Community_FeedView()
                    case .shop: Shop_HomeView()
                    case .profile: Profile_HomeView()
                    }
                }
        }
    }
}
