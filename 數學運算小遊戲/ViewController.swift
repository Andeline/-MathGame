//
//  ViewController.swift
//  數學運算小遊戲
//
//  Created by 蔡佳穎 on 2021/5/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var indexView: UIView!
    @IBOutlet weak var scoreView: UIView!
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var correctNumberLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var leftNumberLabel: UILabel!
    @IBOutlet weak var rightNumberLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    @IBOutlet weak var aBtn: UIButton!
    @IBOutlet weak var bBtn: UIButton!
    @IBOutlet weak var cBtn: UIButton!
    @IBOutlet weak var dBtn: UIButton!
    
    var index = 0
    var leftNumber = 0
    var rightNumber = 0
    var answer = 0
    var score = 0
    var totalScore = 0
    var consecutiveCorrect = 0
    var correctNumber = 0
    let operationSymbels = ["+", "-", "×", "÷"]
    
    func generateQuestion() {
        indexLabel.text = "第\(index+1)題"
        
        let symbolIndex = Int.random(in: 0...3)
        
        switch symbolIndex {
        case 0:
            operationLabel.text = operationSymbels[symbolIndex]
            leftNumber = Int.random(in: 5...999)
            rightNumber = Int.random(in: 5...99)
            answer = leftNumber + rightNumber
            leftNumberLabel.text = "\(leftNumber)"
            rightNumberLabel.text = "\(rightNumber)"
        case 1:
            operationLabel.text = operationSymbels[symbolIndex]
            leftNumber = Int.random(in: 5...999)
            rightNumber = Int.random(in: 5...999)
            
            if leftNumber < rightNumber {
                let temp = leftNumber
                leftNumber = rightNumber
                rightNumber = temp
            }
            
            answer = leftNumber - rightNumber
            leftNumberLabel.text = "\(leftNumber)"
            rightNumberLabel.text = "\(rightNumber)"
        case 2:
            operationLabel.text = operationSymbels[symbolIndex]
            leftNumber = Int.random(in: 2...99)
            rightNumber = Int.random(in: 2...9)
            answer = leftNumber * rightNumber
            leftNumberLabel.text = "\(leftNumber)"
            rightNumberLabel.text = "\(rightNumber)"
        case 3:
            operationLabel.text = operationSymbels[symbolIndex]
            let multiple = Int.random(in: 2...10)
            rightNumber = Int.random(in: 2...15)
            leftNumber = rightNumber * multiple
            answer = leftNumber / rightNumber
            leftNumberLabel.text = "\(leftNumber)"
            rightNumberLabel.text = "\(rightNumber)"
        default:
            break
        }
    }
    
    func generateAnswer() {
        //答案內容順序隨機
        let answers = [answer, answer+10, answer+Int.random(in: 1...5), answer-1]
        
        var answerIndex = Int.random(in: 0...3)
        aBtn.setTitle("\(answers[answerIndex])", for: .normal)
        let aAnswerIndex = answerIndex
        
        while answerIndex == aAnswerIndex {
            answerIndex = Int.random(in: 0...3)
        }
        bBtn.setTitle("\(answers[answerIndex])", for: .normal)
        let bAnswerIndex = answerIndex
        
        while answerIndex == aAnswerIndex || answerIndex == bAnswerIndex {
            answerIndex = Int.random(in: 0...3)
        }
        cBtn.setTitle("\(answers[answerIndex])", for: .normal)
        let cAnswerIndex = answerIndex
        
        while answerIndex == aAnswerIndex || answerIndex == bAnswerIndex || answerIndex == cAnswerIndex {
            answerIndex = Int.random(in: 0...3)
        }
        dBtn.setTitle("\(answers[answerIndex])", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreView.isHidden = true
        correctNumberLabel.text = "0"
        scoreLabel.text = ""
        generateQuestion()
        generateAnswer()
    }

    @IBAction func selectAnswer(_ sender: UIButton) {
        
        if index < 9 {
            if sender.currentTitle == "\(answer)" {
                index += 1
                correctNumber += 1
                correctNumberLabel.text = "\(correctNumber)"
                consecutiveCorrect += 1
                if consecutiveCorrect >= 3 {
                    score += 30
                    scoreLabel.text = "\(score)分"
                } else {
                    score += 10
                    scoreLabel.text = "\(score)分"
                }
                generateQuestion()
                generateAnswer()
                
            } else {
                index += 1
                consecutiveCorrect -= 1
                score -= 10
                scoreLabel.text = "\(score)分"
                generateQuestion()
                generateAnswer()
            }
        } else {
            scoreView.isHidden = false
            totalScore = score
            totalScoreLabel.text = "\(score)"
        }
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        scoreView.isHidden = true

        index = 0
        score = 0
        scoreLabel.text = ""
        consecutiveCorrect = 0
        correctNumber = 0
        correctNumberLabel.text = ""
        
        generateQuestion()
        generateAnswer()
    }
}

