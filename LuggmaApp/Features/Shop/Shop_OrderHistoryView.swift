import SwiftUI

struct Shop_OrderHistoryView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Shop OrderHistoryView").font(.largeTitle.bold())
            Text("Mağaza ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
