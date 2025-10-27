import SwiftUI

struct SOS_ReframeView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("SOS ReframeView").font(.largeTitle.bold())
            Text("Yeniden çerçeveleme").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
