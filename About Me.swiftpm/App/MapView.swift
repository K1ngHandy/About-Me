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
    
	@State private var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059),
		span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
	)
	
	@State private var mapView: MKMapView? // reference to UIKit MKMapView
    
    var body: some View {
		VStack {
			if #available(iOS 17.0, *) {
				MKMapViewRepresentable(mapView: $mapView, region: $region)
					.frame(height: 400)
					.task {
						await fetchMapItem()
					}
			} else {
				// Fallback on earlier versions
				Text("Map feature is not supported on your device.")
					.padding()
					.foregroundColor(.red)
				if let mapView = mapView {
					Text("Location: \(mapView.region.center.latitude), \(mapView.region.center.longitude)")
						.font(.headline)
						.padding()
				}
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
                let coordinate = firstItem.placemark.coordinate
                region = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
//					update mapView region manually
					mapView?.setRegion(region, animated: true)
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
