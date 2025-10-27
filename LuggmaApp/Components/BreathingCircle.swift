import SwiftUI

struct BreathingCircle: View {
    @State private var scale: CGFloat = 0.9
    var body: some View {
        ZStack {
            Circle().fill(.blue.opacity(0.25)).frame(width: 220, height: 220).blur(radius: 24)
            Circle().strokeBorder(.blue, lineWidth: 4).frame(width: 220, height: 220)
        }
        .scaleEffect(scale)
        .onAppear {
            withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
                scale = 1.1
            }
        }
    }
}
