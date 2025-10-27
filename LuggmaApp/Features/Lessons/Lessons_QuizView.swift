import SwiftUI

struct Lessons_QuizView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Lessons QuizView").font(.largeTitle.bold())
            Text("Ders ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
