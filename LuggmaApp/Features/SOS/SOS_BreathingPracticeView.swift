import SwiftUI

struct SOS_BreathingPracticeView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Nefes")
                .font(.largeTitle.bold())
            BreathingCircle()
            Text("4 sn nefes al • 4 sn tut • 4 sn ver").foregroundStyle(.secondary)
        }
        .padding()
        .background(GradientBackground())
    }
}
