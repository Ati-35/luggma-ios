import SwiftUI

struct Shop_CartView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Shop CartView").font(.largeTitle.bold())
            Text("Mağaza ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
