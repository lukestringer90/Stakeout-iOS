//
//  Configuration.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 31/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import Swifter

struct Constants {
	
	struct Twitter {
		
		static let lukestringer90 = UserTag.screenName("lukestringer90")
		
		static var travelList: ListTag = {
			return ListTag.slug("TweetMonitorTest", owner: lukestringer90)
		}()
	}
	
	static let tweetSearchStrings = ["circle", "bakerloo"]
	
}
