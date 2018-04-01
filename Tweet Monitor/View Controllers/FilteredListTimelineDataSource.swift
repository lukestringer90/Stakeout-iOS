//
//  FilteredListTimelineDataSource.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 30/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import TwitterKit

class FilteredListTimelineDataSource: TWTRListTimelineDataSource {
	
	let kewords: [String]
	
	init(listSlug: String, listOwnerScreenName: String, matching: [String], apiClient client: TWTRAPIClient) {
		self.kewords = matching
		super.init(listID: nil, listSlug: listSlug, listOwnerScreenName: listOwnerScreenName, apiClient: client, maxTweetsPerRequest: UInt(Constants.tweetsPerRequest), includeRetweets: true)
	}
	
	override func loadPreviousTweets(beforePosition position: String?, completion: @escaping TWTRLoadTimelineCompletion) {
		super.loadPreviousTweets(beforePosition: position) { (allTweets, cursor, error) in
			
			guard let tweets = allTweets else {
				completion(allTweets, cursor, error)
				return
			}
			
			let filteredTweets = tweets.match(containingAnyOf: self.kewords)
			
			completion(filteredTweets, cursor, error)
			
		}
	}
}
