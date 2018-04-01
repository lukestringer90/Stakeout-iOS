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
	
	static let locationDistanceFilterMeters = 100
	static let tweetsPerRequest = 50
	
	struct Twitter {
		
		static let lukestringer90 = UserTag.screenName("lukestringer90")
        static let  kem_sorrell = UserTag.screenName("kem_sorrell")
		
        struct List {
            static var sheffieldTravel: ListTag = {
                return ListTag.slug("Travel", owner: lukestringer90)
            }()
            
            static var tweetMonitorTest: ListTag = {
                return ListTag.slug("TweetMonitorTest", owner: lukestringer90)
            }()
            
            static var verifiedAccounts: ListTag = {
                return ListTag.slug("verified-accounts", owner: kem_sorrell)
            }()
        }
	}
    
    struct Keywords {
        static let whitespace = [" "]
        static let tram = ["malin bridge", "city hall"]
        static let london = ["circle", "bakerloo"]
    }
	
}
