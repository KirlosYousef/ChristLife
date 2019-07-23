//
//  BibleViewController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 22..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit
import dbt_sdk

// protocol to send back data to the previous VC
protocol isAbleToReceiveData {
    func pass(book: String, chapter: String)
}

class BibleViewController: UIViewController, isAbleToReceiveData {
    var booksArray: [DBTBook] = []
    var currentBook: String = "Josh"
    var currentChapter: String = "1"
    
    func pass(book: String, chapter: String) {
        currentBook = book
        currentChapter = chapter
        viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bible"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print(currentBook)
        print(currentChapter)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bibleToBooksSegue"{
            if let booksTable = segue.destination as? BooksTableViewController
            {
                
                booksTable.delegate = self
            }
        }
    }
}
