//
//  ListStorage.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 02/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

class ListStore {
    private static let storageKey = "list"
    
    static let shared: ListStore = {
        let store = ListStore()
        store.storedList = {
            guard
                let stored = UserDefaults.standard.object(forKey: ListStore.storageKey) as? Data,
                let decoded = try? JSONDecoder().decode(List.self, from: stored)
            else {
                return nil
            }
            return decoded
        }()
        
        return store
    }()
    
    fileprivate var storedList: List? = nil {
        didSet {
            guard let encoded = try? JSONEncoder().encode(storedList) else { return }
            UserDefaults.standard.set(encoded, forKey: ListStore.storageKey)
        }
    }
}

extension ListStore: ListStorage {
    func add(_ list: List) {
        storedList = list
    }
    
    func remove() {
        storedList = nil
    }
    
    var list: List? {
        return storedList
    }
}
