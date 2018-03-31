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

class ViewController: TWTRTimelineViewController {
	
	var tweetView: TWTRTweetView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let session = TWTRTwitter.sharedInstance().sessionStore.session() else {
			login()
			return
		}
		Swifter.setup(from: session)
		setupTimeline()
	}
	
	func login() {
		TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
			guard let session = session else {
				let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle: .alert)
				self.show(alert, sender: nil)
				return
			}
			
			Swifter.setup(from: session)
			
			self.setupTimeline()
		})
	}
	
	func setupTimeline() {
		let list = Constants.Twitter.travelList
		
		guard let (slug, screenName) = list.slugAndOwnerScreenName() else {
			fatalError("Bad List or User Tag")
		}
		
		let searchStrings = Constants.tweetSearchStrings
		
		dataSource = FilteredListTimelineDataSource(listSlug: slug,
													listOwnerScreenName: screenName,
													matching: searchStrings,
													apiClient: TWTRAPIClient())
		title = slug

		
		
		
		Swifter.shared().listTweets(for: list, sinceID: nil, maxID: nil, count: nil, includeEntities: nil, includeRTs: nil, success: { json in
			
			guard let tweetsJSON = json.array else { return }
			
			let texts = tweetsJSON.compactMap { return $0["text"].string }
			
			let toKeep = texts.keepTweets(containingAnyOf: searchStrings)
			
			print(toKeep)
			
		}) { error in
			print(error)
		}

	}
}
