import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isExpanded = false

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(isExpanded: $isExpanded, selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "menucard.fill")
                }
                .tag(0)

            LinksView(isExpanded: $isExpanded, selectedTab: $selectedTab)
                .tabItem {
                    Label("Links", systemImage: "person.line.dotted.person.fill")
                }
                .tag(1)
            
            MapView(placeID: "king_of_prussia")
                .tabItem {
                    Label("Map", systemImage: "map.circle")
                }
                .tag(2)
            
            FunFactsView()
                .tabItem {
                    Label("Fun Facts", systemImage: "books.vertical.circle")
                }
                .tag(3)
        }
		
        .onChange(of: selectedTab) { newValue in
			print("Selected tab: \(newValue)")
			if newValue != 1 {
				isExpanded = false
			} else if newValue == 1 {
				isExpanded = true
				print("Expanded: \(isExpanded)")
				print("Selected tab: \(selectedTab)")
			}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
