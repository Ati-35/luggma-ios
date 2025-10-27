import SwiftUI

struct Plan_WeeklyReportView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Plan WeeklyReportView").font(.largeTitle.bold())
            Text("Plan ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
