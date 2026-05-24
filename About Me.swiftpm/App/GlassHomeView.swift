import SwiftUI

struct GlassHomeView: View {
    @State private var isExpanded = false
    @Namespace private var glassNS
    @State private var tilt: CGSize = .zero

    let information: Information

    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    ZStack {
                        ZStack {
                            RadialGradient(colors: [.purple, .indigo, .blue], center: .topLeading, startRadius: 50, endRadius: 600)
                                .ignoresSafeArea()
                            AngularGradient(gradient: Gradient(colors: [.pink.opacity(0.6), .blue.opacity(0.6), .purple.opacity(0.6), .pink.opacity(0.6)]), center: .center)
                                .opacity(0.4)
                                .blendMode(.softLight)
                                .ignoresSafeArea()
                            // Bokeh blobs
                            Circle().fill(Color.pink.opacity(0.35))
                                .frame(width: 220, height: 220)
                                .blur(radius: 60)
                                .offset(x: -120, y: -200)
                            Circle().fill(Color.blue.opacity(0.35))
                                .frame(width: 260, height: 260)
                                .blur(radius: 70)
                                .offset(x: 140, y: 220)
                            Circle().fill(Color.indigo.opacity(0.35))
                                .frame(width: 180, height: 180)
                                .blur(radius: 50)
                                .offset(x: -40, y: 260)
                            // Subtle animated noise
                            LinearGradient(colors: [.white.opacity(0.05), .clear], startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea()
                                .blendMode(.overlay)
                        }

                        VStack(spacing: 24) {
                            header
                            GlassEffectContainer(spacing: 28) {
                                controls
                            }
                            morphingSection
                            Spacer(minLength: 0)
                        }
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
                    .toolbar { toolbarContent }
                }
            } else {
                NavigationView {
                    ZStack {
                        ZStack {
                            RadialGradient(colors: [.purple, .indigo, .blue], center: .topLeading, startRadius: 50, endRadius: 600)
                                .ignoresSafeArea()
                            AngularGradient(gradient: Gradient(colors: [.pink.opacity(0.6), .blue.opacity(0.6), .purple.opacity(0.6), .pink.opacity(0.6)]), center: .center)
                                .opacity(0.4)
                                .blendMode(.softLight)
                                .ignoresSafeArea()
                            // Bokeh blobs
                            Circle().fill(Color.pink.opacity(0.35))
                                .frame(width: 220, height: 220)
                                .blur(radius: 60)
                                .offset(x: -120, y: -200)
                            Circle().fill(Color.blue.opacity(0.35))
                                .frame(width: 260, height: 260)
                                .blur(radius: 70)
                                .offset(x: 140, y: 220)
                            Circle().fill(Color.indigo.opacity(0.35))
                                .frame(width: 180, height: 180)
                                .blur(radius: 50)
                                .offset(x: -40, y: 260)
                            // Subtle animated noise
                            LinearGradient(colors: [.white.opacity(0.05), .clear], startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea()
                                .blendMode(.overlay)
                        }

                        VStack(spacing: 24) {
                            header
                            GlassEffectContainer(spacing: 28) {
                                controls
                            }
                            morphingSection
                            Spacer(minLength: 0)
                        }
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
                    .toolbar { toolbarContent }
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("K1ngHandy")
                .font(.largeTitle.bold())
                .padding(.leading, 15)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(.regular.tint(.white.opacity(0.12)).interactive(), in: .rect(cornerRadius: 24))
        .shadow(color: .white.opacity(0.2), radius: 8, y: 2)
        .shadow(color: .black.opacity(0.25), radius: 20, y: 12)
    }

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
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(.regular.tint(Color.white.opacity(0.06)), in: .rect(cornerRadius: 24))
        .shadow(color: .black.opacity(0.25), radius: 24, y: 16)
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
    GlassHomeView(information: Information())
}
