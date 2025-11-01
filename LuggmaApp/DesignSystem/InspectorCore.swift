#if DEBUG
import SwiftUI
import Combine

enum InspectType: Equatable {
    case number(range: ClosedRange<Double>, step: Double = 1)
    case bool
    case text
    case color
    case options([String])
}

protocol AnyInspectableBinding: Identifiable {
    var id: String { get }
    var title: String { get }
    var type: InspectType { get }
    func getAny() -> Any
    func setAny(_ newValue: Any)
    func reset()
}

struct InspectBinding<Value>: AnyInspectableBinding {
    let id: String
    let title: String
    let type: InspectType
    private let getter: () -> Value
    private let setter: (Value) -> Void
    private let resetter: () -> Void

    init(
        id: String,
        title: String,
        type: InspectType,
        get: @escaping () -> Value,
        set: @escaping (Value) -> Void,
        reset: @escaping () -> Void = {}
    ) {
        self.id = id
        self.title = title
        self.type = type
        self.getter = get
        self.setter = set
        self.resetter = reset
    }

    func getAny() -> Any { getter() }

    func setAny(_ newValue: Any) {
        guard let typed = newValue as? Value else { return }
        setter(typed)
    }

    func reset() {
        resetter()
    }
}

@MainActor
final class InspectorRegistry: ObservableObject {
    static let shared = InspectorRegistry()
    @Published private(set) var components: [String: [AnyInspectableBinding]] = [:]

    func register(id: String, bindings: [AnyInspectableBinding]) {
        components[id] = bindings
        applyPersistedValues(for: id, bindings: bindings)
    }

    func unregister(id: String) {
        components.removeValue(forKey: id)
    }

    private func applyPersistedValues(for id: String, bindings: [AnyInspectableBinding]) {
        for binding in bindings {
            guard let stored = InspectorPatchStore.shared.value(for: id, bindingID: binding.id),
                  let anyValue = stored.toAny(for: binding.type) else { continue }
            binding.setAny(anyValue)
        }
    }
}

extension View {
    func inspectorID(_ id: String) -> some View {
        self.inspectID(id)
            .onDisappear { InspectorRegistry.shared.unregister(id: id) }
    }

    func registerInspectable(id: String, _ bindings: [AnyInspectableBinding]) -> some View {
        self.onAppear { InspectorRegistry.shared.register(id: id, bindings: bindings) }
    }
}

// MARK: - Persistence

enum InspectValue: Codable, Equatable {
    case number(Double)
    case bool(Bool)
    case text(String)
    case color(ColorValue)

    init?(any value: Any, type: InspectType) {
        switch type {
        case .number:
            if let double = value as? Double {
                self = .number(double)
            } else if let cg = value as? CGFloat {
                self = .number(Double(cg))
            } else if let float = value as? Float {
                self = .number(Double(float))
            } else {
                return nil
            }
        case .bool:
            guard let bool = value as? Bool else { return nil }
            self = .bool(bool)
        case .text, .options:
            if let string = value as? String {
                self = .text(string)
            } else {
                return nil
            }
        case .color:
            if let color = value as? Color {
                self = .color(ColorValue(color: color))
            } else if let uiColor = value as? UIColor {
                self = .color(ColorValue(uiColor: uiColor))
            } else {
                return nil
            }
        }
    }

    func toAny(for type: InspectType) -> Any? {
        switch (self, type) {
        case let (.number(value), .number):
            return value
        case let (.bool(value), .bool):
            return value
        case let (.text(value), .text),
             let (.text(value), .options):
            return value
        case let (.color(value), .color):
            return value.toColor()
        default:
            return nil
        }
    }
}

struct ColorValue: Codable, Equatable {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double

    init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    init(color: Color) {
        let uiColor = UIColor(color)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        self.red = Double(r)
        self.green = Double(g)
        self.blue = Double(b)
        self.alpha = Double(a)
    }

    init(uiColor: UIColor) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        self.red = Double(r)
        self.green = Double(g)
        self.blue = Double(b)
        self.alpha = Double(a)
    }

    func toColor() -> Color {
        Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

@MainActor
final class InspectorPatchStore: ObservableObject {
    static let shared = InspectorPatchStore()

    private(set) var patches: [String: [String: InspectValue]] = [:]
    private let storageKey = "inspector.pro.patches"

    private init() {
        load()
    }

    func value(for componentID: String, bindingID: String) -> InspectValue? {
        patches[componentID]?[bindingID]
    }

    func update(componentID: String, binding: AnyInspectableBinding, to newValue: Any) {
        guard let inspectValue = InspectValue(any: newValue, type: binding.type) else { return }
        var component = patches[componentID] ?? [:]
        component[binding.id] = inspectValue
        patches[componentID] = component
        persist()
    }

    func clear(componentID: String) {
        patches.removeValue(forKey: componentID)
        persist()
    }

    private func persist() {
        do {
            let data = try JSONEncoder().encode(patches)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            debugPrint("InspectorPatchStore persist error:", error)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            patches = try JSONDecoder().decode([String: [String: InspectValue]].self, from: data)
        } catch {
            debugPrint("InspectorPatchStore load error:", error)
        }
    }
}
#endif
