import SwiftUI

struct Shop_OrderSummaryView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Shop OrderSummaryView").font(.largeTitle.bold())
            Text("Mağaza ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
