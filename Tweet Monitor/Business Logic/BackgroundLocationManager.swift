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
import UserNotifications

class BackgroundLocationManager: CLLocationManager {
	
	// TODO: Add callback block for location changes
	// DO NOT check for new tweets in this class
	override init() {
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
		let list = Constants.Twitter.travelList
		let keywords = Constants.tweetSearchStrings
		
		TweetKeywordMatcher.requestTweets(in: list, withTextContainingAnyOf: keywords) { possibleMatching, error in
			guard let matching = possibleMatching else {
				print(error ?? "No matching or error")
				return
			}
			
			let notificationText: String = {
				return matching.count > 0 ? "New Matching Tweets" : "Nothing Matching"
			}()
			print(notificationText)
			
			self.sendLocationNotification(text: notificationText)
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		guard status == .authorizedAlways else { return }
		
		startUpdatingLocation()
	}
}

fileprivate extension BackgroundLocationManager {
		
	func sendLocationNotification(text: String) {
		let center = UNUserNotificationCenter.current()
		
		let options: UNAuthorizationOptions = [.alert, .sound]
		
		center.requestAuthorization(options: options) {
			(granted, error) in
			guard granted else {
				print(error ?? "no granted")
				return
			}
			
			let content = UNMutableNotificationContent()
			content.title = text
			content.sound = UNNotificationSound.default()
			
			let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
															repeats: false)
			
			let identifier = "new tweets"
			let request = UNNotificationRequest(identifier: identifier,
												content: content, trigger: trigger)
			center.add(request, withCompletionHandler: { (error) in
				if let error = error {
					print(error)
				}
			})
		}
	}
	
}

