import SwiftUI

struct Community_CommentsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Community CommentsView").font(.largeTitle.bold())
            Text("Topluluk ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
