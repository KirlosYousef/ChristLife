//
//  ChristLifeTabBarController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 26..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit
import UserNotifications

class ChristLifeTabBarController: UITabBarController {
    
    let jesusSaysVC = JesusSaysViewController()
    
    let jesusSays = JesusSaysViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
        
        jesusSays.getVerseOfToday { (verse) in
            if let verse = verse {
                let content = UNMutableNotificationContent()
                content.title = "يسوع انهاردة بيقولك 🙏"
                
                content.body = verse
                content.sound = .default
                var date = DateComponents()
                date.hour = 08
                date.minute = 00
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                //        let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: "JesusSaysNotfication", content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if let error = error {
                        let errorString = String(format: NSLocalizedString("Unable to Add Notification Request %@, %@", comment: ""), error as CVarArg, error.localizedDescription)
                        print(errorString)
                    }
                }
            }
        }
    }
}
