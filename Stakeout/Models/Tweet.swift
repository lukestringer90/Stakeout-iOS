//
//  Tweet.swift
//  Stakeout
//
//  Created by Luke Stringer on 01/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

struct Tweet: TweetText, Codable {
	let id: Int
	let text: String
}

extension Tweet: Comparable {
	static func < (lhs: Tweet, rhs: Tweet) -> Bool {
		return lhs.id < rhs.id
	}
	
	static func == (lhs: Tweet, rhs: Tweet) -> Bool {
		return lhs.id == rhs.id
	}
}
