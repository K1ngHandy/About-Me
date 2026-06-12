import SwiftUI

struct GlassHomeView: View {
    // Receive expansion state and selected tab from parent so this view can coordinate with the rest of the app
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Int
    @Namespace private var glassNS
    @State private var tilt: CGSize = .zero

    let information: Information

    var body: some View {
        VStack(spacing: 24) {
            // Header is provided by the parent `ContentView` so this view focuses on its core content.

            GlassEffectContainer(spacing: 28) {
                controls
            }

            morphingSection
                .padding(.vertical, 21)
                .padding(.horizontal, -24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))

            Spacer(minLength: 0)
        }
        .background(Color.clear)
        .ignoresSafeArea(.container, edges: .horizontal)
        .padding(24)
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let size = UIScreen.main.bounds.size
                    let x = (value.location.x / max(size.width, 1)) - 0.5
                    let y = (value.location.y / max(size.height, 1)) - 0.5
                    self.tilt = CGSize(width: x * 40, height: y * 40)
                }
                .onEnded { _ in
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        self.tilt = .zero
                    }
                }
        )
    }

    // header moved to ContentView; kept out of this view so the top header is shared app-wide.

    private var controls: some View {
        HStack(spacing: 20) {
            GlassButton(title: "Profile", systemImage: "person.crop.circle")
            GlassButton(title: "Projects", systemImage: "hammer")
            GlassButton(title: "Contact", systemImage: "envelope")
        }
        .modifier(
            GroupModifier { view in
                if #available(iOS 16.0, *) {
                    AnyView(view.contentTransition(.opacity))
                } else {
                    AnyView(view)
                }
            }
        )
    }

    private var morphingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Social Links")
                .font(.title2.weight(.semibold))

            GlassEffectContainer(spacing: 24) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(information.links) { link in
                            Link(destination: link.url) {
                                Image(link.image)
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                    .glassEffect(.regular, in: .circle)
                                    .padding(8)
                                    .shadow(color: .white.opacity(0.25), radius: 6, y: 2)
                                    .shadow(color: .black.opacity(0.25), radius: 16, y: 8)
                                    .overlay(
                                        Circle()
                                            .stroke(LinearGradient(colors: [.white.opacity(0.35), .white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, -24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(.regular.tint(Color.white.opacity(0.06)), in: .rect(cornerRadius: 24))
        .shadow(color: .black.opacity(0.25), radius: 24, y: 16)
    }

    // Toolbar moved to `ContentView` so it's visible throughout the app.
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
                .shadow(color: .white.opacity(0.25), radius: 6, y: 2)
                .shadow(color: .black.opacity(0.25), radius: 16, y: 8)
            Text(title)
                .font(.footnote)
                .foregroundStyle(.primary)
        }
        .padding(12)
        .glassEffect(.regular, in: .rect(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(LinearGradient(colors: [.white.opacity(0.35), .white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.25), radius: 20, y: 12)
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
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                .fill(
                                    LinearGradient(colors: [Color.white.opacity(0.18), Color.white.opacity(0.02)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .blendMode(.screen)
                                .opacity(0.6)
                        )
                case .circle:
                    Circle()
                        .fill(baseMaterial())
                        .overlay(
                            Circle()
                                .fill(tintOverlay())
                        )
                        .overlay(
                            Circle()
                                .fill(RadialGradient(colors: [Color.white.opacity(0.25), .clear], center: .topLeading, startRadius: 0, endRadius: 120))
                                .blendMode(.screen)
                                .opacity(0.7)
                        )
                }
            }
            .overlay {
                switch shape {
                case .rect(let cornerRadius):
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(borderStrokeColor(), lineWidth: 1.2)
                case .circle:
                    Circle()
                        .strokeBorder(borderStrokeColor(), lineWidth: 1.2)
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

// Helper modifier to conditionally apply modifiers based on availability
struct GroupModifier: ViewModifier {
    let transform: (AnyView) -> AnyView

    init(_ transform: @escaping (AnyView) -> AnyView) {
        self.transform = transform
    }

    func body(content: Content) -> some View {
        transform(AnyView(content))
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
            .glassEffect(.regularTint(configuration.isPressed ? Color.blue.opacity(0.35) : Color.white.opacity(0.12)), in: .rect(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(LinearGradient(colors: [.white.opacity(configuration.isPressed ? 0.6 : 0.35), .white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == GlassButtonStyle {
    static var glass: GlassButtonStyle { .init() }
}

    #Preview {
        // Use constant bindings in preview
        GlassHomeView(isExpanded: .constant(false), selectedTab: .constant(1), information: Information())
    }

