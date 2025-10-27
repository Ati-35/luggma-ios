import SwiftUI

struct Profile_BadgesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Profile BadgesView").font(.largeTitle.bold())
            Text("Profil ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
