import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("Failed to load URL: \(error.localizedDescription)")
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("Failed to load URL: \(error.localizedDescription)")
        }
    }
}

struct Commits: View {
	private let username = "K1ngHandy"
	private var url: URL {
        URL(string: "https://profile-view-wkri.vercel.app/")!
    }

    var body: some View {
        VStack {
            WebView(url: url)
        }
    }
}

struct Commits_Previews: PreviewProvider {
    static var previews: some View {
        Commits()
    }
}
