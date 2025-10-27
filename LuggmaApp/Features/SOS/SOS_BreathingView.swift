import SwiftUI

struct SOS_BreathingView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("SOS BreathingView").font(.largeTitle.bold())
            Text("Nefes egzersizi").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
