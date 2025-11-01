#if DEBUG
import SwiftUI

private struct DebugLayoutPathKey: EnvironmentKey {
    static let defaultValue: [String] = []
}

extension EnvironmentValues {
    var debugLayoutPath: [String] {
        get { self[DebugLayoutPathKey.self] }
        set { self[DebugLayoutPathKey.self] = newValue }
    }
}

struct DebugLayoutRecorder: ViewModifier {
    @Environment(\.debugLayoutPath) private var path
    let name: String

    func body(content: Content) -> some View {
        content
            .background(Recorder(path: path, name: name))
            .environment(\.debugLayoutPath, path + [name])
    }

    private struct Recorder: View {
        let path: [String]
        let name: String
        @State private var didLog = false

        var body: some View {
            Color.clear
                .onAppear {
                    guard !didLog else { return }
                    didLog = true
                    let fullPath = (path + [name]).joined(separator: " → ")
                    debugPrint("🧭 [Layout]", fullPath)
                }
        }
    }
}

extension View {
    /// Prints the layout path (e.g. "Root → Stack → ProgressView") once when the view appears.
    func debugLayout(_ name: String) -> some View {
        modifier(DebugLayoutRecorder(name: name))
    }
}
#else
import SwiftUI

extension View {
    func debugLayout(_ name: String) -> some View { self }
}
#endif
