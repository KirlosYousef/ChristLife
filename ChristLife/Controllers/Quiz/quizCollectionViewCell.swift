//
//  quizCollectionViewCell.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 08. 05..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit

class quizCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    
    var correctAnswer: Int = 0
}
