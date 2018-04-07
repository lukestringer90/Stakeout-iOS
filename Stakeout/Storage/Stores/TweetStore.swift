//
//  TweetIDStore.swift
//  Stakeout
//
//  Created by Luke Stringer on 01/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

extension Tweet: Storable {
	func encode() -> Data {
		return try! JSONEncoder().encode(self)
	}
	
	static func decode(from data: Data) -> Tweet {
		return try! JSONDecoder().decode(Tweet.self, from: data)
	}
}

class TweetStore {
	
	func contains(_ tweet: Tweet) -> Bool {
		return all().contains(tweet)
	}
	
	func containsTweet(with id: Int) -> Bool {
		return all().contains(where: { $0.id == id })
	}
	
	func add(_ entities: [Tweet]) {
		entities.forEach { add($0) }
	}
}

extension TweetStore: Storage {
    
    typealias Entity = Tweet
    
    static let shared = TweetStore()
    
    static var key = "tweets"
}
