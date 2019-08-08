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
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var shareScoreButton: UIButton!
    // Progress tracking
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    let progress = Progress(totalUnitCount: 10)
    @IBOutlet var gameEndView: UIView!
    
    let allQuestions = QuestionBank()
    var questionNum = 0
    var correctAnswer = 0
    var score = 0
    var selectedAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To fix the sliding cells problem
        if #available(iOS 10.0, *) {collectionView.isPrefetchingEnabled = false}
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        allQuestions.list.shuffle()
        
        let cornerRadius: CGFloat = 10
        let bColor: CGColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let bWidth: CGFloat = 1
        // Progressbar
        progressView.progress = 0.1
        progress.completedUnitCount = 1
        progressView.progressImage = #imageLiteral(resourceName: "ProgressBarBG")
        progressView.layer.cornerRadius = cornerRadius
        progressView.clipsToBounds = true
        // Game ended scene
        playAgainButton.layer.borderColor = bColor
        playAgainButton.layer.cornerRadius = cornerRadius
        playAgainButton.layer.borderWidth = bWidth
        shareScoreButton.layer.borderColor = bColor
        shareScoreButton.layer.cornerRadius = cornerRadius
        shareScoreButton.layer.borderWidth = bWidth
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allQuestions.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if #available(iOS 10.0, *) {collectionView.isPrefetchingEnabled = false}
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as! quizCollectionViewCell
        // Setting the question information
        let currentQuestion = allQuestions.list[indexPath.row]
        cell.questionLabel.text = currentQuestion.question
        cell.optionA.setTitle(currentQuestion.optionA, for: .normal)
        cell.optionB.setTitle(currentQuestion.optionB, for: .normal)
        cell.optionC.setTitle(currentQuestion.optionC, for: .normal)
        
        correctAnswer = currentQuestion.correctAnswer
        
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
            self.view.addSubview(gameEndView)
            finalScoreLabel.text = String(score)
            //            print("Done")
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
        
        self.view.sendSubviewToBack(gameEndView)
    }
    
    func goToNextQuestion(){
        let indexPath = IndexPath(row: questionNum, section: 0)
        // Buttons target to the next question (Cell)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
    }
    
    
    @IBAction func shareScorePressed(_ sender: Any) {
        // text to share
        let shareText = "انا جبت \(score) نقط من 10 فى مسابقات الانجيل على ابلكيشن ChristLife."
        
        // set up activity view controller
        let textToShare = [ shareText ]
        let activityViewController = UIActivityViewController(activityItems: textToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
