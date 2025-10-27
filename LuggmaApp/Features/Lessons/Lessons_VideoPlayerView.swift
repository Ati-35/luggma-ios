import SwiftUI

struct Lessons_VideoPlayerView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Lessons VideoPlayerView").font(.largeTitle.bold())
            Text("Ders ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
