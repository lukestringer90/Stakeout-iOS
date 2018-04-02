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

class TimelineViewController: TWTRTimelineViewController {
	
	var locationManager: BackgroundLocationManager!
	
    var list: List?
	let keywords = Constants.Keywords.whitespace

	override func viewDidLoad() {
		super.viewDidLoad()
        
        setupMockData()
		
		guard let session = TWTRTwitter.sharedInstance().sessionStore.session() else {
			login()
			return
		}
		
		startWith(session: session)

		TWTRTweetView.appearance().showActionButtons = false
	}
    
    func setupMockData() {
        let listTag = Constants.Twitter.List.sheffieldTravel
        let (slug, screenName) = listTag.slugAndOwnerScreenName()!
        
        list = List(id: 0, slug: slug, name: slug, ownerScreenName: screenName)
    }
}

fileprivate extension TimelineViewController {
    @IBAction func unwind(_:UIStoryboardSegue) { }
}

// MARK: - Setup
fileprivate extension TimelineViewController {
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
        guard let selectedList = list else {
            showListSelection()
            return
        }
        
		Swifter.setup(from: session)
		locationManager = BackgroundLocationManager(callback: locationUpdated)
        setupTimeline(with: selectedList)
	}
	
    func setupTimeline(with list: List) {
		
		guard let (slug, screenName) = list.listTag.slugAndOwnerScreenName() else {
			fatalError("Bad List or User Tag")
		}
		
		dataSource = FilteredListTimelineDataSource(listSlug: slug,
													listOwnerScreenName: screenName,
													matching: keywords,
													apiClient: TWTRAPIClient())
		title = slug
	}
    
    func showListSelection() {
        // TODO: Seque to list selection
        print("Show list selection")
    }
}

// MARK: - Location updates
fileprivate extension TimelineViewController {
	func locationUpdated(with locations: [CLLocation]) {
        
        guard let selectedList = list else {
            showListSelection()
            return
        }
		
        let matcher = TweetKeywordMatcher(store: TweetIDStore.shared)
        
		matcher.requestTweets(in: selectedList.listTag, withTextContainingAnyOf: keywords) { possibleMatching, error in
			guard let matching = possibleMatching else {
				print(error ?? "No matching or error")
				return
			}
			
			if matching.count > 0 {
				print("\(matching.count) new tweets Matching: \(self.keywords)")
				print("\(matching.map { $0.text })")
				NotificationSender.sendNotification(title: "New Matching Tweets", subtitle: matching.first!.text)
				self.refresh()
			}
		}
	}
}
