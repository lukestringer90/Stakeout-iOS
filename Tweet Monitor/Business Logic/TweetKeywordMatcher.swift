//
//  TweetKeywordMatcher.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 01/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import Swifter

struct TweetKeywordMatcher {
	
	enum Error: Swift.Error {
		case invalidJSON
	}
	
	typealias TweetsCompletion = (_ newTweets: [TweetText]?, _ error: Swift.Error?) -> ()
	
	static func requestTweets(in list: ListTag, withTextContainingAnyOf keywords: [String], completion: @escaping TweetsCompletion) {
		
		Swifter.shared().listTweets(for: list, success: { json in
			
			guard let tweetsJSON = json.array else {
				completion(nil, Error.invalidJSON)
				return
			}
			
			let texts = tweetsJSON.flatMap { return $0["text"].string }
			let matching = texts.match(containingAnyOf: keywords)
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
				   count: nil,
				   includeEntities: nil,
				   includeRTs: true,
				   success: success,
				   failure: failure)
	}
}
