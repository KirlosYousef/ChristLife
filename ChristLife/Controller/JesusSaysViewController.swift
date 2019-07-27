//
//  JesusSaysViewController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 25..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit
import dbt_sdk

class JesusSaysViewController: UIViewController {
    
    @IBOutlet weak var verse: UILabel!
    
    let dailyVerses = DailyVerses()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVerseOfToday { (verse) in
            
            self.verse.text = "جار التحميل..."
     
            self.verse.text = verse
        }
    }
    
    func getVerseOfToday(completion: @escaping (String?)->()){
        // Check the current day number of the year
        let dayOfTheYear = Calendar.current.ordinality(of: .day, in: .year, for: Date())
        // Call the getVerseInfo function and set the returned verses to verses variable
        let verses = dailyVerses.getVerseInfo()
        let verseOfToday = verses[dayOfTheYear!]
        
        // Get the Verse of the recived info
        DBT.getTextVerse(withDamId: verseOfToday.damID + "1ET", book: verseOfToday.bookID, chapter: verseOfToday.chapterID as NSNumber, verseStart: verseOfToday.verseID as NSNumber, verseEnd: nil, success: { (verse) in
            if let verse = verse as? [DBTVerse]{
                let currentVerse = verse[0]
                let fullVerse = currentVerse.verseText! +  "(\(currentVerse.bookName!)\(currentVerse.chapterId!):\(currentVerse.verseId!))"
                completion(fullVerse)
            }
        }) { (error) in
            if let error = error{
                print(error)
            }
        }
    }
    
    @IBAction func shareButton(_ sender: Any) {
        // verse to share
        let verseText = verse.text
        
        // set up activity view controller
        let verseToShare = [ verseText ]
        let activityViewController = UIActivityViewController(activityItems: verseToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
}
