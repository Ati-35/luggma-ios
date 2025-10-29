import SwiftUI
import UIKit

enum DS {
    static let cornerRadius: CGFloat = 16
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
    var title: String
    var subtitle: String
    var imageName: String?

    private func resolvedImage() -> Image? {
        guard let name = imageName, let uiImage = UIImage(named: name) else { return nil }
        return Image(uiImage: uiImage)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(.ultraThinMaterial)
                .background(
                    LinearGradient(colors: [.mint.opacity(0.9), .blue.opacity(0.8)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .overlay(Color.black.opacity(0.08))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(LinearGradient(colors: [.white.opacity(0.25), .white.opacity(0.05)],
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 16)
                .padding(.horizontal)
                .frame(height: 220)
                .overlay(contentOverlay)
        }
    }

    @ViewBuilder
    private var contentOverlay: some View {
        if let image = resolvedImage() {
            image
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 28))
        } else {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.85))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
}

struct GlassCard: View {
    var icon: String; var title: String; var subtitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon).font(.system(size: 28))
            Text(title).font(.headline)
            Text(subtitle).font(.caption).foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: DS.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: DS.cornerRadius)
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
