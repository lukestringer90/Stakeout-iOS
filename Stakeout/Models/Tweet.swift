//
//  Tweet.swift
//  Stakeout
//
//  Created by Luke Stringer on 01/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

struct Tweet: TweetText {
	typealias ID = Int
	
	let id: Tweet.ID
	let text: String
}
