import SwiftUI

struct SOS_DistractionCardsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("SOS DistractionCardsView").font(.largeTitle.bold())
            Text("Dikkat dağıtma").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
