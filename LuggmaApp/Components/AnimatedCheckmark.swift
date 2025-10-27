import SwiftUI
import UIKit

struct AnimatedCheckmark: View {
    @Binding var checked: Bool
    var body: some View {
        ZStack {
            Circle().strokeBorder(Color.secondary.opacity(0.3), lineWidth: 2).frame(width: 28, height: 28)
            if checked {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 28))
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .onChange(of: checked) { _ in
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred()
        }
    }
}
