//
//  Keyword.swift
//  Stakeout
//
//  Created by Luke Stringer on 02/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation

struct Keyword {
    let text: String
    let index: Int
}

extension Keyword: Comparable {
    static func < (lhs: Keyword, rhs: Keyword) -> Bool {
        return lhs.index < rhs.index
    }
    
    static func == (lhs: Keyword, rhs: Keyword) -> Bool {
        return lhs.index == rhs.index
    }
}
