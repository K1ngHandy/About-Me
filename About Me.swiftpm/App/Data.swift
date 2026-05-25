import SwiftUI

// Single source of truth for link items used across the app
struct LinkItem: Identifiable {
    let id = UUID()
    let url: URL
    let image: String
    let title: String
}

struct Information {
    let logoImage: String
    let name: String
    let links: [LinkItem]

    // convenience empty/default initializer used by previews
    init(logoImage: String = "App-icon", name: String = "K1ngHandy", links: [LinkItem]? = nil) {
        self.logoImage = logoImage
        self.name = name
        if let links = links {
            self.links = links
        } else {
            self.links = [
                LinkItem(
                    url: URL(
                        string:
                            "https://www.facebook.com/profile.php?id=100089943411049&mibextid=LQQJ4d"
                    )!, image: "facebook-icon", title: "Facebook"),
                LinkItem(
                    url: URL(string: "https://x.com/K1ngHandy")!, image: "x-icon", title: "X.com"),
                LinkItem(
                    url: URL(string: "https://www.tiktok.com/@k1nghandy?_t=8qANXakjzdC&_r=1")!,
                    image: "TikTok-icon", title: "TikTok"),
                LinkItem(
                    url: URL(string: "https://www.threads.net/@k1nghandy")!,
                    image: "threads-icon-dark", title: "Threads"),
                LinkItem(
                    url: URL(string: "https://bsky.app/profile/k1nghandy.bsky.social")!,
                    image: "bluesky-icon", title: "Bluesky"),
            ]
        }
    }
}
typealias Info = Information

let information = Information()
