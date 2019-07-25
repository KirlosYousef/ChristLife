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
    
    var currentVolume = "ARZVDVO"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
    }
    
    // Getting the Bible books
    func getBooks() {
        DBT.getLibraryBook(withDamId: currentVolume, success: { (books) in
            if let books = books {
                let currentBook = books[Int.random(in: 0..<books.count)] as! DBTBook
                self.getChapters(currentBook: currentBook)
            }
        }) { (error) in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    // Getting the Book Chapters
    func getChapters(currentBook: DBTBook) {
        DBT.getLibraryChapter(withDamId: currentVolume, bookId: currentBook.bookId, success: { libraryChapters in
            if let chapters = libraryChapters {
                let currentChapter = chapters[Int.random(in: 0..<chapters.count)] as! DBTChapter
                self.getVerses(currentBook: currentBook, currentChapter: currentChapter)
            }
        }, failure: { error in
            if let error = error {
                print("Error: \(error)")
            }
        })
    }
    
    // Getting the Chapter verses
    func getVerses(currentBook: DBTBook,currentChapter: DBTChapter) {
        //checking for the right volume code!
        if !currentVolume.contains("1ET"){
            currentVolume = currentVolume+"1ET"}
        
        DBT.getTextVerse(withDamId: currentVolume, book: currentBook.bookId, chapter: Int(currentChapter.chapterId) as NSNumber?, verseStart: nil, verseEnd: nil, success: { (verses) in
            if let verses = verses {
                let randomVerse = verses[Int.random(in: 0..<verses.count)] as! DBTVerse
                self.setRandomVerse(randomVerse: randomVerse, book: currentBook.bookName, chapter: currentChapter.chapterId)
            }
        }) { (error) in
            if let error = error {
                print("Error \(error)")
            }
        }
    }
    
    // Setting the generated random verse on the label
    func setRandomVerse(randomVerse: DBTVerse, book: String, chapter: String ){
        verse.text = "\(randomVerse.verseText!)(\(book)\(chapter):\(randomVerse.verseId!))"
    }
    
    @IBAction func newVerseButton(_ sender: Any) {
        self.verse.text = "جار التحميل..."
        getBooks()
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        // text to share
        let text = verse.text
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
}
