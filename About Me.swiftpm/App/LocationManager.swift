//
//  LocationManager.swift
//  About Me
//
//  Created by Steve Handy on 2024.10.26.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
	@Published var userLocation: CLLocationCoordinate2D?
	private var locationManager = CLLocationManager()
	
	override init() {
		super.init()
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		userLocation  = locations.first?.coordinate
	}
}
