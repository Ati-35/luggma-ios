import SwiftUI

struct Story_CameraView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Story CameraView").font(.largeTitle.bold())
            Text("Story ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
