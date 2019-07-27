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
        center.requestAuthorization(options: [.alert, .sound]) { (granted, denied) in
            if granted{
                // create the alert
                let alert = UIAlertController(title: "ChristLife", message: "هيوصلك رسالة جديده من يسوع فى كل يوم جديد. 🙏", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "اوك 🤗", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else{
                // create the alert
                let alert = UIAlertController(title: "ChristLife", message: "لو عاوز يوصلك رسالة جديدة من يسوع فى كل يوم جديد، فعل الاشعارات من الاعدادات -> ChristLife -> الاشعارات -> تفعيل الاشعارات.", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction.init(title: "اوك 🤗", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        jesusSays.getVerseOfToday { (verse) in
            if let verse = verse {
                let content = UNMutableNotificationContent()
                content.title = "يسوع انهاردة بيقولك 🙏"
                content.body = verse
                content.sound = .default
                var date = DateComponents()
                date.hour = 00
                date.minute = 00
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
//                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: "JesusSaysNotification", content: content, trigger: trigger)
                
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
