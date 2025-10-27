import SwiftUI

struct Plan_TaskListView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Plan TaskListView").font(.largeTitle.bold())
            Text("Plan ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
