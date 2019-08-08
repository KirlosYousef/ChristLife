//
//  QuizViewController.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 08. 05..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Progress tracking
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    let progress = Progress(totalUnitCount: 10)
    @IBOutlet var winView: UIView!
    
    let allQuestions = QuestionBank()
    var questionNum = 1
    var correctAnswer = 0
    var score = 0
    var selectedAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        allQuestions.list.shuffle()
        
        // Progressbar
        progressView.progress = 0.1
        progress.completedUnitCount = 1
        progressView.progressImage = #imageLiteral(resourceName: "ProgressBarBG")
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        
        // Centers the subview
//                winView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allQuestions.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as! quizCollectionViewCell
        
        // Setting the question information
        let currentQuestion = allQuestions.list[indexPath.row]
        cell.questionLabel.text = currentQuestion.question
        cell.optionA.setTitle(currentQuestion.optionA, for: .normal)
        cell.optionB.setTitle(currentQuestion.optionB, for: .normal)
        cell.optionC.setTitle(currentQuestion.optionC, for: .normal)
        
        if indexPath.row > 1{
            correctAnswer = allQuestions.list[indexPath.row - 1].correctAnswer
        } else {
            correctAnswer = currentQuestion.correctAnswer
        }
        
        let bColor: CGColor = #colorLiteral(red: 0.03194817156, green: 0.09534788877, blue: 0.2032955587, alpha: 1)
        let cRadius: CGFloat = 10
        let bWidth: CGFloat = 2
        // Buttons style
        cell.optionA.layer.borderColor = bColor
        cell.optionA.layer.borderWidth = bWidth
        cell.optionA.layer.cornerRadius = cRadius
        cell.optionB.layer.borderColor = bColor
        cell.optionB.layer.borderWidth = bWidth
        cell.optionB.layer.cornerRadius = cRadius
        cell.optionC.layer.borderColor = bColor
        cell.optionC.layer.borderWidth = bWidth
        cell.optionC.layer.cornerRadius = cRadius
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.frame.size
    }
    
    
    @IBAction func answerpressed(_ sender: UIButton) {
        if sender.tag == correctAnswer{
            // Scoring
            score += 1
        }
        else {
//            print(correctAnswer)
        }
        updateUI()
    }
    
    
    func updateUI(){
        // If it was the last question
        if (questionNum == 10) {
            self.view.addSubview(winView)
            print("Done")
        } else{
            questionNum += 1
            goToNextQuestion()
            questionNumLabel.text = "\(questionNum)/10"
            
            // Scoring
            scoreLabel.text = "النقط: \(String(score))"
            
            // Progress tracking
            self.progress.completedUnitCount += 1
            self.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
        }
    }
    
    @IBAction func restartButton(_ sender: Any) {
        allQuestions.list.shuffle()
        
        // Reset progress tracking
        self.progress.completedUnitCount = 1
        self.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
        
        // Reset scoring
        score = 0
        scoreLabel.text = "النقط: \(String(score))"
        
        questionNum = 1
        questionNumLabel.text = "1/10"
        goToNextQuestion()
        
        self.view.sendSubviewToBack(winView)
    }
    
    func goToNextQuestion(){
        let indexPath = IndexPath(row: questionNum, section: 0)
        // Buttons target to the next question (Cell)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
    }
}
