import SwiftUI
import UIKit

@main
struct AboutMeApp: App {
    init() {
        // Make hosting window and bars transparent so our AppBackground is visible.
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().isTranslucent = true

        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance

        // Set window background color to clear when possible (best-effort)
        DispatchQueue.main.async {
            for scene in UIApplication.shared.connectedScenes {
                if let windowScene = scene as? UIWindowScene {
                    for window in windowScene.windows {
                        window.backgroundColor = .clear
                        // Also clear the root view controller's background to avoid an opaque white view
                        window.rootViewController?.view.backgroundColor = .clear
                        // Insert AppBackground as a non-interactive background view directly into the window
                        // so it's guaranteed to be the bottom-most content.
                        let hosting = UIHostingController(rootView: AppBackground())
                        hosting.view.backgroundColor = .clear
                        hosting.view.translatesAutoresizingMaskIntoConstraints = true
                        hosting.view.frame = window.bounds
                        hosting.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        hosting.view.isUserInteractionEnabled = false
                        hosting.view.tag = 999_999 // identify our background view

                        // Remove previous background hosting view if present (avoid duplicates)
                        window.subviews.filter { $0.tag == hosting.view.tag }.forEach { $0.removeFromSuperview() }

                        if let root = window.rootViewController {
                            // Attach hosting controller as a child so it's retained and managed.
                            root.addChild(hosting)
                            root.view.insertSubview(hosting.view, at: 0)
                            hosting.didMove(toParent: root)
                        } else {
                            window.insertSubview(hosting.view, at: 0)
                        }
                    }
                }
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                AppBackground()
                NavigationHost2(selectedTab: .constant(0), isExpanded: .constant(false), mapSelectionText: .constant(""))
            }
        }
    }
}
