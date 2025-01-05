import SwiftUI

struct Info {
    let logoImage: String
    let name: String
    let links: [(url: URL, image: String, title: String)]
}

let information = Info(
    logoImage: "AI-icon",
    name: "K1ngHandy",
    links: [
        (
            url: URL(string: "https://www.facebook.com/profile.php?id=100089943411049&mibextid=LQQJ4d")!,
            image: "facebook-icon",
            title: "Facebook"
        ),
        (
            url: URL(string: "https://x.com/K1ngHandy")!,
            image: "x-icon",
            title: "X.com"
        ),
        (
            url: URL(string: "https://www.tiktok.com/@k1nghandy?_t=8qANXakjzdC&_r=1")!,
            image: "TikTok-icon",
            title: "TikTok"
        ),
        (
            url: URL(string: "https://www.threads.net/@k1nghandy")!,
            image: "threads-icon-light",
            title: "Threads"
        ),
        (
            url: URL(string: "https://instagram.com/k1nghandy")!,
            image: "instagram-icon",
            title: "Instagram"
        ),
        (
            url: URL(string: "https://bsky.app/profile/k1nghandy.bsky.social")!,
            image: "bluesky-icon",
            title: "Bluesky"
        ),
        (
            url: URL(string: "https://www.linkedin.com/in/k1nghandy")!,
            image: "linkedin-icon",
            title: "LinkedIn"
        )
    ]
)
