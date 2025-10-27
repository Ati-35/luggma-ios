import SwiftUI

struct Story_ViewerView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Story ViewerView").font(.largeTitle.bold())
            Text("Story ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
