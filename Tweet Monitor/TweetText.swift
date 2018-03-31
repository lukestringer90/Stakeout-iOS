//
//  Tweet.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 31/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import TwitterKit

protocol TweetText {
	var text: String { get }
}

extension Sequence where Iterator.Element: TweetText {
	func keepTweets(containingAnyOf searchStrings: [String]) -> [Iterator.Element] {
		return filter { tweet -> Bool in
			
			for string in searchStrings {
				if tweet.text.lowercased().range(of: string.lowercased()) != nil {
					return true
				}
			}
			
			return false
		}
	}
}

extension String: TweetText {
	var text: String { return self }
}

extension TWTRTweet: TweetText {
}
