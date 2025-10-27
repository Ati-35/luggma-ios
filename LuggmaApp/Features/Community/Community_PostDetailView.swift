import SwiftUI

struct Community_PostDetailView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Community PostDetailView").font(.largeTitle.bold())
            Text("Topluluk ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
