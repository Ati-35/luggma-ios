import SwiftUI

struct Community_SearchView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Community SearchView").font(.largeTitle.bold())
            Text("Topluluk ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
