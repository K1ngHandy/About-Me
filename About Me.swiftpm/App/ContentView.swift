import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isExpanded = false
    @State private var mapSelectionText: String = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(isExpanded: $isExpanded, selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "menucard.fill")
                }
                .tag(0)

            GlassHomeView(isExpanded: $isExpanded, selectedTab: $selectedTab, information: information)
                .tabItem {
                    Label("Social", systemImage: "person.line.dotted.person.fill")
                }
                .tag(1)
            
            MapView(placeID: "king_of_prussia", selectionText: $mapSelectionText)
                .tabItem {
                    Label("Map", systemImage: "map.circle")
                }
                .tag(2)
            
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "laptopcomputer")
                }
                .tag(3)
        }
        .background(Color.blue)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
