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
		checkForNewTweets()
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		guard status == .authorizedAlways else { return }
		
		startUpdatingLocation()
	}
}

fileprivate extension BackgroundLocationManager {
	
	typealias CheckForNewTweetsCompletion = (_ newTweets: [TweetText]?, _ error: Error?) -> ()
	
	func checkForNewTweets(completion: CheckForNewTweetsCompletion? = nil) {
		let list = Constants.Twitter.travelList
		let searchStrings = Constants.tweetSearchStrings
		
		Swifter.shared().listTweets(for: list, sinceID: nil, maxID: nil, count: nil, includeEntities: nil, includeRTs: nil, success: { json in
			
			guard let tweetsJSON = json.array else { return }
			
			let texts = tweetsJSON.compactMap { return $0["text"].string }
			
			let toKeep = texts.keepTweets(containingAnyOf: searchStrings)
			
			if toKeep.count > 0 {
				self.sendLocationNotification(text: "New Tweets")
			}
			else {
				self.sendLocationNotification(text: "No New Tweets")
			}
			
			print("Found \(toKeep.count) matching tweets")
			
			completion?(toKeep, nil)
			
		}) { error in
			completion?(nil, error)
		}
		
	}
	
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

