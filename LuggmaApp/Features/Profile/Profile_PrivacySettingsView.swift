import SwiftUI

struct Profile_PrivacySettingsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Profile PrivacySettingsView").font(.largeTitle.bold())
            Text("Profil ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
