import SwiftUI

struct Onboarding_BenefitsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Onboarding BenefitsView").font(.largeTitle.bold())
            Text("Onboarding akışı ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
