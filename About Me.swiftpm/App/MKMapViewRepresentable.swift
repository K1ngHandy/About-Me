//  MKMapViewRepresentable.swift
//
//  Created by Steve Handy on 2024.10.24.
//

import SwiftUI
import MapKit

struct MKMapViewRepresentable: UIViewRepresentable {
	@Binding var mapView: MKMapView?
	@Binding var region: MKCoordinateRegion
	
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
		
		init(_ parent: MKMapViewRepresentable) {
			self.parent = parent
		}
	}
}

