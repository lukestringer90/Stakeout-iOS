//
//  Swifter+Extensions.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 31/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import Swifter

extension Swifter {
	
	private static var sharedInstance: Swifter!
	
	@discardableResult static func setup(consumerKey: String, consumerSecret: String) -> Swifter {		
		sharedInstance = Swifter(consumerKey: consumerKey, consumerSecret: consumerSecret)
		return sharedInstance
	}
	
	static func shared() -> Swifter {
		return sharedInstance
	}
	
}
