//
//  DailyVerses.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 07. 27..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import Foundation

struct Verse {
    let damID: String
    let bookID: String
    let chapterID: Int
    let verseID: Int
}

class DailyVerses {
    var verses = [Verse]()
    
    func getVerseInfo() -> [Verse] {    
        if let filepath = Bundle.main.path(forResource: "VersesFile", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                
                // Split the file into separate lines
                let lines = contents.components(separatedBy: "\n")
                // Iterate over each line
                for line in lines {
                    if !line.isEmpty{
                        // Get each word separately
                        let words = line.components(separatedBy: " ")
                        // Define the verse of type Verse structure
                        let verse = Verse(damID: words[0], bookID: words[1], chapterID: Int(words[2])!, verseID: Int(words[3].filter{!$0.isWhitespace})!)
                        // Add the verse to the verses array
                        verses.append(verse)
                    }
                }
                
            } catch {
                // contents could not be loaded
            }
        } else {
            // txt file not found!
            print("Can't find the required file!")
        }
        return verses
    }
}
