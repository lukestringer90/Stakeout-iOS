//
//  NotificationSender.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 01/04/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import Foundation
import UserNotifications

struct NotificationSender {
	
	static func sendNotification(withText text: String) {
		let center = UNUserNotificationCenter.current()
		
		let options: UNAuthorizationOptions = [.alert, .sound]
		
		center.requestAuthorization(options: options) {
			(granted, error) in
			guard granted else {
				print(error ?? "no granted")
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
