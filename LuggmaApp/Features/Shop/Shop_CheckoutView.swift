import SwiftUI

struct Shop_CheckoutView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Shop CheckoutView").font(.largeTitle.bold())
            Text("Mağaza ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
