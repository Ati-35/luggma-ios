import SwiftUI

struct Onboarding_WelcomeView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Onboarding WelcomeView").font(.largeTitle.bold())
            Text("Onboarding akışı ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
