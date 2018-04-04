//
//  TweetKeywordMatcher.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 01/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import Swifter

protocol TweetIDStorage {
	func add(_ tweetID: Tweet.ID)
	func add(_ tweetIDs: [Tweet.ID])
	func contains(_ tweetID: Tweet.ID) -> Bool
	func removeAll()
}

struct TweetKeywordMatcher {
	
	let store: TweetIDStorage
	
	enum Error: Swift.Error {
		case invalidJSON
	}
	
	typealias TweetsCompletion = (_ newTweets: [TweetText]?, _ error: Swift.Error?) -> ()
	
	func requestTweets(in list: ListTag, withTextContainingAnyOf keywords: [String], completion: @escaping TweetsCompletion) {
		
		Swifter.shared().listTweets(for: list, success: { json in
			
			guard let tweetsJSON = json.array else {
				completion(nil, Error.invalidJSON)
				return
			}
			
			let unseenTweets = tweetsJSON
				.filter { json in
					guard let tweetID = json["id"].integer else { return false }
					return !self.store.contains(tweetID)
				}
				.compactMap { json -> Tweet? in
					guard
						let id = json["id"].integer,
						let text = json["text"].string
						else { return nil }
					return Tweet(id: id, text: text)
			}
			let matching = unseenTweets.match(containingAnyOf: keywords)
			
			// Make a tweet object
			self.store.add(matching.map { $0.id })
			
			completion(matching, nil)
			
		}) { error in
			completion(nil, error)
		}
		
	}
}

fileprivate extension Swifter {
	// Convenience function reducing number of nil arguments
	func listTweets(for listTag: ListTag, success: SuccessHandler?, failure: FailureHandler?) {
		listTweets(for: listTag,
				   sinceID: nil,
				   maxID: nil,
				   count: Constants.tweetsPerRequest,
				   includeEntities: nil,
				   includeRTs: true,
				   success: success,
				   failure: failure)
	}
}
