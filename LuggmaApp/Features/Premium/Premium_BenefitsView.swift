import SwiftUI

struct Premium_BenefitsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Premium BenefitsView").font(.largeTitle.bold())
            Text("Premium ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
