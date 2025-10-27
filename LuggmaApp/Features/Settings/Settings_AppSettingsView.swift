import SwiftUI

struct Settings_AppSettingsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Settings AppSettingsView").font(.largeTitle.bold())
            Text("Ayarlar ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
