import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HeroHeader(title: "Merhaba!",
                           subtitle: "Bugün duman yok 💪",
                           gradient: LinearGradient(colors: [.mint, .blue],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing))
                HStack(spacing: 12) {
                    GlassCard(icon: "play.circle.fill", title: "Devam Et", subtitle: "Son ders")
                    GlassCard(icon: "heart.text.square.fill", title: "SOS", subtitle: "Kriz anı yardımı")
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                SectionHeader("Görevler")
                TaskRow(title: "5 dk nefes egzersizi")
                TaskRow(title: "‘Tetikleyiciler’ videosunu izle")
                TaskRow(title: "Koç notlarını uygula")
            }
        }
        .background(GradientBackground())
    }
}

struct SectionHeader: View {
    var text: String
    init(_ text: String){ self.text = text }
    var body: some View {
        HStack {
            Text(text).font(.title2.bold())
            Spacer()
        }.padding(.horizontal)
    }
}

struct TaskRow: View {
    var title: String
    @State private var done = false
    var body: some View {
        HStack {
            AnimatedCheckmark(checked: $done)
            Text(title).font(.body)
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .onTapGesture { withAnimation(.spring()){ done.toggle() } }
    }
}
