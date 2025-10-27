import SwiftUI

struct SOS_CompleteView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("SOS CompleteView").font(.largeTitle.bold())
            Text("Tamamlama").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
