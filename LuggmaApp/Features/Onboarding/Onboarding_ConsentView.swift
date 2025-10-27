import SwiftUI

struct Onboarding_ConsentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Onboarding ConsentView").font(.largeTitle.bold())
            Text("Onboarding akışı ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
