import SwiftUI

enum DS {
    static let cornerRadius: CGFloat = 16
    static let spacing: CGFloat = 16
}

struct GradientBackground: View {
    var body: some View {
        LinearGradient(colors: [.black.opacity(0.95), .black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct HeroHeader: View {
    var title: String
    var subtitle: String
    var gradient: LinearGradient
    
    @State private var animate = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(.ultraThinMaterial)
                .overlay(gradient.opacity(0.25).blendMode(.plusLighter))
                .overlay(
                    RoundedRectangle(cornerRadius: 28).strokeBorder(gradient, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 16)
                .padding(.horizontal)
                .frame(height: 180)
                .overlay(
                    VStack(alignment: .leading, spacing: 8) {
                        Text(title).font(.system(size: 34, weight: .bold, design: .rounded))
                        Text(subtitle).font(.headline).foregroundStyle(.secondary)
                    }
                    .padding()
                    , alignment: .leading
                )
                .overlay(
                    Circle()
                        .fill(gradient)
                        .blur(radius: 40)
                        .opacity(0.6)
                        .scaleEffect(animate ? 1.2 : 0.9)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animate)
                        .offset(x: 120, y: -50)
                )
        }
        .onAppear { animate = true }
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
        .overlay(RoundedRectangle(cornerRadius: DS.cornerRadius).stroke(.white.opacity(0.15)))
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
