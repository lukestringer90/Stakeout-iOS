//
//  ListStorage.swift
//  Stakeout
//
//  Created by Luke Stringer on 02/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

protocol ListStoreObserver {
    func store(_ store: SelectedListStore, updated list: List?)
}

extension List: Storable {
    
    func encode() -> Data {
        return try! JSONEncoder().encode(self)
    }
    
    static func decode(from data: Data) -> List {
        return try! JSONDecoder().decode(List.self, from: data)
    }
    
}

class SelectedListStore {
	
    var observer: ListStoreObserver?
    static let shared = SelectedListStore()
    
    var list: List? {
        return all().first
    }
}

extension SelectedListStore: Storage {
	static var key = "selected-list"
	
	typealias Entity = List
	
	func replace(with list: List) {
		reset()
		add(list)
	}
	
	func didUpdate(to entities: [Entity]) {
		observer?.store(self, updated: entities.first)
	}
}
