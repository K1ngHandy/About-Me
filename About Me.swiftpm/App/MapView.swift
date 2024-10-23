/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI
import MapKit

struct IdentifiableMapItem: Identifiable {
    let id = UUID()
    let mapItem: MKMapItem
}

struct MapView: View {
//    Create map view
    var placeID: String
    var mapView: MKMapView?
    
    @State var item: IdentifiableMapItem?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
	//	create zoom control
    init(placeID: String, mapView: MKMapView? = nil) {
        self.placeID = placeID
        self.mapView = mapView
        
        if let mapView = mapView {
            let center = mapView.region.center
            self._region = State(initialValue: MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        }
    }
    
    var body: some View {
        if #available(iOS 17.0, *) {
            Map(coordinateRegion: $region, showsUserLocation: false, annotationItems: [item].compactMap { $0 }) { item in
                MapMarker(coordinate: item.mapItem.placemark.coordinate, tint: .red)
            }
            .task {
                await fetchMapItem()
            }
        } else {
            // Fallback on earlier versions
            Text("Map feature is not supported on your device.")
                .padding()
                .foregroundColor(.red)
            if let item = item {
                Text("Location: \(item.mapItem.name ?? "Unknown")")
                    .font(.headline)
                    .padding()
            }
        }
    }
    
    func fetchMapItem() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = placeID
        
        let search = MKLocalSearch(request: request)
        do {
            let response = try await search.start()
            if let firstItem = response.mapItems.first {
                item = IdentifiableMapItem(mapItem: firstItem)
                
                region = MKCoordinateRegion(
                    center: firstItem.placemark.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
            }
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
