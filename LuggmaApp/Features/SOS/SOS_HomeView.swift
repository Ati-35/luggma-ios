import SwiftUI

struct SOS_HomeView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("SOS HomeView").font(.largeTitle.bold())
            Text("Kriz anı ana ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
