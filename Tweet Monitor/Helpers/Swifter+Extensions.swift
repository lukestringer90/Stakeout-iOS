//
//  Swifter+Extensions.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 31/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import Swifter
import Keys
import TwitterKit

extension Swifter {
	
	private static var sharedInstance: Swifter!
	
	@discardableResult static func setup(consumerKey: String = TweetMonitorKeys().twitterConsumerKey,
										 consumerSecret: String = TweetMonitorKeys().twitterConsumerSecret,
										 oauthToken: String,
										 oauthTokenSecret: String) -> Swifter {
		sharedInstance = Swifter(consumerKey: consumerKey,
								 consumerSecret: consumerSecret,
								 oauthToken: oauthToken,
								 oauthTokenSecret: oauthTokenSecret)
		return sharedInstance
	}
	
	static func shared() -> Swifter {
		return sharedInstance
	}
}

extension Swifter {
	
	@discardableResult static func setup(from session: TWTRAuthSession) -> Swifter {
		sharedInstance = Swifter.setup(oauthToken: session.authToken,
									   oauthTokenSecret: session.authTokenSecret)
		return sharedInstance
	}
	
}
