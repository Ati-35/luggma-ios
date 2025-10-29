import SwiftUI

struct HomeView: View {
    private let videoItems: [VideoItem] = [
        .init(title: "Nefes Tekniği", subtitle: "4-7-8 metodunu uygulayalım", icon: "lungs.fill", gradient: [.pink.opacity(0.8), .orange.opacity(0.7)]),
        .init(title: "Kriz Anı", subtitle: "Koçtan hızlı destek ipuçları", icon: "bolt.heart.fill", gradient: [.purple.opacity(0.7), .indigo.opacity(0.8)]),
        .init(title: "Hareket Molası", subtitle: "3 dakikalık esneme rutini", icon: "figure.cooldown", gradient: [.mint.opacity(0.7), .blue.opacity(0.8)]),
        .init(title: "Beslenme Tüyosu", subtitle: "Nikotin isteğini azaltan atıştırmalıklar", icon: "leaf.fill", gradient: [.green.opacity(0.8), .yellow.opacity(0.7)]),
        .init(title: "Topluluk Hikayesi", subtitle: "Bugün bırakmayı başaran Tuğçe’yi dinle", icon: "person.3.sequence.fill", gradient: [.orange.opacity(0.8), .red.opacity(0.7)]),
        .init(title: "Mindfulness", subtitle: "2 dakikalık odaklanma egzersizi", icon: "brain.head.profile", gradient: [.cyan.opacity(0.8), .teal.opacity(0.8)])
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HeroHeader(title: "Merhaba!",
                           subtitle: "Bugün duman yok FENAYIZ 💪",
                           imageName: "HeroPlaceholder")
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            LinearGradient(colors: [.mint.opacity(0.65), .blue.opacity(0.45)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing),
                            lineWidth: 1.4
                        )
                        .shadow(color: .blue.opacity(0.25), radius: 16, x: 0, y: 10)
                        .blendMode(.plusLighter)
                    HStack(spacing: 12) {
                        GlassCard(icon: "play.circle.fill", title: "Devam Et", subtitle: "Son ders")
                        GlassCard(icon: "heart.text.square.fill", title: "SOS", subtitle: "Kriz anı yardımı")
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                }
                .padding(.horizontal)
                SectionHeader("Görevler")
                TaskRow(title: "5 dk nefes egzersizi", icon: "wind")
                TaskRow(title: "‘Tetikleyiciler’ videosunu izle", icon: "play.rectangle")
                TaskRow(title: "Bugün İçin Böyle Dikkat Edelim", icon: "exclamationmark.triangle")

                SectionHeader("Motivasyon")
                TaskRow(title: "Toplulukta paylaşım yap", icon: "bubble.left.and.exclamationmark")
                TaskRow(title: "Koç notlarını oku", icon: "book.closed")
                TaskRow(title: "Su içmeyi unutma", icon: "drop")

                VideoSectionView(items: videoItems)
            }
        }
        .background(GradientBackground())
    }
}

struct SectionHeader: View {
    var text: String
    var color: Color?

    init(_ text: String, color: Color? = nil) {
        self.text = text
        self.color = color
    }
    var body: some View {
        HStack {
            Text(text)
                .font(.title2.bold())
                .foregroundStyle(color ?? Color.primary)
            Spacer()
        }.padding(.horizontal)
    }
}

struct TaskRow: View {
    var title: String
    var icon: String? = nil
    @State private var done = false
    var body: some View {
        HStack {
            AnimatedCheckmark(checked: $done)
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.9))
                    .frame(width: 28, height: 28)
                    .background(
                        Circle()
                            .fill(LinearGradient(colors: [.mint.opacity(0.8), .blue.opacity(0.6)],
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                    )
            }
            Text(title).font(.body)
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    LinearGradient(colors: [.mint.opacity(0.7), .blue.opacity(0.5)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing),
                    lineWidth: 1.5
                )
                .shadow(color: .blue.opacity(0.35), radius: 10, x: 0, y: 6)
                .blendMode(.plusLighter)
        )
        .padding(.horizontal)
        .onTapGesture { withAnimation(.spring()){ done.toggle() } }
    }
}

struct VideoSectionView: View {
    let items: [VideoItem]
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader("Video", color: items.indices.contains(currentIndex) ? items[currentIndex].gradient.first ?? .white : .white)

            TabView(selection: $currentIndex) {
                ForEach(items.indices, id: \.self) { index in
                    VideoCardView(item: items[index])
                        .tag(index)
                        .padding(.horizontal)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 28))
            .onReceive(timer) { _ in
                guard !items.isEmpty else { return }
                withAnimation(.easeInOut(duration: 0.6)) {
                    currentIndex = (currentIndex + 1) % items.count
                }
            }
        }
    }
}

struct VideoCardView: View {
    let item: VideoItem

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: item.gradient,
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    Image(systemName: item.icon)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(.ultraThinMaterial.opacity(0.25), in: RoundedRectangle(cornerRadius: 18))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(item.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                }

                Spacer()

                HStack(spacing: 8) {
                    Image(systemName: "play.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.white)
                    Text("İzlemeye başla")
                        .font(.callout.bold())
                        .foregroundStyle(.white)
                }
                .padding(12)
                .background(.ultraThinMaterial.opacity(0.2), in: Capsule())
            }
            .padding(22)
        }
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: item.gradient.last?.opacity(0.4) ?? .black.opacity(0.3), radius: 20, x: 0, y: 12)
    }
}

struct VideoItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let gradient: [Color]
}

#Preview("HomeView") {
    HomeView()
        .environment(\.colorScheme, .dark)
}
