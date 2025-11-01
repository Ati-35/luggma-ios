import SwiftUI

#if DEBUG
struct DebugTag: ViewModifier {
    let name: String

    func body(content: Content) -> some View {
        content.overlay(alignment: .topLeading) {
            Text(name)
                .font(.caption2.bold())
                .padding(4)
                .background(Color.yellow.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                .allowsHitTesting(false)
        }
    }
}

extension View {
    func debugTag(_ name: String) -> some View {
        modifier(DebugTag(name: name))
    }
}
#else
extension View {
    func debugTag(_ name: String) -> some View { self }
}
#endif
