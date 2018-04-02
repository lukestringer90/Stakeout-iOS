//
//  Models.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 31/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import Swifter

struct List: Codable {
    let id: Int
    let slug: String
    let name: String
    let ownerScreenName: String
}

extension List {
    var listTag: ListTag {
        get {
            return .slug(slug, owner: .screenName(ownerScreenName))
        }
    }
}

extension List: Equatable {
    static func == (lhs: List, rhs: List) -> Bool {
        return lhs.id == rhs.id
    }
}
