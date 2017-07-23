//
//  ViewController.swift
//  QuizApp
//
//  Created by Khalid Alrashed on 7/20/17.
//  Copyright © 2017 Khalid Alrashed. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var correctAnswer = ""
    
    var gameSound: SystemSoundID = 0
    var triviaModel = TriviaModel()
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        option1Button.layer.cornerRadius = 10
        option2Button.layer.cornerRadius = 10
        option3Button.layer.cornerRadius = 10
        option4Button.layer.cornerRadius = 10
        playAgainButton.layer.cornerRadius = 10
        
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }
    
    func displayQuestion() {
        if let triviaList = triviaModel.randomQuestion() {
            playAgainButton.isHidden = true
            setupQuestionAndOptions(from: triviaList)
            
        } else {
            nextRound()
        }
    }
    
    func setupQuestionAndOptions(from triviaList: TriviaModel.Question) {
        correctAnswer = triviaList.answer
        
        questionField.text = triviaList.question
        option1Button.setTitle(triviaList.options[0], for: .normal)
        option2Button.setTitle(triviaList.options[1], for: .normal)
        option3Button.setTitle(triviaList.options[2], for: .normal)
        option4Button.setTitle(triviaList.options[3], for: .normal)
        
        enableButtons(true)
    }
    
    func displayScore()  {
        // Hide the answer buttons
        hideOptionButtons(true)
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        enableButtons(false)
        
        if (sender.currentTitle == correctAnswer) {
            correctQuestions += 1
            responseLabel.isHidden = false
            responseLabel.textColor = UIColor(red: 44/255, green: 148/255, blue: 135/255, alpha: 1)
            responseLabel.text = "Correct!"
        } else {
            responseLabel.isHidden = false
            responseLabel.textColor = UIColor(red: 249/255, green: 162/255, blue: 99/255, alpha: 1)
            responseLabel.text = "Sorry, thats not it."
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound || triviaModel.numberOfQuestionsLeft() == 0 {
            // Game is over
            responseLabel.isHidden = true
            displayScore()
            
            triviaModel = TriviaModel()
        } else {
            // Continue game
            responseLabel.isHidden = true
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        hideOptionButtons(false)
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    
    
    // MARK: Helper Methods
    
    func hideOptionButtons(_ hidden: Bool) {
        option1Button.isHidden = hidden
        option2Button.isHidden = hidden
        option3Button.isHidden = hidden
        option4Button.isHidden = hidden
    }
    
    func enableButtons(_ enabled: Bool) {
        option1Button.isEnabled = enabled
        option2Button.isEnabled = enabled
        option3Button.isEnabled = enabled
        option4Button.isEnabled = enabled
    }
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

