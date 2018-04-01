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
		
        struct List {
            static var sheffieldTravel: ListTag = {
                return ListTag.slug("Travel", owner: lukestringer90)
            }()
            
            static var tweetMonitorTest: ListTag = {
                return ListTag.slug("TweetMonitorTest", owner: lukestringer90)
            }()
        }
	}
    
    struct Keywords {
        static let whitespace = [" "]
        static let tram = ["malin bridge", "city hall"]
        static let london = ["circle", "bakerloo"]
    }
	
}
