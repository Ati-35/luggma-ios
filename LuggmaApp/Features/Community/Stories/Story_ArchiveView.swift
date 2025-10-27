import SwiftUI

struct Story_ArchiveView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Story ArchiveView").font(.largeTitle.bold())
            Text("Story ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
