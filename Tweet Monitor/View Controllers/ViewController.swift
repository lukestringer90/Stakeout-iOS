//
//  ViewController.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 30/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import UIKit
import TwitterKit
import Swifter
import CoreLocation

class ViewController: TWTRTimelineViewController {
	
	var tweetView: TWTRTweetView!
	var locationManager: BackgroundLocationManager!
	
	let list = Constants.Twitter.travelList
	let keywords = Constants.tweetSearchStrings

	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let session = TWTRTwitter.sharedInstance().sessionStore.session() else {
			login()
			return
		}
		
		startWith(session: session)
	}
}

// MARK: - Setup
fileprivate extension ViewController {
	func login() {
		TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
			guard let session = session else {
				let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle: .alert)
				self.show(alert, sender: nil)
				return
			}
			
			self.startWith(session: session)
		})
	}
	
	func startWith(session: TWTRAuthSession) {
		Swifter.setup(from: session)
		locationManager = BackgroundLocationManager(callback: locationUpdated)
		setupTimeline()
	}
	
	func setupTimeline() {
		
		guard let (slug, screenName) = list.slugAndOwnerScreenName() else {
			fatalError("Bad List or User Tag")
		}
		
		dataSource = FilteredListTimelineDataSource(listSlug: slug,
													listOwnerScreenName: screenName,
													matching: keywords,
													apiClient: TWTRAPIClient())
		title = slug
	}
}

// MARK: - Location updates
fileprivate extension ViewController {
	func locationUpdated(with locations: [CLLocation]) {
		
		TweetKeywordMatcher.requestTweets(in: list, withTextContainingAnyOf: keywords) { possibleMatching, error in
			guard let matching = possibleMatching else {
				print(error ?? "No matching or error")
				return
			}
			
			let notificationText: String = {
				return matching.count > 0 ? "New Matching Tweets" : "Nothing Matching"
			}()
			print(notificationText)
			
			NotificationSender.sendNotification(withText: notificationText)
		}
	}
}
