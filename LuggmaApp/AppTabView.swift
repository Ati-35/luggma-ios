import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Ana", systemImage: "house.fill") }
            Lessons_HomeView()
                .tabItem { Label("Dersler", systemImage: "book.fill") }
            SOS_HomeView()
                .tabItem { Label("SOS", systemImage: "heart.text.square.fill") }
            Community_FeedView()
                .tabItem { Label("Topluluk", systemImage: "person.3.fill") }
            Shop_HomeView()
                .tabItem { Label("Mağaza", systemImage: "bag.fill") }
            Profile_HomeView()
                .tabItem { Label("Profil", systemImage: "person.crop.circle") }
        }
    }
}
