/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI
import MapKit

struct IdentifiableMapItem: Identifiable {
    let id = UUID()
    let mapItem: MKMapItem
}

//    Create map view
struct MapView: View {
    var placeID: String
    
	@State private var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(latitude: 40.1013, longitude: -75.3836),
		span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
	)
	
	@State private var mapView: MKMapView? // reference to UIKit MKMapView
	@StateObject private var locationManager = LocationManager()
    
    var body: some View {
		VStack {
			if #available(iOS 17.0, *) {
				Text("Current View:")
					.padding()
					.font(.largeTitle)
					.fontWeight(.bold)
				MKMapViewRepresentable(mapView: $mapView, region: $region)
					.frame(height: 450)
					.task {
						await fetchMapItem()
					}
				
				Button(action: centerOnUserLocation) {
					Label("Center Map", systemImage: "location.fill")
				}
				.padding(9)
				.background(Color.blue)
				.foregroundColor(.white)
				.clipShape(Capsule())
			} else {
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
					mapView?.setRegion(region, animated: true)
            }
    } catch {
            print("Error fetching map item: \(error.localizedDescription)")
        }
    }
	
	func centerOnUserLocation() {
		guard let userLocation = locationManager.userLocation else { return }
		region = MKCoordinateRegion(
			center: userLocation,
			span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
		)
		mapView?.setRegion(region, animated: true)
	}
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(placeID: "king_of_prussia")
    }
}
