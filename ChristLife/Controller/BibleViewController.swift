//
//  BibleViewController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 22..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit
import dbt_sdk

protocol isAbleToReceiveData {
    func pass(book: String)  //data: string is an example parameter
}

class BibleViewController: UIViewController, isAbleToReceiveData {
    var booksArray: [DBTBook] = []
    var currentBook: String = ""
    
    func pass(book: String) {
        currentBook = book
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(currentBook)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Getting the Bible books
        DBT.getLibraryBook(withDamId: "ARBWTCO1ET", success: { (books) in
            if let books = books {
                self.booksArray = books as! [DBTBook]
            }
        }) { (error) in
            if let error = error {
                print("Error: \(error)")
            }
        }
        self.title = "Bible"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bibleToBooksSegue"{
            if let booksTable = segue.destination as? BooksTableViewController
            {
                booksTable.books = booksArray
                booksTable.delegate = self
            }
        }
    }
}
