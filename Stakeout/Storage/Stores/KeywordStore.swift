//
//  KeywordStore.swift
//  Stakeout
//
//  Created by Luke Stringer on 02/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

protocol KeywordStoreObserver {
    func store(_ store: KeywordStore, updated keywords: [Keyword])
}

extension Keyword: Storable {
    func encode() -> Data {
        return try! JSONEncoder().encode(self)
    }
    
    static func decode(from data: Data) -> Keyword {
        return try! JSONDecoder().decode(Keyword.self, from: data)
    }
}

class KeywordStore {
	var observer: KeywordStoreObserver?
	static let shared = KeywordStore()
}


extension KeywordStore: Storage {
    static var key = "keywords"
    
    typealias Entity = Keyword
    
    func didUpdate(to entities: [Entity]) {
        observer?.store(self, updated: entities)
    }
}

