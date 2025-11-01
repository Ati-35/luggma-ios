import SwiftUI

struct Lessons_HomeView: View {
    @Environment(\.liveTheme) private var theme
    private let summary = ProgramSummary(
        streakDays: 6,
        completedLessons: 8,
        totalLessons: 12,
        nextLesson: "Tetikleyicileri Yönetme"
    )

#if DEBUG
    @State private var debugSelection: String?
    @State private var inspectorOn = true
    @State private var inspectorSelection: String?
#endif

    private let focusBlocks: [FocusBlock] = [
        .init(
            id: "breath",
            title: "Nefes Rutini",
            subtitle: "4-7-8 metodunu 5 dk uygula",
            icon: "lungs.fill",
            startColor: .teal.opacity(0.8),
            endColor: .blue.opacity(0.7)
        ),
        .init(
            id: "reflect",
            title: "Koç Notları",
            subtitle: "Bugünkü kazancını yaz",
            icon: "bubble.left.and.exclamationmark.fill",
            startColor: .purple.opacity(0.8),
            endColor: .pink.opacity(0.7)
        ),
        .init(
            id: "community",
            title: "Topluluğa Uğra",
            subtitle: "Motivasyon mesajı bırak",
            icon: "person.3.fill",
            startColor: .orange.opacity(0.8),
            endColor: .red.opacity(0.6)
        )
    ]

    private let modules: [LessonModule] = [
        .init(
            id: "module-1",
            title: "Mini Başlangıç Kiti",
            description: "Günlük rutinini planla ve tetikleyici listeni çıkar.",
            duration: "12 dk",
            progress: 1.0,
            isLocked: false,
            isCompleted: true
        ),
        .init(
            id: "module-2",
            title: "Tetikleyicileri Yönetme",
            description: "Stres, kahve ve sosyalleşme senaryolarına hazırlık.",
            duration: "18 dk",
            progress: 0.55,
            isLocked: false,
            isCompleted: false
        ),
        .init(
            id: "module-3",
            title: "Kriz Anı SOS",
            description: "Dürtü geldiğinde 3 adımlı acil plan.",
            duration: "9 dk",
            progress: 0.0,
            isLocked: false,
            isCompleted: false
        ),
        .init(
            id: "module-4",
            title: "Sosyal Destek Ağı",
            description: "Aileni, arkadaşlarını ve topluluğu konumlandır.",
            duration: "15 dk",
            progress: 0.0,
            isLocked: true,
            isCompleted: false
        )
    ]

    private let quickActions: [QuickAction] = [
        .init(id: "resume", title: "Kaldığın Yerden Devam Et", subtitle: "Son modül: Tetikleyicileri Yönetme", icon: "play.circle.fill"),
        .init(id: "downloads", title: "Offline İndirilenler", subtitle: "3 ders hazır", icon: "arrow.down.circle.fill"),
        .init(id: "coach", title: "Koçla Görüş", subtitle: "Mini check-in planla", icon: "phone.fill"),
        .init(id: "progress", title: "İlerlemeyi Paylaş", subtitle: "Toplulukta motive et", icon: "sparkles")
    ]

    private let resources: [ResourceItem] = [
        .init(id: "pdf", title: "Çekilme Atakları İçin Kontrol Listesi", description: "Sık gördüğün beden sinyallerini tanı ve yönlendir.", badge: "PDF"),
        .init(id: "audio", title: "3 Dakikalık Sakinleşme", description: "Koçtan sesli yönlendirme ile nefes eşlikçisi.", badge: "Ses"),
        .init(id: "community", title: "Toplulukta #7GünSigarasız", description: "Diğerlerinin stratejilerini keşfet.", badge: "Topluluk")
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HeroHeader(
                    title: "Dersler",
                    subtitle: "Koç planın tek ekranda; tempo sende.",
                    imageName: nil
                )
#if DEBUG
                .registerInspectable(
                    id: "HERO_HEADER",
                    [
                        InspectBinding<Double>(
                            id: "headerHeight",
                            title: "Header Height",
                            type: .number(range: 160...320, step: 1),
                            get: { Double(theme.headerHeight) },
                            set: { theme.headerHeight = CGFloat($0) }
                        ),
                        InspectBinding<Double>(
                            id: "cardCorner",
                            title: "Corner Radius",
                            type: .number(range: 8...36, step: 1),
                            get: { Double(theme.cornerRadius(for: "HERO_HEADER", default: theme.cardCorner)) },
                            set: { theme.setCornerRadius(CGFloat($0), for: "HERO_HEADER") },
                            reset: { theme.resetCornerRadius(for: "HERO_HEADER") }
                        )
                    ]
                )
#endif
                .debugLayout("HeroHeader")
                .inspectorID("HERO_HEADER")
                .debugTag("HeroHeader")
                .debugAnchor("hero-header")
                LessonProgressCard(summary: summary)
#if DEBUG
                    .registerInspectable(
                        id: "LESSON_PROGRESS",
                        [
                            InspectBinding<Double>(
                                id: "cardCorner",
                                title: "Corner Radius",
                                type: .number(range: 8...36, step: 1),
                                get: { Double(theme.cornerRadius(for: "LESSON_PROGRESS", default: theme.cardCorner)) },
                                set: { theme.setCornerRadius(CGFloat($0), for: "LESSON_PROGRESS") },
                                reset: { theme.resetCornerRadius(for: "LESSON_PROGRESS") }
                            ),
                            InspectBinding<Color>(
                                id: "gradientStart",
                                title: "Gradient Start",
                                type: .color,
                                get: { theme.color(for: "LESSON_PROGRESS_GRADIENT_START", default: Color.indigo.opacity(0.85)) },
                                set: { theme.setColor($0, for: "LESSON_PROGRESS_GRADIENT_START") },
                                reset: { theme.resetColor(for: "LESSON_PROGRESS_GRADIENT_START") }
                            ),
                            InspectBinding<Color>(
                                id: "gradientEnd",
                                title: "Gradient End",
                                type: .color,
                                get: { theme.color(for: "LESSON_PROGRESS_GRADIENT_END", default: Color.blue.opacity(0.7)) },
                                set: { theme.setColor($0, for: "LESSON_PROGRESS_GRADIENT_END") },
                                reset: { theme.resetColor(for: "LESSON_PROGRESS_GRADIENT_END") }
                            )
                        ]
                    )
#endif
                    .debugLayout("LessonProgressCard")
                    .inspectorID("LESSON_PROGRESS")
                    .debugTag("LessonProgressCard")
                    .debugAnchor("lesson-progress")
#if DEBUG
                FocusGrid(blocks: focusBlocks, onSelect: { handleSelection($0) })
                    .debugLayout("FocusGrid")
                    .inspectorID("FOCUS_GRID")
                    .debugTag("FocusGrid")
                    .debugAnchor("focus-grid")
#else
                FocusGrid(blocks: focusBlocks)
                    .debugLayout("FocusGrid")
                    .inspectID("FOCUS_GRID")
                    .debugTag("FocusGrid")
                    .debugAnchor("focus-grid")
#endif
#if DEBUG
                ModuleList(modules: modules, onSelect: { handleSelection($0) })
                    .debugLayout("ModuleList")
                    .inspectorID("MODULE_LIST")
                    .debugTag("ModuleList")
                    .debugAnchor("module-list")
#else
                ModuleList(modules: modules)
                    .debugLayout("ModuleList")
                    .inspectID("MODULE_LIST")
                    .debugTag("ModuleList")
                    .debugAnchor("module-list")
#endif
#if DEBUG
                QuickActionCarousel(actions: quickActions, onSelect: { handleSelection($0) })
                    .debugLayout("QuickActionCarousel")
                    .inspectorID("QUICK_ACTIONS")
                    .debugTag("QuickActionCarousel")
                    .debugAnchor("quick-actions")
#else
                QuickActionCarousel(actions: quickActions)
                    .debugLayout("QuickActionCarousel")
                    .inspectID("QUICK_ACTIONS")
                    .debugTag("QuickActionCarousel")
                    .debugAnchor("quick-actions")
#endif
#if DEBUG
                ResourceList(items: resources, onSelect: { handleSelection($0) })
                    .debugLayout("ResourceList")
                    .inspectorID("RESOURCE_LIST")
                    .debugTag("ResourceList")
                    .debugAnchor("resource-list")
#else
                ResourceList(items: resources)
                    .debugLayout("ResourceList")
                    .inspectID("RESOURCE_LIST")
                    .debugTag("ResourceList")
                    .debugAnchor("resource-list")
#endif
                Spacer(minLength: 28)
            }
            .padding(.top, 24)
            .padding(.bottom, 48)
#if DEBUG
            .debugConnect(selection: debugSelection, links: buildDebugLinks())
            .overlay(
                LiveInspectorOverlay(
                    isOn: $inspectorOn,
                    selectedID: $inspectorSelection,
                    onSelectionChange: { handleSelection($0) }
                )
            )
#endif
#if DEBUG
            .overlay(alignment: .topTrailing) {
                Button {
                    inspectorOn.toggle()
                } label: {
                    Text(inspectorOn ? "Inspector açık" : "Inspector kapalı")
                        .font(.caption.bold())
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                }
                .padding()
            }
#endif
        }
        .debugLayout("Lessons_HomeView")
        .background(GradientBackground())
    }
}

#if DEBUG
private extension Lessons_HomeView {
    func handleSelection(anchorID: String?, inspectorID: String?) {
        debugSelection = anchorID
        if let inspectorID {
            inspectorSelection = inspectorID
            inspectorOn = true
        } else {
            inspectorSelection = nil
        }
    }

    func handleSelection(_ id: String?) {
        let anchor = anchorID(for: id)
        handleSelection(anchorID: anchor, inspectorID: id)
    }

    func buildDebugLinks() -> [DebugLink] {
        var links: [DebugLink] = [
            DebugLink(from: "hero-header", to: "lesson-progress"),
            DebugLink(from: "lesson-progress", to: "focus-grid"),
            DebugLink(from: "focus-grid", to: "module-list"),
            DebugLink(from: "module-list", to: "quick-actions"),
            DebugLink(from: "quick-actions", to: "resource-list")
        ]

        links += focusBlocks.map { DebugLink(from: "focus-grid", to: "focus-\($0.id)") }
        links += modules.map { DebugLink(from: "module-list", to: "module-\($0.id)") }
        links += quickActions.map { DebugLink(from: "quick-actions", to: "quick-\($0.id)") }
        links += resources.map { DebugLink(from: "resource-list", to: "resource-\($0.id)") }

        return links
    }

    func anchorID(for inspectorID: String?) -> String? {
        guard let inspectorID else { return nil }
        switch inspectorID {
        case "HERO_HEADER":
            return "hero-header"
        case "LESSON_PROGRESS":
            return "lesson-progress"
        case "FOCUS_GRID":
            return "focus-grid"
        case "MODULE_LIST":
            return "module-list"
        case "QUICK_ACTIONS":
            return "quick-actions"
        case "RESOURCE_LIST":
            return "resource-list"
        default:
            if inspectorID.hasPrefix("FOCUS_CARD_") {
                let key = inspectorID.replacingOccurrences(of: "FOCUS_CARD_", with: "")
                return "focus-\(key)"
            }
            if inspectorID.hasPrefix("MODULE_ROW_") {
                let key = inspectorID.replacingOccurrences(of: "MODULE_ROW_", with: "")
                return "module-\(key)"
            }
            if inspectorID.hasPrefix("QUICK_ACTION_") {
                let key = inspectorID.replacingOccurrences(of: "QUICK_ACTION_", with: "")
                return "quick-\(key)"
            }
            if inspectorID.hasPrefix("RESOURCE_ROW_") {
                let key = inspectorID.replacingOccurrences(of: "RESOURCE_ROW_", with: "")
                return "resource-\(key)"
            }
            return inspectorID
        }
    }
}

#endif

private struct ProgramSummary {
    let streakDays: Int
    let completedLessons: Int
    let totalLessons: Int
    let nextLesson: String

    var completionRate: Double {
        guard totalLessons > 0 else { return 0 }
        return Double(completedLessons) / Double(totalLessons)
    }
}

private struct FocusBlock: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
    let startColor: Color
    let endColor: Color
}

private struct LessonModule: Identifiable {
    let id: String
    let title: String
    let description: String
    let duration: String
    let progress: Double
    let isLocked: Bool
    let isCompleted: Bool
}

private struct QuickAction: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
}

private struct ResourceItem: Identifiable {
    let id: String
    let title: String
    let description: String
    let badge: String
}

private struct LessonProgressCard: View {
    let summary: ProgramSummary
    @Environment(\.liveTheme) private var theme
    private let componentID = "LESSON_PROGRESS"
    private var cornerRadius: CGFloat {
        theme.cornerRadius(for: componentID, default: theme.cardCorner)
    }
    private var gradientStart: Color {
        theme.color(for: "\(componentID)_GRADIENT_START", default: Color.indigo.opacity(0.85))
    }
    private var gradientEnd: Color {
        theme.color(for: "\(componentID)_GRADIENT_END", default: Color.blue.opacity(0.7))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Program İlerlemesi")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("\(summary.completedLessons) / \(summary.totalLessons) ders tamamlandı")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                }
                Spacer()
                VStack(spacing: 6) {
                    Text("\(summary.streakDays)")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                    Text("gün zincir")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }

            ProgressView(value: summary.completionRate) {
                Text("Tamamlama oranı")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
            } currentValueLabel: {
                Text("\(Int(summary.completionRate * 100))%")
                    .font(.caption.bold())
                    .foregroundStyle(.white)
            }
            .tint(.white)

            HStack {
                Label("Sıradaki: \(summary.nextLesson)", systemImage: "play.fill")
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.9))
                Spacer()
                Button {
                    // future hook: resume next lesson
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.forward.circle.fill")
                        Text("Devam Et")
                    }
                    .font(.footnote.bold())
                    .foregroundStyle(.indigo.opacity(0.9))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 14)
                    .background(
                        Capsule()
                            .fill(.white)
                    )
                }
            }
        }
        .padding()
        .padding(.horizontal, 4)
        .background(
            LinearGradient(
                colors: [gradientStart, gradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(.white.opacity(0.25), lineWidth: 1)
        )
        .padding(.horizontal)
        .shadow(color: .indigo.opacity(0.4), radius: 18, x: 0, y: 18)
    }
}

private struct FocusGrid: View {
    let blocks: [FocusBlock]
    @Environment(\.liveTheme) private var theme
#if DEBUG
    var onSelect: ((String) -> Void)?

    init(blocks: [FocusBlock], onSelect: ((String) -> Void)? = nil) {
        self.blocks = blocks
        self.onSelect = onSelect
    }
#else
    init(blocks: [FocusBlock]) {
        self.blocks = blocks
    }
#endif

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader("Bugünün Odakları")
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                ForEach(blocks) { block in
                    FocusCard(block: block)
#if DEBUG
                        .registerInspectable(
                            id: "FOCUS_CARD_\(block.id)",
                            [
                                InspectBinding<Double>(
                                    id: "cardCorner",
                                    title: "Corner Radius",
                                    type: .number(range: 8...36, step: 1),
                                    get: { Double(theme.cornerRadius(for: "FOCUS_CARD_\(block.id)", default: theme.cardCorner)) },
                                    set: { theme.setCornerRadius(CGFloat($0), for: "FOCUS_CARD_\(block.id)") },
                                    reset: { theme.resetCornerRadius(for: "FOCUS_CARD_\(block.id)") }
                                ),
                                InspectBinding<Color>(
                                    id: "gradientStart",
                                    title: "Gradient Start",
                                    type: .color,
                                    get: { theme.color(for: "FOCUS_CARD_\(block.id)_GRADIENT_START", default: block.startColor) },
                                    set: { theme.setColor($0, for: "FOCUS_CARD_\(block.id)_GRADIENT_START") },
                                    reset: { theme.resetColor(for: "FOCUS_CARD_\(block.id)_GRADIENT_START") }
                                ),
                                InspectBinding<Color>(
                                    id: "gradientEnd",
                                    title: "Gradient End",
                                    type: .color,
                                    get: { theme.color(for: "FOCUS_CARD_\(block.id)_GRADIENT_END", default: block.endColor) },
                                    set: { theme.setColor($0, for: "FOCUS_CARD_\(block.id)_GRADIENT_END") },
                                    reset: { theme.resetColor(for: "FOCUS_CARD_\(block.id)_GRADIENT_END") }
                                )
                            ]
                        )
#endif
                        .debugLayout("FocusCard:\(block.title)")
                        .inspectorID("FOCUS_CARD_\(block.id)")
                        .debugAnchor("focus-\(block.id)")
                        .debugTag("FocusCard:\(block.title)")
#if DEBUG
                        .onTapGesture {
                            onSelect?("FOCUS_CARD_\(block.id)")
                        }
#endif
                }
            }
            .padding(.horizontal)
        }
    }
}

private struct FocusCard: View {
    let block: FocusBlock
    @Environment(\.liveTheme) private var theme
    private var componentID: String { "FOCUS_CARD_\(block.id)" }
    private var cornerRadius: CGFloat {
        theme.cornerRadius(for: componentID, default: theme.cardCorner)
    }
    private var gradientStart: Color {
        theme.color(for: "\(componentID)_GRADIENT_START", default: block.startColor)
    }
    private var gradientEnd: Color {
        theme.color(for: "\(componentID)_GRADIENT_END", default: block.endColor)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: block.icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.white)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(.white.opacity(0.15))
                )
            Text(block.title)
                .font(.headline)
                .foregroundStyle(.white)
            Text(block.subtitle)
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.85))
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 160, alignment: .topLeading)
        .padding()
        .background(
            LinearGradient(
                colors: [gradientStart, gradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .shadow(color: gradientStart.opacity(0.45), radius: 14, x: 0, y: 10)
    }
}

private struct ModuleList: View {
    let modules: [LessonModule]
    @Environment(\.liveTheme) private var theme
#if DEBUG
    var onSelect: ((String) -> Void)?

    init(modules: [LessonModule], onSelect: ((String) -> Void)? = nil) {
        self.modules = modules
        self.onSelect = onSelect
    }
#else
    init(modules: [LessonModule]) {
        self.modules = modules
    }
#endif

    var body: some View {
        VStack(spacing: 16) {
            SectionHeader("Modüller")
            VStack(spacing: 12) {
                ForEach(modules) { module in
                    ModuleRow(module: module)
#if DEBUG
                        .registerInspectable(
                            id: "MODULE_ROW_\(module.id)",
                            [
                                InspectBinding<Double>(
                                    id: "cardCorner",
                                    title: "Corner Radius",
                                    type: .number(range: 8...36, step: 1),
                                    get: { Double(theme.cornerRadius(for: "MODULE_ROW_\(module.id)", default: theme.cardCorner)) },
                                    set: { theme.setCornerRadius(CGFloat($0), for: "MODULE_ROW_\(module.id)") },
                                    reset: { theme.resetCornerRadius(for: "MODULE_ROW_\(module.id)") }
                                )
                            ]
                        )
#endif
                        .debugLayout("ModuleRow:\(module.title)")
                        .inspectorID("MODULE_ROW_\(module.id)")
                        .debugAnchor("module-\(module.id)")
                        .debugTag("ModuleRow:\(module.title)")
#if DEBUG
                        .onTapGesture {
                            onSelect?("MODULE_ROW_\(module.id)")
                        }
#endif
                }
            }
            .padding(.horizontal)
        }
    }
}

private struct ModuleRow: View {
    let module: LessonModule
    @Environment(\.liveTheme) private var theme
    private var componentID: String { "MODULE_ROW_\(module.id)" }
    private var cornerRadius: CGFloat {
        theme.cornerRadius(for: componentID, default: theme.cardCorner)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: module.isCompleted ? "checkmark.circle.fill" : module.isLocked ? "lock.fill" : "play.circle.fill")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(module.isCompleted ? Color.green : module.isLocked ? Color.gray : Color.indigo)
                VStack(alignment: .leading, spacing: 6) {
                    Text(module.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(module.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text(module.duration)
                    .font(.footnote.bold())
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(
                        Capsule()
                            .fill(Color.gray.opacity(0.15))
                    )
            }

            if module.isCompleted {
                CompletedBadge()
            } else {
                ProgressView(value: module.progress)
                    .tint(module.isLocked ? .gray.opacity(0.4) : .indigo)
                HStack {
                    Text(module.isLocked ? "Kilidi açmak için önceki modülü bitir." : module.progress > 0 ? "Son tamamlanan adım kaydedildi." : "Hazırsan koçla birlikte başlayalım.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    LinearGradient(
                        colors: module.isLocked ? [Color.gray.opacity(0.35), Color.gray.opacity(0.15)] : [Color.indigo.opacity(0.5), Color.blue.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
    }
}

private struct CompletedBadge: View {
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "star.fill").foregroundStyle(.yellow)
            Text("Tamamlandı").font(.footnote.bold()).foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(
            Capsule()
                .fill(Color.green.opacity(0.12))
        )
    }
}

private struct QuickActionCarousel: View {
    let actions: [QuickAction]
    @Environment(\.liveTheme) private var theme
#if DEBUG
    var onSelect: ((String) -> Void)?

    init(actions: [QuickAction], onSelect: ((String) -> Void)? = nil) {
        self.actions = actions
        self.onSelect = onSelect
    }
#else
    init(actions: [QuickAction]) {
        self.actions = actions
    }
#endif

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader("Hızlı Adımlar")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                ForEach(actions) { action in
                    QuickActionCard(action: action)
#if DEBUG
                        .registerInspectable(
                            id: "QUICK_ACTION_\(action.id)",
                            [
                                InspectBinding<Double>(
                                    id: "cardCorner",
                                    title: "Corner Radius",
                                    type: .number(range: 8...36, step: 1),
                                    get: { Double(theme.cornerRadius(for: "QUICK_ACTION_\(action.id)", default: theme.cardCorner)) },
                                    set: { theme.setCornerRadius(CGFloat($0), for: "QUICK_ACTION_\(action.id)") },
                                    reset: { theme.resetCornerRadius(for: "QUICK_ACTION_\(action.id)") }
                                ),
                                InspectBinding<Color>(
                                    id: "gradientStart",
                                    title: "Gradient Start",
                                    type: .color,
                                    get: {
                                        theme.color(
                                            for: "QUICK_ACTION_\(action.id)_GRADIENT_START",
                                            default: Color.indigo.opacity(0.9)
                                        )
                                    },
                                    set: { theme.setColor($0, for: "QUICK_ACTION_\(action.id)_GRADIENT_START") },
                                    reset: { theme.resetColor(for: "QUICK_ACTION_\(action.id)_GRADIENT_START") }
                                ),
                                InspectBinding<Color>(
                                    id: "gradientEnd",
                                    title: "Gradient End",
                                    type: .color,
                                    get: {
                                        theme.color(
                                            for: "QUICK_ACTION_\(action.id)_GRADIENT_END",
                                            default: Color.blue.opacity(0.7)
                                        )
                                    },
                                    set: { theme.setColor($0, for: "QUICK_ACTION_\(action.id)_GRADIENT_END") },
                                    reset: { theme.resetColor(for: "QUICK_ACTION_\(action.id)_GRADIENT_END") }
                                )
                            ]
                        )
#endif
                        .debugLayout("QuickAction:\(action.title)")
                        .inspectorID("QUICK_ACTION_\(action.id)")
                        .debugAnchor("quick-\(action.id)")
                        .debugTag("QuickAction:\(action.title)")
#if DEBUG
                        .onTapGesture {
                            onSelect?("QUICK_ACTION_\(action.id)")
                        }
#endif
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

private struct QuickActionCard: View {
    let action: QuickAction
    @Environment(\.liveTheme) private var theme
    private var componentID: String { "QUICK_ACTION_\(action.id)" }
    private var cornerRadius: CGFloat {
        theme.cornerRadius(for: componentID, default: theme.cardCorner)
    }
    private var gradientStart: Color {
        theme.color(for: "\(componentID)_GRADIENT_START", default: Color.indigo.opacity(0.9))
    }
    private var gradientEnd: Color {
        theme.color(for: "\(componentID)_GRADIENT_END", default: Color.blue.opacity(0.7))
    }

    var body: some View {
        Button {
            // future hook: route to action
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: action.icon)
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [gradientStart, gradientEnd],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                Text(action.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(action.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(width: 220, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(colors: [gradientStart.opacity(0.35), gradientEnd.opacity(0.25)],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing),
                        lineWidth: 1
                    )
            )
            .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 6)
        }
        .buttonStyle(.plain)
    }
}

private struct ResourceList: View {
    let items: [ResourceItem]
    @Environment(\.liveTheme) private var theme
#if DEBUG
    var onSelect: ((String) -> Void)?

    init(items: [ResourceItem], onSelect: ((String) -> Void)? = nil) {
        self.items = items
        self.onSelect = onSelect
    }
#else
    init(items: [ResourceItem]) {
        self.items = items
    }
#endif

    var body: some View {
        VStack(spacing: 16) {
            SectionHeader("Destek Kaynakları")
            VStack(spacing: 12) {
                ForEach(items) { item in
                    ResourceRow(item: item)
#if DEBUG
                        .registerInspectable(
                            id: "RESOURCE_ROW_\(item.id)",
                            [
                                InspectBinding<Double>(
                                    id: "cardCorner",
                                    title: "Corner Radius",
                                    type: .number(range: 8...36, step: 1),
                                    get: { Double(theme.cornerRadius(for: "RESOURCE_ROW_\(item.id)", default: theme.cardCorner)) },
                                    set: { theme.setCornerRadius(CGFloat($0), for: "RESOURCE_ROW_\(item.id)") },
                                    reset: { theme.resetCornerRadius(for: "RESOURCE_ROW_\(item.id)") }
                                )
                            ]
                        )
#endif
                        .debugLayout("ResourceRow:\(item.title)")
                        .inspectorID("RESOURCE_ROW_\(item.id)")
                        .debugAnchor("resource-\(item.id)")
                        .debugTag("ResourceRow:\(item.title)")
#if DEBUG
                        .onTapGesture {
                            onSelect?("RESOURCE_ROW_\(item.id)")
                        }
#endif
                }
            }
            .padding(.horizontal)
        }
    }
}

private struct ResourceRow: View {
    let item: ResourceItem
    @Environment(\.liveTheme) private var theme
    private var componentID: String { "RESOURCE_ROW_\(item.id)" }
    private var cornerRadius: CGFloat {
        theme.cornerRadius(for: componentID, default: theme.cardCorner)
    }

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                Text(item.description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(item.badge)
                .font(.footnote.bold())
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(
                    Capsule()
                        .fill(Color.blue.opacity(0.12))
                )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
    }
}
