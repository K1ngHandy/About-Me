//  MKMapViewRepresentable.swift
//
//  Created by Steve Handy on 2024.10.24.
//

import SwiftUI
import MapKit
import CoreLocation

struct MKMapViewRepresentable: UIViewRepresentable {
    @Binding var mapView: MKMapView?
    @Binding var region: MKCoordinateRegion
    @Binding var selectionText: String
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        // Capture reference for external updates
        self.mapView = mapView
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MKMapViewRepresentable
        private let geocoder = CLGeocoder()
        
        init(_ parent: MKMapViewRepresentable) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let center = mapView.region.center
            let location = CLLocation(latitude: center.latitude, longitude: center.longitude)

            // Cancel any ongoing geocoding to avoid backlog
            if geocoder.isGeocoding {
                geocoder.cancelGeocode()
            }

            geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                guard let self = self else { return }
                if let placemark = placemarks?.first {
                    // Prefer locality (city/town), fallback to subAdministrativeArea or name
                    let name = placemark.locality ?? placemark.subAdministrativeArea ?? placemark.name ?? ""
                    DispatchQueue.main.async {
                        self.parent.selectionText = name
                    }
                } else if let error = error {
                    print("Reverse geocode error: \(error.localizedDescription)")
                }
            }
        }
    }
}

