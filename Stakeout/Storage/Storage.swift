//
//  Storage.swift
//  Stakeout
//
//  Created by Luke Stringer on 04/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

protocol Storage {
    associatedtype Entity: Storable
    
    static var key: String { get }
    
    func add(_ entity: Entity)
    func remove(_ entity: Entity)
    func all() -> [Entity]
    func reset()
    func didUpdate(to entities: [Entity])
}


protocol Storable {
    func encode() -> Data
    static func decode(from data: Data) -> Self
}

extension Storage {
    
    func add(_ entity: Entity) {
        let toStore = allAsData() + [entity.encode()]
        setStored(toStore)
    }
    
    func remove(_ entity: Entity) {
        var toStore = allAsData()
        guard let index = toStore.index(of: entity.encode()) else { return }
        toStore.remove(at: index)
        setStored(toStore)
    }
    
    func all() -> [Entity] {
        return allAsData().compactMap { Entity.decode(from: $0) }
    }
    
    func reset() {
        setStored([Data]())
    }
    
    private func allAsData() -> [Data] {
        let allData: [Data] = {
            guard let current = UserDefaults.standard.array(forKey: Self.key) as? [Data] else { return [Data]() }
            return current
        }()
        return allData
    }
    
    private func setStored(_ toStore: [Data]) {
        UserDefaults.standard.set(toStore, forKey: Self.key)
        didUpdate(to: all())
    }
    
}
