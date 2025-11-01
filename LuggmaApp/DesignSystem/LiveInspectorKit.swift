#if DEBUG
import SwiftUI

private struct InspectKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    static func reduce(value: inout [String: Anchor<CGRect>],
                       nextValue: () -> [String: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

extension View {
    func inspectID(_ id: String) -> some View {
        anchorPreference(key: InspectKey.self, value: .bounds) { [id: $0] }
    }
}

struct LiveInspectorOverlay: View {
    @Binding var isOn: Bool
    @Binding var selectedID: String?
    let onSelectionChange: (String?) -> Void

    var body: some View {
        overlayLayer
            .sheet(isPresented: Binding(
                get: { isOn && selectedID != nil },
                set: { presented in
                    if !presented {
                        selectedID = nil
                        onSelectionChange(nil)
                    }
                }
            )) {
                InspectorPanelView(componentID: selectedID, inspectorOn: $isOn, onSelectionChange: onSelectionChange)
                    .presentationDetents([.height(320), .medium])
            }
    }

    @ViewBuilder
    private var overlayLayer: some View {
        if isOn {
            OverlayLayer(selectedID: $selectedID, onSelectionChange: onSelectionChange)
                .ignoresSafeArea()
                .transition(.opacity)
        } else {
            EmptyView()
        }
    }

    private struct OverlayLayer: View {
        @Binding var selectedID: String?
        let onSelectionChange: (String?) -> Void

        var body: some View {
            GeometryReader { proxy in
                Color.clear
                    .overlayPreferenceValue(InspectKey.self) { anchors in
                        ZStack {
                            ForEach(anchors.keys.sorted(), id: \.self) { id in
                                if let anchor = anchors[id] {
                                    let rect = proxy[anchor]
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedID == id ? Color.red : Color.blue,
                                                style: StrokeStyle(
                                                    lineWidth: selectedID == id ? 3 : 2,
                                                    dash: selectedID == id ? [] : [6, 4]
                                                ))
                                        .frame(width: rect.width, height: rect.height)
                                        .position(x: rect.midX, y: rect.midY)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            if selectedID == id {
                                                selectedID = nil
                                                onSelectionChange(nil)
                                            } else {
                                                selectedID = id
                                                onSelectionChange(id)
                                            }
                                        }
                                        .overlay(alignment: .topLeading) {
                                            Text(id)
                                                .font(.caption2.bold())
                                                .padding(4)
                                                .background(Color.yellow.opacity(0.9))
                                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                                .offset(x: 4, y: -4)
                                        }
                                }
                            }
                        }
                    }
            }
            .allowsHitTesting(true)
        }
    }
}

private struct InspectorPanelView: View {
    @ObservedObject private var registry = InspectorRegistry.shared
    @ObservedObject private var patchStore = InspectorPatchStore.shared

    let componentID: String?
    @Binding var inspectorOn: Bool
    let onSelectionChange: (String?) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(componentID.map { "Seçili: \($0)" } ?? "Seçili öğe yok")
                    .font(.headline)
                Spacer()
                Toggle("Inspector açık", isOn: $inspectorOn)
                    .labelsHidden()
            }
            Divider()

            if let id = componentID,
               let bindings = registry.components[id],
               !bindings.isEmpty {
                Form {
                    ForEach(Array(bindings.enumerated()), id: \.element.id) { _, binding in
                        InspectorControlRow(componentID: id, binding: binding)
                    }
                    Button(role: .destructive) {
                        bindings.forEach { $0.reset() }
                        InspectorPatchStore.shared.clear(componentID: id)
                        registry.register(id: id, bindings: bindings)
                        onSelectionChange(id)
                    } label: {
                        Text("Reset to defaults")
                    }
                }
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "hand.tap")
                        .font(.system(size: 32))
                        .foregroundStyle(.secondary)
                    Text("Öğe seç")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
            }
        }
        .padding()
    }
}

private struct InspectorControlRow: View {
    let componentID: String
    let binding: AnyInspectableBinding

    @ObservedObject private var patchStore = InspectorPatchStore.shared

    var body: some View {
        switch binding.type {
        case let .number(range, step):
            let value = currentDoubleValue(from: binding) ?? range.lowerBound
            VStack(alignment: .leading) {
                HStack {
                    Text(binding.title)
                    Spacer()
                    Text(String(format: "%.1f", value))
                        .foregroundStyle(.secondary)
                }
                Slider(
                    value: Binding(
                        get: { currentDoubleValue(from: binding) ?? range.lowerBound },
                        set: { newValue in
                            binding.setAny(newValue)
                            patchStore.update(componentID: componentID, binding: binding, to: newValue)
                        }
                    ),
                    in: range,
                    step: step
                )
            }
        case .bool:
            Toggle(binding.title, isOn: Binding(
                get: { (binding.getAny() as? Bool) ?? false },
                set: { newValue in
                    binding.setAny(newValue)
                    patchStore.update(componentID: componentID, binding: binding, to: newValue)
                }
            ))
        case .text:
            VStack(alignment: .leading) {
                Text(binding.title)
                TextField(
                    binding.title,
                    text: Binding(
                        get: { (binding.getAny() as? String) ?? "" },
                        set: { newValue in
                            binding.setAny(newValue)
                            patchStore.update(componentID: componentID, binding: binding, to: newValue)
                        }
                    )
                )
            }
        case .options(let options):
            Picker(binding.title, selection: Binding(
                get: { (binding.getAny() as? String) ?? options.first ?? "" },
                set: { newValue in
                    binding.setAny(newValue)
                    patchStore.update(componentID: componentID, binding: binding, to: newValue)
                }
            )) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(.segmented)
        case .color:
            VStack(alignment: .leading) {
                Text(binding.title)
                ColorPicker(
                    binding.title,
                    selection: Binding(
                        get: {
                            if let color = binding.getAny() as? Color {
                                return color
                            } else {
                                return .white
                            }
                        },
                        set: { newColor in
                            binding.setAny(newColor)
                            patchStore.update(componentID: componentID, binding: binding, to: newColor)
                        }
                    )
                )
                .labelsHidden()
            }
        }
    }

    private func currentDoubleValue(from binding: AnyInspectableBinding) -> Double? {
        if let double = binding.getAny() as? Double {
            return double
        }
        if let cg = binding.getAny() as? CGFloat {
            return Double(cg)
        }
        if let float = binding.getAny() as? Float {
            return Double(float)
        }
        return nil
    }
}
#else
import SwiftUI

extension View {
    func inspectID(_ id: String) -> some View { self }
}
#endif
