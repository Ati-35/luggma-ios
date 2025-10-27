import SwiftUI

struct Lessons_SearchView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Lessons SearchView").font(.largeTitle.bold())
            Text("Ders ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
