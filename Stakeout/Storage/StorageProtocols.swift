//
//  StorageProtocols.swift
//  Stakeout
//
//  Created by Luke Stringer on 04/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

protocol ListStorage {
    func add(_ list: List)
    func remove()
    var list: List? { get }
}

protocol TweetIDStorage {
    func add(_ tweetID: Tweet.ID)
    func add(_ tweetIDs: [Tweet.ID])
    func contains(_ tweetID: Tweet.ID) -> Bool
    func removeAll()
}
