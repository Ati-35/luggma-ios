import SwiftUI

struct Story_EditorView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Story EditorView").font(.largeTitle.bold())
            Text("Story ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
