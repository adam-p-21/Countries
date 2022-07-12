//
//  QuizViewController.swift
//  Countries
//
//  Created by Adam Paluszewski on 29/06/2022.
//

import UIKit

class QuizViewController: UIViewController {

    
    @IBOutlet weak var startQuizButton: UIButton!
    @IBOutlet weak var answerButton0: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    
    let testCommit2 = "aaa"
    
    
    var score = 0 {
        didSet {
            scoreLabel.text = " Score: \(score) "
        }
    }
    
    var highestScore = 0 {
        didSet {
            highestScoreLabel.text = " Highest score: \(highestScore) "
        }
    }
    
    var currentQuestionNumber = 0 {
        didSet {
            questionNumberLabel.text = " Question: \(currentQuestionNumber+1) of \(String(quiz.count)) "
        }
    }
    
    var quiz = QuizQuestionsDatabase().quiz
    
    var timerLabelCounter = 20.0
    
    var timer = Timer()
    
    
    
    
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "questionMark.jpg")!)
        getStartingUI()
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        quiz.shuffle()
        
        let defaults = UserDefaults.standard
        if let highestScoreUD = defaults.value(forKey: "highestScore") as? Int {
            highestScore = highestScoreUD
        }
        
    }
    
    
    
    
    func getStartingUI() {
        
        questionNumberLabel.layer.cornerRadius = 5
        questionNumberLabel.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        questionNumberLabel.isHidden = true
        currentQuestionNumber = 0
        
        scoreLabel.layer.cornerRadius = 5
        scoreLabel.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        scoreLabel.isHidden = true
        scoreLabel.text = " Score: 0 "
        score = 0
        
        highestScoreLabel.layer.cornerRadius = 5
        highestScoreLabel.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        highestScoreLabel.isHidden = false
        
        timerLabel.layer.cornerRadius = 15
        timerLabel.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        timerLabel.isHidden = true
        
        startQuizButton.layer.cornerRadius = startQuizButton.frame.height / 2
        startQuizButton.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        startQuizButton.isHidden = false
        
        questionLabel.layer.cornerRadius = 35
        questionLabel.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        
        answerButton0.layer.cornerRadius = answerButton0.frame.height / 2
        answerButton0.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        answerButton0.isHidden = true
        answerButton0.setTitleColor(UIColor.black, for: .normal)
        
        answerButton1.layer.cornerRadius = answerButton0.layer.cornerRadius
        answerButton1.layer.backgroundColor = answerButton0.layer.backgroundColor
        answerButton1.isHidden = true
        answerButton1.setTitleColor(UIColor.black, for: .normal)

        answerButton2.layer.cornerRadius = answerButton0.layer.cornerRadius
        answerButton2.layer.backgroundColor = answerButton0.layer.backgroundColor
        answerButton2.isHidden = true
        answerButton2.setTitleColor(UIColor.black, for: .normal)

        answerButton3.layer.cornerRadius = answerButton0.layer.cornerRadius
        answerButton3.layer.backgroundColor = answerButton0.layer.backgroundColor
        answerButton3.isHidden = true
        answerButton3.setTitleColor(UIColor.black, for: .normal)
        
    }
    

    
    
    @IBAction func startQuizButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 1.7, y: 1.4)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { finished in
            self.startGame()
            }
        
    }
        

    

    func startGame() {
        
        questionNumberLabel.isHidden = false
        questionNumberLabel.text = " Question: \(currentQuestionNumber+1) of \(String(quiz.count)) "
        
        scoreLabel.isHidden = false
        timerLabel.isHidden = false
        highestScoreLabel.isHidden = true
        
        startQuizButton.isHidden = true
        answerButton0.isHidden = false
        answerButton1.isHidden = false
        answerButton2.isHidden = false
        answerButton3.isHidden = false
        
        questionLabel.text = quiz[0].question
        answerButton0.setTitle(quiz[0].answer[0], for: .normal)
        answerButton1.setTitle(quiz[0].answer[1], for: .normal)
        answerButton2.setTitle(quiz[0].answer[2], for: .normal)
        answerButton3.setTitle(quiz[0].answer[3], for: .normal)
        
        startQuestionTimer()
        
    }
    
    
    
    
    func startQuestionTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        
    }
    
    
    
    
    @objc func updateTimerLabel() {
        
         if timerLabelCounter >= 5 {
             timerLabel.text = String(format: "%.0f", timerLabelCounter) + "s"
             timerLabelCounter -= 0.2
         } else if timerLabelCounter >= 0 {
             timerLabel.text = String(format: "%.0f", timerLabelCounter) + "s"
             timerLabel.textColor = UIColor.red
             timerLabelCounter -= 0.2
         } else {
             checkForCorrectButton()
             timer.invalidate()
             
             Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                 self.getNextQuestion()
                 self.updateAnswersButtonsUI()

             }
         }
        
     }
     
    
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 1.7, y: 1.4)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { finished in
            let correct = self.checkCorrectAnswer(chosenAnswer: sender.tag)
            
            if correct {
                sender.layer.backgroundColor = UIColor.green.cgColor
                self.score += 1
            } else {
                sender.layer.backgroundColor = UIColor.red.cgColor
            }
            
            self.timer.invalidate()
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                self.getNextQuestion()
                self.updateAnswersButtonsUI()
            }
        }
        
    }
    
    
    
    
    func checkCorrectAnswer(chosenAnswer: Int) -> Bool{
        
        let correctAnswer = quiz[currentQuestionNumber].correctAnswer
        
        if chosenAnswer == correctAnswer {
            return true
        } else {
            return false
        }
        
    }
    
    
    
    
    func getNextQuestion() {
        
        if isItLastQuestion() {
            endOfQuiz()
        } else {
            currentQuestionNumber += 1
            startQuestionTimer()
            timerLabelCounter = 20
            questionLabel.text = quiz[currentQuestionNumber].question
            answerButton0.setTitle(quiz[currentQuestionNumber].answer[0], for: .normal)
            answerButton1.setTitle(quiz[currentQuestionNumber].answer[1], for: .normal)
            answerButton2.setTitle(quiz[currentQuestionNumber].answer[2], for: .normal)
            answerButton3.setTitle(quiz[currentQuestionNumber].answer[3], for: .normal)
        }
        
    }
    
    
    
    
    func updateAnswersButtonsUI() {
        
        self.answerButton0.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        self.answerButton1.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        self.answerButton2.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        self.answerButton3.layer.backgroundColor = UIColor(patternImage: UIImage(named: "answer.jpg")!).cgColor
        
    }
    
    
    
    
    func checkForCorrectButton () {
        
        if self.quiz[self.currentQuestionNumber].correctAnswer == 0 {
            self.answerButton0.layer.backgroundColor = UIColor.green.cgColor
        } else if self.quiz[self.currentQuestionNumber].correctAnswer == 1 {
            self.answerButton1.layer.backgroundColor = UIColor.green.cgColor
        } else if self.quiz[self.currentQuestionNumber].correctAnswer == 2 {
            self.answerButton2.layer.backgroundColor = UIColor.green.cgColor
        } else {
            self.answerButton3.layer.backgroundColor = UIColor.green.cgColor
        }
        
    }
    
    
    
    
    func isItLastQuestion() -> Bool {
        
        if currentQuestionNumber < quiz.count-1 {
            return false
        } else {
            return true
        }
        
    }
    
    
    
    
    func endOfQuiz() {
        
        let ac = UIAlertController(title: "End of quiz", message: "You scored \(score) points out of \(quiz.count)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
            self.updateHighestScore()
            self.getStartingUI()
        }))
        present(ac, animated: true)
        
    }
    
    
    
    
    func updateHighestScore() {
        
        if score > highestScore {
            highestScore = score
            
            let defaults = UserDefaults.standard
            defaults.set(highestScore, forKey: "highestScore")
        } else {
            
        }
        
    }
    
    
    
    
}
