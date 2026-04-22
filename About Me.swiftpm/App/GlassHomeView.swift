import SwiftUI

struct GlassHomeView: View {
    @State private var isExpanded = false
    @Namespace private var glassNS

    var body: some View {
        NavigationStack {
            ZStack {
                // Dynamic colorful background to showcase glass
                LinearGradient(colors: [.purple, .blue, .indigo, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    header
                    GlassEffectContainer(spacing: 28) {
                        controls
                    }
                    morphingSection
                    Spacer(minLength: 0)
                }
                .padding(24)
            }
            .navigationTitle("About Me")
            .toolbar { toolbarContent }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About Me")
                .font(.largeTitle.bold())
            Text("Modernized with Liquid Glass")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(.regular.tint(.white.opacity(0.1)).interactive(), in: .rect(cornerRadius: 20))
    }

    private var controls: some View {
        HStack(spacing: 20) {
            GlassButton(title: "Profile", systemImage: "person.crop.circle")
            GlassButton(title: "Projects", systemImage: "hammer")
            GlassButton(title: "Contact", systemImage: "envelope")
        }
    }

    private var morphingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Showcase")
                .font(.title2.weight(.semibold))
            Text("Tap the toggle to see Liquid Glass morph between elements.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            GlassEffectContainer(spacing: 36) {
                HStack(spacing: 20) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 28))
                        .frame(width: 64, height: 64)
                        .foregroundStyle(.yellow)
                        .glassEffect(.regular, in: .rect(cornerRadius: 16))
                        .glassEffectID("left", in: glassNS)

                    if isExpanded {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 28))
                            .frame(width: 64, height: 64)
                            .foregroundStyle(.red)
                            .glassEffect(.regular.tint(.red.opacity(0.15)).interactive(), in: .rect(cornerRadius: 16))
                            .glassEffectID("right", in: glassNS)
                    }
                }
            }

            Button(isExpanded ? "Collapse" : "Expand") {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
            }
            .buttonStyle(.glass)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(.regular, in: .rect(cornerRadius: 20))
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .font(.system(size: 18, weight: .semibold))
                    .glassEffect(.regular, in: .circle)
                Text("Liquid Glass")
                    .font(.subheadline.weight(.semibold))
            }
            .padding(.horizontal, 8)
        }

        ToolbarItemGroup(placement: .topBarTrailing) {
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 16, weight: .semibold))
            }
            .buttonStyle(.glass)

            Button(action: {}) {
                Image(systemName: "gearshape")
                    .font(.system(size: 16, weight: .semibold))
            }
            .buttonStyle(.glass)
        }
    }
}

private struct GlassButton: View {
    let title: String
    let systemImage: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.system(size: 24, weight: .semibold))
                .frame(width: 56, height: 56)
                .glassEffect(.regular.interactive(), in: .circle)
            Text(title)
                .font(.footnote)
                .foregroundStyle(.primary)
        }
        .padding(12)
        .glassEffect(.regular, in: .rect(cornerRadius: 16))
    }
}

// MARK: - GlassEffect and GlassEffectContainer implementations (self-contained)

struct GlassEffectContainer<Content: View>: View {
    let spacing: CGFloat
    let content: () -> Content

    init(spacing: CGFloat = 16, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        HStack(spacing: spacing) {
            content()
        }
        .padding()
        .background(
            // Semi-transparent blurred background with rounded corners
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

enum GlassEffectStyle {
    case regular
    case regularTint(Color)
    
    func tint(_ color: Color) -> GlassEffectStyle {
        switch self {
        case .regular:
            return .regularTint(color)
        case .regularTint:
            return self
        }
    }
    
    func interactive() -> GlassEffectStyle {
        self
    }
}

enum GlassShape {
    case rect(cornerRadius: CGFloat)
    case circle
}

struct GlassEffectModifier: ViewModifier {
    let style: GlassEffectStyle
    let shape: GlassShape

    func body(content: Content) -> some View {
        content
            .padding({
                switch shape {
                case .circle: return 12
                case .rect: return 16
                }
            }())
            .background {
                switch shape {
                case .rect(let cornerRadius):
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(baseMaterial())
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                .fill(tintOverlay())
                        )
                case .circle:
                    Circle()
                        .fill(baseMaterial())
                        .overlay(
                            Circle()
                                .fill(tintOverlay())
                        )
                }
            }
            .overlay {
                switch shape {
                case .rect(let cornerRadius):
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(borderStrokeColor(), lineWidth: 1)
                case .circle:
                    Circle()
                        .strokeBorder(borderStrokeColor(), lineWidth: 1)
                }
            }
    }

    private func baseMaterial() -> AnyShapeStyle {
        AnyShapeStyle(.ultraThinMaterial)
    }

    private func tintOverlay() -> AnyShapeStyle {
        switch style {
        case .regular:
            return AnyShapeStyle(Color.clear)
        case .regularTint(let color):
            return AnyShapeStyle(color.opacity(0.15))
        }
    }

    private func borderStrokeColor() -> Color {
        switch style {
        case .regular:
            return Color.white.opacity(0.2)
        case .regularTint(let color):
            return color.opacity(0.4)
        }
    }
}

extension View {
    func glassEffect(_ style: GlassEffectStyle) -> some View {
        modifier(GlassEffectModifier(style: style, shape: .rect(cornerRadius: 16)))
    }
    func glassEffect(_ style: GlassEffectStyle, in shape: GlassShape) -> some View {
        modifier(GlassEffectModifier(style: style, shape: shape))
    }

    func glassEffectID(_ id: String, in namespace: Namespace.ID) -> some View {
        self.matchedGeometryEffect(id: id, in: namespace)
    }
}

// ButtonStyle for glass buttons
struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .glassEffect(.regularTint(configuration.isPressed ? Color.blue.opacity(0.25) : Color.white.opacity(0.1)), in: .rect(cornerRadius: 16))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == GlassButtonStyle {
    static var glass: GlassButtonStyle { .init() }
}

#Preview {
    GlassHomeView()
}
