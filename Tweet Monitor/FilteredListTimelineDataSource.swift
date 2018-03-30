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
	
	let searchStrings: [String]
	
	init(listSlug: String, listOwnerScreenName: String, searchStrings: [String], apiClient client: TWTRAPIClient) {
		self.searchStrings = searchStrings
		super.init(listID: nil, listSlug: listSlug, listOwnerScreenName: listOwnerScreenName, apiClient: client, maxTweetsPerRequest: 0, includeRetweets: true)
	}
	
	override func loadPreviousTweets(beforePosition position: String?, completion: @escaping TWTRLoadTimelineCompletion) {
		super.loadPreviousTweets(beforePosition: position) { (allTweets, cursor, error) in
			
			guard let tweets = allTweets else {
				completion(allTweets, cursor, error)
				return
			}
			
			let filteredTweets = tweets.filter { tweet -> Bool in
				
				for string in self.searchStrings {
					if tweet.text.range(of: string) != nil {
						return true
					}
				}
				
				return false
			}
			
			completion(filteredTweets, cursor, error)
			
		}
	}
}
