//
//  TweetIDStore.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 01/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

struct TweetIDStore: TweetIDStorage {
    private static let tweetIDsKey = "TweetIDsKey"
    static let shared = TweetIDStore()
	
	init() {
		setStoredTweetIDs([])
	}
    
    func add(_ tweetID: Tweet.ID) {
        add([tweetID])
    }
    
    func add(_ tweetIDs: [Tweet.ID]) {
        let appended = stored + tweetIDs
		setStoredTweetIDs(appended)
    }
    
    func contains(_ tweetID: Tweet.ID) -> Bool {
        return stored.contains(tweetID)
    }
    
    func removeAll() {
        setStoredTweetIDs(nil)
    }
}

fileprivate extension TweetIDStore {
	var stored: [Tweet.ID] {
		get {
			guard let stored = UserDefaults.standard.array(forKey: TweetIDStore.tweetIDsKey) as? [Tweet.ID] else { fatalError("No sotrage for tweet IDs") }
			return stored
		}
	}
	
	func setStoredTweetIDs(_ tweetsIDs: [Tweet.ID]?) {
		UserDefaults.standard.set(tweetsIDs, forKey: TweetIDStore.tweetIDsKey)
	}
}
