import SwiftUI

struct Settings_ThemePickerView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Settings ThemePickerView").font(.largeTitle.bold())
            Text("Ayarlar ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
