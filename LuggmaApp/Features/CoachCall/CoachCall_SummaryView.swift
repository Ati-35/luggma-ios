import SwiftUI

struct CoachCall_SummaryView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("CoachCall SummaryView").font(.largeTitle.bold())
            Text("Koç araması ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
