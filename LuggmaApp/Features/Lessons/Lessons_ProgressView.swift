import SwiftUI

struct Lessons_ProgressView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Lessons ProgressView").font(.largeTitle.bold())
            Text("Ders ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
