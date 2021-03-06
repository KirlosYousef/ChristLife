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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var verse: UILabel!
    let dailyVerses = DailyVerses()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ActivityIndicator
        self.activityIndicator.hidesWhenStopped = true
        view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        showVerseOfToday()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    /// Show today's verse.
    func showVerseOfToday(){
        getVerseOfToday { (verse) in
            self.activityIndicator.stopAnimating()
            if let verse = verse {
                self.verse.text = verse
            } else {
                self.verse.text = "مشكلة فى الاتصال بالانترنت."
            }
        }
    }
    
    
    func getVerseOfToday(completion: @escaping (String?)->()){
        // Check the current day number of the year
        let dayOfTheYear = Calendar.current.ordinality(of: .day, in: .year, for: Date())
        // Call the getVerseInfo function and set the returned verses to verses variable
        let verses = dailyVerses.getVerseInfo()
        // Choose the verse of the day according to the dayOfTheYear
        let verseOfToday = verses[dayOfTheYear!]
        
        // Get the Verse of the recived info
        DBT.getTextVerse(withDamId: verseOfToday.damID + "1ET", book: verseOfToday.bookID, chapter: verseOfToday.chapterID as NSNumber, verseStart: verseOfToday.verseID as NSNumber, verseEnd: nil, success: { (verse) in
            if let verse = verse as? [DBTVerse]{
                let currentVerse = verse[0]
                let fullVerse = currentVerse.verseText! +  "(\(currentVerse.bookName!)\(currentVerse.verseId!):\(currentVerse.chapterId!))"
                completion(fullVerse)
            }
        }) { (error) in
            completion(nil)
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
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
