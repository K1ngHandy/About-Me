/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "person.circle")
                }

            StoryView()
                .tabItem {
                    Label("Story", systemImage: "book.circle")
                }
            
            MapView(placeID: "sample_place_id")
                .tabItem {
                    Label("Map", systemImage: "map.circle")
                }
            
            FunFactsView()
                .tabItem {
                    Label("Fun Facts", systemImage: "books.vertical.circle")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
