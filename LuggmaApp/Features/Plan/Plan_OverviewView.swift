import SwiftUI

struct Plan_OverviewView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Plan OverviewView").font(.largeTitle.bold())
            Text("Plan ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
