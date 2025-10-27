import SwiftUI

struct Lessons_SectionListView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Lessons SectionListView").font(.largeTitle.bold())
            Text("Ders ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
