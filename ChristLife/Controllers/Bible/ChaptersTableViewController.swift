//
//  ChaptersTableViewController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 23..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit
import dbt_sdk


class ChaptersTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    var currentBook: String = ""
    var chapters: [DBTChapter] = []
    var bibleVC = BibleViewController()
    var delegate: isAbleToReceiveData?
    var filteredChapters: [DBTChapter] = []
    var currentVolume: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "BibleBG.jpg"))
        searchBar.delegate = self
        //Setting the cancel button of the search bar always active
        searchBar.resignFirstResponder()
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton{cancelButton.isEnabled = true}
        
        getChapters()
        self.tableView.rowHeight = 50
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChapters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chapterCell", for: indexPath) as? ChapterTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of BookTableViewCell.")
        }
        cell.chapterNum.text = filteredChapters[indexPath.row].chapterId
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedChapter = Int(filteredChapters[indexPath.row].chapterId) {
            doDismiss(book: currentBook, chapter: selectedChapter)
        }
    }
    
    
    // Get the bible chapters
    func getChapters() {
        DBT.getLibraryChapter(withDamId: currentVolume, bookId: currentBook, success: { libraryChapters in
            if let libraryChapters = libraryChapters {
                self.chapters = libraryChapters as! [DBTChapter]
                self.filteredChapters = self.chapters
                self.tableView.reloadData()
            }
        }, failure: { error in
            if let error = error {
                print("Error: \(error)")
            }
        })
    }
    
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredChapters = searchText.isEmpty ? chapters : chapters.filter { (item: DBTChapter) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.chapterName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    func doDismiss(book: String, chapter: Int) {
        if let delegate = self.delegate{
            delegate.pass(volume: currentVolume,book: book, chapter: chapter)
        }
        // Use presentingViewController twice to go back two levels and call
        // dismissViewController to dismiss both viewControllers.
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
