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
    let center = UNUserNotificationCenter.current()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Transparent background for every UITabBar.
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = UIColor.clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        // Notification settings.
        jesusSaysVC.getVerseOfToday { (verse) in
            if let verse = verse {
                let content = UNMutableNotificationContent()
                content.title = "يسوع بيقولك النهارده 🙏"
                content.body = verse
                content.sound = .default
                var date = DateComponents()
                date.hour = 00
                date.minute = 10
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: "JesusSaysNotification", content: content, trigger: trigger)
                
                self.center.add(request) { (error) in
                    if let error = error {
                        let errorString = String(format: NSLocalizedString("Unable to Add Notification Request %@, %@", comment: ""), error as CVarArg, error.localizedDescription)
                        print(errorString)
                    }
                }
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            //            First launch, setting UserDefault.
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            
            center.requestAuthorization(options: [.alert, .sound]) { (granted, denied) in
                if granted{
                    DispatchQueue.main.async {
                        // create the alert
                        let alert = UIAlertController(title: "ChristLife", message: "هيوصلك رسالة جديده من يسوع فى كل يوم جديد. 🙏", preferredStyle: UIAlertController.Style.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "اوك 🤗", style: UIAlertAction.Style.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        // create the alert
                        let alert = UIAlertController(title: "ChristLife", message: "لو عاوز يوصلك رسالة جديدة من يسوع فى كل يوم جديد، ادخل على الاعدادات -> ChristLife -> الاشعارات -> تفعيل الاشعارات.", preferredStyle: UIAlertController.Style.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction.init(title: "اوك 🤗", style: UIAlertAction.Style.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
}
