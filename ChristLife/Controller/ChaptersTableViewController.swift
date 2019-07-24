//
//  ChaptersTableViewController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 23..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit
import dbt_sdk


class ChaptersTableViewController: UITableViewController {
    
    
    var currentBook: String = ""
    //    var currentChapter: Int = 1
    var chapters: [DBTChapter] = []
    var bibleVC = BibleViewController()
    var delegate: isAbleToReceiveData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return chapters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chapterCell", for: indexPath) as? ChapterTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of BookTableViewCell.")
        }
        cell.chapterNum.text = chapters[indexPath.row].chapterId
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedChapter = Int(chapters[indexPath.row].chapterId) {
            doDismiss(book: currentBook, chapter: selectedChapter)
        }
    }
    
    
    // Get the bible chapters
    func getChapters() {
        DBT.getLibraryChapter(withDamId: "ARBWTCO1ET", bookId: currentBook, success: { libraryChapters in
            if let libraryChapters = libraryChapters {
                self.chapters = libraryChapters as! [DBTChapter]
                self.tableView.reloadData()
            }
        }, failure: { error in
            if let error = error {
                print("Error: \(error)")
            }
        })
        
    }
    
    func doDismiss(book: String, chapter: Int) {
        if let delegate = self.delegate{
            delegate.pass(book: book, chapter: chapter)
        }
        // Use presentingViewController twice to go back two levels and call
        // dismissViewController to dismiss both viewControllers.
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
