//
//  KeywordStore.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 02/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

protocol StoreObserver {
    func store(_ store: KeywordStore, updated keywords: [Keyword])
}

class KeywordStore {
    private static let storageKey = "keywords"
    
    var observer: StoreObserver?
    
    static let shared: KeywordStore = {
        let store = KeywordStore()
        store.storedTexts = {
            if let stored = UserDefaults.standard.object(forKey: KeywordStore.storageKey) as? [String] {
                return stored
            }
            return [String]()
        }()
        
        return store
    }()
    
    fileprivate var storedTexts = [String]() {
        didSet {
            UserDefaults.standard.set(storedTexts, forKey: KeywordStore.storageKey)
            observer?.store(self, updated: keywords)
        }
    }
}

extension KeywordStore: KeywordStorage {
    func add(_ keyword: Keyword) {
        storedTexts.insert(keyword.text, at: keyword.index)
    }
    
    func remove(_ keyword: Keyword) {
        storedTexts.remove(at: keyword.index)
    }
    
    var keywords: [Keyword] {
        return storedTexts.enumerated().map { index, text in
            return Keyword(text: text, index: index)
        }
    }
}
