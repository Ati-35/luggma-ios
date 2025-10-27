import SwiftUI

struct Media_UploadProgressView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Media UploadProgressView").font(.largeTitle.bold())
            Text("Medya ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
