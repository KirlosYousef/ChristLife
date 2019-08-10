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
    
    @IBOutlet var gameEndView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
    let progress = Progress(totalUnitCount: 10)
    let allQuestions = QuestionBank()
    var questionNum = 0
    var correctAnswer = 0
    var score = 0
    var selectedAnswer = 0
    var seconds = 10 // 10 seconds
    var timer : Timer!
    var currentCell = quizCollectionViewCell()
    
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
        let bWidth: CGFloat = 3
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
        
//        self.startTimer()
        currentCell = cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.frame.size
    }
    
    
    func goToNextQuestion(){
        let indexPath = IndexPath(row: questionNum, section: 0)
        // Buttons target to the next question (Cell)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
    }
    
    // MARK: - UI
    func updateUI(){
        // If it was the last question
        if (questionNum == 9) {
            self.view.addSubview(gameEndView)
            finalScoreLabel.text = String(score)
            //            print("Done")
        } else{
            questionNum += 1
            goToNextQuestion()
            questionNumLabel.text = "\(questionNum+1)/10"
            
            // Scoring
            scoreLabel.text = "النقط: \(String(score))"
            
            // Progress tracking
            self.progress.completedUnitCount += 1
            self.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Buttons
    @IBAction func answerpressed(_ sender: UIButton) {
//        stopTimer()
        seconds = 10
        startTimer()
        let correctColor: CGColor = #colorLiteral(red: 0.003275793374, green: 0.7647058964, blue: 0.01348719592, alpha: 1)
        let wrongColor: CGColor = #colorLiteral(red: 0.9254902005, green: 0, blue: 0.06055648513, alpha: 1)
        
        if sender.tag == correctAnswer{
            // Scoring
            score += 1
        }
        
        // Wrong answer
        if sender.tag != correctAnswer {
            switch sender.tag {
            case 1:
                currentCell.optionA.layer.borderColor = wrongColor
                break
            case 2:
                currentCell.optionB.layer.borderColor = wrongColor
                break
            case 3:
                currentCell.optionC.layer.borderColor = wrongColor
                break
            default:
                break
            }
        }
        // Show the correct answer
            switch correctAnswer {
            case 1:
                currentCell.optionA.layer.borderColor = correctColor
                break
            case 2:
                currentCell.optionB.layer.borderColor = correctColor
                break
            case 3:
                currentCell.optionC.layer.borderColor = correctColor
                break
            default:
                break
            }

        updateUI()
    }
    
    
    @IBAction func restartButton(_ sender: Any) {
        allQuestions.list.shuffle()
        seconds = 10
        // Reset progress tracking
        self.progress.completedUnitCount = 1
        self.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
        
        // Reset scoring
        score = 0
        scoreLabel.text = "النقط: \(String(score))"
        
        questionNum = 0
        questionNumLabel.text = "1/10"
        goToNextQuestion()
        self.view.sendSubviewToBack(gameEndView)
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
    
    
    // MARK: - Timer
    @objc func updateTimer() {
        if seconds < 2 {
            seconds = 10
            startTimer()
            updateUI()
        } else {
            seconds -= 1
        }
        timerLabel.text = "الوقت: \(seconds)"
    }

    func startTimer() {
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
        if seconds > 0 {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        }
    }

    
    // Temporary alert
//    func showAlertWith(message msg: String) {
//        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
//        self.present(alert, animated: true, completion: nil)
//
//        // change to desired number of seconds (in this case 5 seconds)
//        let when = DispatchTime.now() + 0.5
//        DispatchQueue.main.asyncAfter(deadline: when){
//            // your code with delay
//            alert.dismiss(animated: true, completion: nil)
//        }
//    }
}
