//
//  BackgroundLocationManager.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 01/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import CoreLocation
import Swifter

class BackgroundLocationManager: CLLocationManager {
	
	typealias LocationsUpdatedCallback = (_ locations: [CLLocation]) -> ()
	
	let callback: LocationsUpdatedCallback

	init(callback: @escaping LocationsUpdatedCallback) {
		self.callback = callback
		super.init()
		delegate = self
		allowsBackgroundLocationUpdates = true
		desiredAccuracy = kCLLocationAccuracyHundredMeters
		distanceFilter = 100
		startUpdatingLocation()
		
		if CLLocationManager.authorizationStatus() != .authorizedAlways {
			requestAlwaysAuthorization()
		}
	}
}

extension BackgroundLocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		callback(locations)
	}
}

