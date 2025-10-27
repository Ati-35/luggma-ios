import SwiftUI

struct Analytics_ProgressChartsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Analytics ProgressChartsView").font(.largeTitle.bold())
            Text("Analitik ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
