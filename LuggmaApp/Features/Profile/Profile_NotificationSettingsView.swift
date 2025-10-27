import SwiftUI

struct Profile_NotificationSettingsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Profile NotificationSettingsView").font(.largeTitle.bold())
            Text("Profil ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
