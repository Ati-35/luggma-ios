import SwiftUI
import UIKit

final class LiveTheme: ObservableObject {
    @Published var cardCorner: CGFloat = 16
    @Published var headerHeight: CGFloat = 220

    /// Component specific overrides keyed by inspector ID.
    private var cornerOverrides: [String: CGFloat] = [:]
    private var colorOverrides: [String: Color] = [:]

    func cornerRadius(for componentID: String, default defaultValue: CGFloat? = nil) -> CGFloat {
        if let override = cornerOverrides[componentID] {
            return override
        }
        if let fallback = defaultValue {
            return fallback
        }
        return cardCorner
    }

    func setCornerRadius(_ value: CGFloat, for componentID: String) {
        guard cornerOverrides[componentID] != value else { return }
        objectWillChange.send()
        cornerOverrides[componentID] = value
    }

    func resetCornerRadius(for componentID: String) {
        guard cornerOverrides.removeValue(forKey: componentID) != nil else { return }
        objectWillChange.send()
    }

    func color(for componentID: String, default defaultValue: Color) -> Color {
        colorOverrides[componentID] ?? defaultValue
    }

    func setColor(_ value: Color, for componentID: String) {
        guard colorOverrides[componentID] != value else { return }
        objectWillChange.send()
        colorOverrides[componentID] = value
    }

    func resetColor(for componentID: String) {
        guard colorOverrides.removeValue(forKey: componentID) != nil else { return }
        objectWillChange.send()
    }
}

private struct LiveThemeKey: EnvironmentKey {
    static let defaultValue = LiveTheme()
}

extension EnvironmentValues {
    var liveTheme: LiveTheme {
        get { self[LiveThemeKey.self] }
        set { self[LiveThemeKey.self] = newValue }
    }
}

enum DS {
    static let spacing: CGFloat = 16
}

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(red: 0.98, green: 0.25, blue: 0.47), location: 0.0),
                .init(color: Color(red: 0.99, green: 0.6, blue: 0.23), location: 0.25),
                .init(color: Color(red: 0.96, green: 0.83, blue: 0.55), location: 0.45),
                .init(color: Color(red: 0.44, green: 0.87, blue: 0.75), location: 0.65),
                .init(color: Color(red: 0.26, green: 0.74, blue: 0.86), location: 0.85),
                .init(color: Color(red: 0.35, green: 0.84, blue: 0.63), location: 1.0)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
            .ignoresSafeArea()
    }
}

struct HeroHeader: View {
    @Environment(\.liveTheme) private var theme
    var title: String
    var subtitle: String
    var imageName: String?
    private var cornerRadius: CGFloat {
        theme.cornerRadius(for: "HERO_HEADER", default: theme.cardCorner)
    }

    private func resolvedImage() -> Image? {
        guard let name = imageName, let uiImage = UIImage(named: name) else { return nil }
        return Image(uiImage: uiImage)
    }

    var body: some View {
        ZStack {}
            .frame(height: theme.headerHeight)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(colors: [.white.opacity(0.25), .white.opacity(0.05)],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing),
                        lineWidth: 1
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .padding(.horizontal)
    }
}

struct GlassCard: View {
    @Environment(\.liveTheme) private var theme
    var icon: String; var title: String; var subtitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon).font(.system(size: 28))
            Text(title).font(.headline)
            Text(subtitle).font(.caption).foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: theme.cardCorner))
        .overlay(
            RoundedRectangle(cornerRadius: theme.cardCorner)
                .stroke(
                    LinearGradient(colors: [.mint.opacity(0.6), .blue.opacity(0.45)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing),
                    lineWidth: 1.2
                )
                .shadow(color: .blue.opacity(0.25), radius: 14, x: 0, y: 8)
                .blendMode(.plusLighter)
        )
    }
}

struct PrimaryButton: View {
    var title: String; var action: () -> Void
    @State private var shining = false
    var body: some View {
        Button(action: action) {
            Text(title).font(.headline).padding(.vertical, 14).frame(maxWidth: .infinity)
                .background(
                    LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing)
                )
                .overlay(
                    Rectangle()
                        .fill(LinearGradient(colors: [.white.opacity(0.6), .clear],
                                             startPoint: .leading, endPoint: .trailing))
                        .mask(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(lineWidth: 8)
                                .offset(x: shining ? 180 : -180)
                        )
                        .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: false), value: shining)
                )
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .onAppear { shining = true }
    }
}

struct ShimmerView: View {
    @State private var phase: CGFloat = -1
    var body: some View {
        Rectangle()
            .fill(.gray.opacity(0.25))
            .overlay(
                LinearGradient(colors: [.clear, .white.opacity(0.45), .clear],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .rotationEffect(.degrees(20))
                    .offset(x: phase * 300)
            )
            .onAppear { withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) { phase = 1 } }
    }
}
