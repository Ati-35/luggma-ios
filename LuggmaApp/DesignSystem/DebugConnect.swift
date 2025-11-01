#if DEBUG
import SwiftUI

struct DebugLink: Hashable {
    let from: String
    let to: String
}

// MARK: - Preference storage for view anchors
private struct DebugAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]

    static func reduce(value: inout [String: Anchor<CGRect>],
                       nextValue: () -> [String: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

// MARK: - View helpers
extension View {
    /// Marks this view with an identifier so its frame can be used for debug connections.
    func debugAnchor(_ id: String) -> some View {
        anchorPreference(key: DebugAnchorKey.self, value: .bounds) { [id: $0] }
    }

    /// Draws connections between anchors; when `selection` set, only links touching it are rendered.
    func debugConnect(selection: String? = nil, links: [DebugLink]) -> some View {
        overlayPreferenceValue(DebugAnchorKey.self) { anchors in
            DebugLinksLayer(anchors: anchors, links: links, selection: selection)
                .allowsHitTesting(false)
        }
    }
}

// MARK: - Rendering layer
private struct DebugLinksLayer: View {
    let anchors: [String: Anchor<CGRect>]
    let links: [DebugLink]
    let selection: String?

    var body: some View {
        GeometryReader { proxy in
            let activeLinks = selection.flatMap { selected in
                let filtered = links.filter { $0.from == selected || $0.to == selected }
                return filtered.isEmpty ? links : filtered
            } ?? links

            Path { path in
                for link in activeLinks {
                    guard let source = anchors[link.from],
                          let target = anchors[link.to] else { continue }

                    let rectA = proxy[source]
                    let rectB = proxy[target]

                    let start = CGPoint(x: rectA.midX, y: rectA.maxY)
                    let end = CGPoint(x: rectB.midX, y: rectB.minY)
                    let midY = (start.y + end.y) / 2

                    path.move(to: start)
                    path.addCurve(
                        to: end,
                        control1: CGPoint(x: start.x, y: midY),
                        control2: CGPoint(x: end.x, y: midY)
                    )
                }
            }
            .stroke(
                Color.red,
                style: StrokeStyle(
                    lineWidth: 2,
                    lineCap: .round,
                    lineJoin: .round,
                    dash: [6, 4]
                )
            )
            .shadow(color: .red.opacity(0.4), radius: 2)
        }
    }
}
#else
import SwiftUI

struct DebugLink: Hashable {
    let from: String
    let to: String
}

extension View {
    func debugAnchor(_ id: String) -> some View { self }
    func debugConnect(selection: String? = nil, links: [DebugLink]) -> some View { self }
}
#endif
