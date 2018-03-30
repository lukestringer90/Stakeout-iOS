//
//  AppDelegate.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 30/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import UIKit
import TwitterKit
import Keys

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        TWTRTwitter.sharedInstance().start(withConsumerKey: TweetMonitorKeys().twitterConsumerKey,
                                           consumerSecret:TweetMonitorKeys().twitterConsumerSecret)
        
        return true
    }
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
	}
}

