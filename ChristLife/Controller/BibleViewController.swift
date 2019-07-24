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

    var verses: [DBTVerse] = []
    var text: String = ""
    var currentBook: String = "Ruth"
    var currentChapter: Int = 1

    @IBOutlet weak var versesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bible"
    }
    
    
    func pass(book: String, chapter: Int) {
        self.currentBook = book
        self.currentChapter = chapter
        }


    func data(verses: [DBTVerse]) {
        for verse in verses{
            if let chapter: Int = verse.verseId?.intValue{
            text.append(String(chapter))
            text.append(verse.verseText)
            }
        }
        updateData(text: text)
    }

    func updateData(text: String){
        if let textView = self.versesTextView {
        textView.text = text
        textView.setNeedsDisplay()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getVerses(book: self.currentBook, Chapter: NSNumber(value: self.currentChapter))
        
        print(currentBook, currentChapter)
        // current output "test" "1"
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
