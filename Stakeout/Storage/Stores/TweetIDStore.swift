//
//  TweetIDStore.swift
//  Stakeout
//
//  Created by Luke Stringer on 01/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

extension Tweet.ID: Storable {
    func encode() -> Data {
        return "\(self)".data(using: .utf8)!
    }
    
    static func decode(from data: Data) -> Tweet.ID {
        let string = String.init(data: data, encoding: .utf8)!
        return Int(string)!
    }
}

class TweetIDStore: Storage {
    
    typealias Entity = Tweet.ID
    
    static let shared = TweetIDStore()
    
    static var key: String {
        return "tweetids"
    }
    
    func contains(_ id: Tweet.ID) -> Bool {
        return all().contains(id)
    }
    
    func add(_ entities: [Tweet.ID]) {
        entities.forEach { add($0) }
    }
}
