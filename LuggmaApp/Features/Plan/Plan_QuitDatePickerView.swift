import SwiftUI

struct Plan_QuitDatePickerView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Plan QuitDatePickerView").font(.largeTitle.bold())
            Text("Plan ekranı").foregroundStyle(.secondary)
            PrimaryButton(title: "Devam") { }
                .padding(.horizontal)
        }
        .padding()
        .background(GradientBackground())
    }
}
