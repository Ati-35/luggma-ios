import SwiftUI

struct Location_PermissionView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Location PermissionView").font(.largeTitle.bold())
            Text("Konum ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
