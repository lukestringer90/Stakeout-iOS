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
import Swifter
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
        TWTRTwitter.sharedInstance().start(withConsumerKey: TweetMonitorKeys().twitterConsumerKey,
                                           consumerSecret: TweetMonitorKeys().twitterConsumerSecret)
		
		application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        return true
    }
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
		return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
	}
	
	func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		
		let list = Constants.Twitter.travelList
		let searchStrings = Constants.tweetSearchStrings
		
		Swifter.shared().listTweets(for: list, sinceID: nil, maxID: nil, count: nil, includeEntities: nil, includeRTs: nil, success: { json in
			
			guard let tweetsJSON = json.array else { return }
			
			let texts = tweetsJSON.compactMap { return $0["text"].string }
			
			let toKeep = texts.keepTweets(containingAnyOf: searchStrings)
			
			print("Found \(toKeep.count) matching tweets")
			
			let result: UIBackgroundFetchResult = {
				if toKeep.count > 0 {
					
					self.sendLocationNotification(text: "New Tweets")
					
					return .newData
				}
				self.sendLocationNotification(text: "Fecth Found No New Tweets")
				return .noData
			}()
			
			completionHandler(result)
			
		}) { error in
			print(error)
			
			completionHandler(.failed)
		}

	}
	
	private func sendLocationNotification(text: String) {
		let center = UNUserNotificationCenter.current()
		
		let options: UNAuthorizationOptions = [.alert, .sound]
		
		center.requestAuthorization(options: options) {
			(granted, error) in
			guard granted else {
				print(error)
				return
			}
			
			let content = UNMutableNotificationContent()
			content.title = text
			content.sound = UNNotificationSound.default()
			
			let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
															repeats: false)
			
			let identifier = "new tweets"
			let request = UNNotificationRequest(identifier: identifier,
												content: content, trigger: trigger)
			center.add(request, withCompletionHandler: { (error) in
				if let error = error {
					print(error)
				}
			})
		}
	}
}

