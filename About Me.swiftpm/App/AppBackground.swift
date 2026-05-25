import SwiftUI

struct AppBackground: View {
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.purple, .indigo, .blue],
                center: .topLeading,
                startRadius: 50,
                endRadius: 600
            )
            .ignoresSafeArea()

            AngularGradient(
                gradient: Gradient(
                    colors: [
                        .blue.opacity(0.6),
                        .purple.opacity(0.6),
                    ]
                ),
                center: .center
            )
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
            LinearGradient(
                colors: [.white.opacity(0.05), .clear],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .blendMode(.overlay)
        }
        // Debug overlay: faint tint so it's obvious whether this background is rendered.
        .overlay(Color.red.opacity(0.06))
    }
}

struct AppBackground_Previews: PreviewProvider {
    static var previews: some View {
        AppBackground()
    }
}
