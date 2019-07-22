//
//  BibleViewController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 22..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit
import dbt_sdk

class BibleViewController: UIViewController {
    
    public var booksArray: [DBTBook] = []
    
    override func viewWillAppear(_ animated: Bool) {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        self.title = "Bible"

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bibleToBooksSegue"{
            if let booksTable = segue.destination as? BooksTableViewController
            {
                booksTable.books = booksArray
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
