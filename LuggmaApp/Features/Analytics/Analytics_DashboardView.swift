import SwiftUI

struct Analytics_DashboardView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Analytics DashboardView").font(.largeTitle.bold())
            Text("Analitik ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
