import SwiftUI

final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    func push(_ route: AppRoute) { path.append(route) }
    func pop() { path.removeLast() }
    func popToRoot() { path = NavigationPath() }
}

enum AppRoute: Hashable {
    case onboarding
    case home
    case lessons
    case sos
    case community
    case shop
    case profile
}
