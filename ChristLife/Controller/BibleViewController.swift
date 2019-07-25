//
//  BibleViewController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 22..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit
import dbt_sdk

protocol isAbleToReceiveData{
    func pass(book: String, chapter: Int)
}

class BibleViewController: UIViewController, isAbleToReceiveData{
    
    @IBOutlet weak var biblePageTitle: UINavigationItem!
    @IBOutlet weak var versesTextView: UITextView!
    var verses: [DBTVerse] = []
    var text: String = ""
    var currentBookID: String = "Gen"
    var currentBookName: String = ""
    var currentChapter: Int = 1
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bibleToBooksSegue"{
            let BooksVC = segue.destination as! BooksTableViewController
            BooksVC.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func pass(book: String, chapter: Int) {
        self.currentBookID = book
        self.currentChapter = chapter
    }
    
    
    func data(verses: [DBTVerse]) {
        text = ""
        for verse in verses{
            if let chapter: Int = verse.verseId?.intValue{
                text.append(String(chapter))
                text.append(verse.verseText)
            }
        }
        currentBookName = verses[0].bookName
        updateData(text: text)
    }
    
    func updateData(text: String){
        if let textView = self.versesTextView {
            textView.text = text
            self.biblePageTitle.title = "\(currentBookName) \(currentChapter)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getVerses(book: self.currentBookID, Chapter: NSNumber(value: self.currentChapter))
    }
    
    
    
    func getVerses(book: String, Chapter: NSNumber) {
        DBT.getTextVerse(withDamId: "ARBWTCO1ET", book: book, chapter: Chapter, verseStart: nil, verseEnd: nil, success: { (verse) in
            if let verse = verse {
                self.verses = verse as! [DBTVerse]
                self.data(verses: self.verses)
            }
        }) { (error) in
            if let error = error {
                print("Error \(error)")
            }
        }
    }
    
}
