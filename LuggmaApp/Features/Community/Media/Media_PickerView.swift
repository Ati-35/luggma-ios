import SwiftUI

struct Media_PickerView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Media PickerView").font(.largeTitle.bold())
            Text("Medya ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
