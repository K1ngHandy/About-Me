/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI
import MapKit

struct MapView: View {
//    Create map view
    var placeID: String
    
    @State var item: MKMapItem?
    
    var body: some View {
        if #available(iOS 17.0, *) {
            Map {
                if let item = item {
                    Marker(item: item)
                }
            }
            .task {
                await fetchMapItem()
            }
        } else {
            // Fallback on earlier versions
            Text("Map feature is not supported on your device.")
                .padding()
                .foregroundColor(.red)
        }
    }
    
    func fetchMapItem() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = placeID
        
        let search = MKLocalSearch(request: request)
        do {
            let response = try await search.start()
            item = response.mapItems.first
        } catch {
            print("Error fetching map item: \(error.localizedDescription)")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(placeID: "sample_place_id")
    }
}
