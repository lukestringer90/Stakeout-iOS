//
//  AppDelegate.swift
//  Stakeout
//
//  Created by Luke Stringer on 30/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import UIKit
import TwitterKit
import Keys
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
        Twitter.sharedInstance().start(withConsumerKey: StakeoutKeys().twitterConsumerKey,
                                           consumerSecret: StakeoutKeys().twitterConsumerSecret)
		
		MSAppCenter.start(StakeoutKeys().appCenterAppSecret, withServices: [MSAnalytics.self, MSCrashes.self])
		
        return true
    }
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		return Twitter.sharedInstance().application(app, open: url, options: options)
	}
}

