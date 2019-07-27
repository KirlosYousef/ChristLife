//
//  BooksTableViewController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 22..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit
import dbt_sdk

class BooksTableViewController: UITableViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    var books: [DBTBook] = []
    var volumes = [String]()
    var currentVolume: String = ""
    var selectedBook: String = "Gen"
    var selectedChapter: String = "1"
    var delegate: isAbleToReceiveData?
    var filteredBooks: [DBTBook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //Setting the cancel button of the search bar always active
        searchBar.resignFirstResponder()
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton{cancelButton.isEnabled = true}
        
        getBooks()
        self.tableView.rowHeight = 50
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "BookCell"
        guard let cell: BookTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? BookTableViewCell else {
            fatalError("The dequeued cell is not an instance of BookTableViewCell.")
        }
        cell.BookName.text = filteredBooks[indexPath.row].bookName
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookToChapterSegue"{
            let chaptersTableView = segue.destination as! ChaptersTableViewController
            chaptersTableView.currentBook = self.selectedBook
            chaptersTableView.delegate = self.delegate
            chaptersTableView.currentVolume = currentVolume
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBook = filteredBooks[indexPath.row].bookId
        currentVolume = filteredBooks[indexPath.row].damId
        performSegue(withIdentifier: "bookToChapterSegue", sender: nil)
    }
    
    // Getting the Bible books
    func getBooks() {
        self.books.removeAll()
        for i in 0...1 {
        DBT.getLibraryBook(withDamId: volumes[i], success: { (books) in
            if let books = books {
                for book in books{
                    self.books.append(book as! DBTBook)
                }
                self.filteredBooks = self.books
                self.tableView.reloadData()
            }
        }) { (error) in
            if let error = error {
                print("Error: \(error)")
            }
            }
        }
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredBooks = searchText.isEmpty ? books : books.filter { (item: DBTBook) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.bookName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
