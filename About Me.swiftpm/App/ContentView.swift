import SwiftUI

// FooterView is managed inside NavigationHost and only shown for Home tab.
// Do not add a FooterView here.

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isExpanded = false
    @State private var mapSelectionText: String = ""

    var body: some View {
        if #available(iOS 16.0, *) {
            ZStack {
                AppBackground()
                NavigationHost(selectedTab: $selectedTab, isExpanded: $isExpanded, mapSelectionText: $mapSelectionText)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
