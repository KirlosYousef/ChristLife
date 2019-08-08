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
    func pass(volume: String, book: String, chapter: Int)
}

class BibleViewController: UIViewController, isAbleToReceiveData{
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var booksButtonOutlet: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var biblePageTitle: UINavigationItem!
    @IBOutlet weak var versesTextView: UITextView!
    var verses: [DBTVerse] = []
    var text: String = ""
    var currentBookID: String = "Gen"
    var currentBookName: String = ""
    var currentChapter: Int = 1
    var volumes: [String] = ["ARZVDVO1ET","ARZVDVN1ET"]
    var currentVolume: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentVolume = volumes[0]
        // ActivityIndicator
        self.activityIndicator.hidesWhenStopped = true
        view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()

        
        // Navigation bar style
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        
        booksButtonOutlet.layer.cornerRadius = 15
        booksButtonOutlet.clipsToBounds = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getVerses(book: self.currentBookID, Chapter: NSNumber(value: self.currentChapter), completion: {(verses) in
            self.activityIndicator.stopAnimating()
            if let verses = verses{
                self.data(verses: verses as! [DBTVerse])}
            else {
                self.versesTextView.text = "مشكلة فى الاتصال بالانترنت."
            }})
    }
    
    
    func pass(volume: String, book: String, chapter: Int) {
        self.currentBookID = book
        self.currentChapter = chapter
        self.currentVolume = volume
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
    
    
    func getVerses(book: String, Chapter: NSNumber, completion: @escaping ([Any]?)->()) {
        DBT.getTextVerse(withDamId: currentVolume, book: book, chapter: Chapter, verseStart: nil, verseEnd: nil, success: { (verses) in
            if let verses = verses {
                self.verses = verses as! [DBTVerse]
                completion(verses)
                
            }
        }) { (error) in
            completion(nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bibleToBooksSegue"{
            let booksVC = segue.destination as! BooksTableViewController
            booksVC.delegate = self
            booksVC.currentVolume = currentVolume
            booksVC.volumes = volumes
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
