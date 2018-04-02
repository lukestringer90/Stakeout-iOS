//
//  KeywordStore.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 02/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

class KeywordStore {
    static let shared = KeywordStore()
    fileprivate var storedKeywords = [String]()
}

extension KeywordStore: KeywordStorage {
    func add(_ keyword: Keyword) {
        storedKeywords.insert(keyword.text, at: keyword.index)
    }
    
    func remove(_ keyword: Keyword) {
        storedKeywords.remove(at: keyword.index)
    }
    
    var keywords: [Keyword] {
        return storedKeywords.enumerated().map { index, text in
            return Keyword(text: text, index: index)
        }
    }
}
