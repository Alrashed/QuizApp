//
//  TriviaModel.swift
//  QuizApp
//
//  Created by Khalid Alrashed on 7/21/17.
//  Copyright © 2017 Khalid Alrashed. All rights reserved.
//

import GameKit

private let questionKey = "Question"
private let optionsKey = "Options"
private let answerKey = "Answer"

private let triviaList: [[String: Any]] = [
    ["Question" : "This was the only US President to serve more than two consecutive terms.",
     "Options" : ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"],
     "Answer" : "Franklin D. Roosevelt"],
    ["Question" : "Which of the following countries has the most residents?",
     "Options" : ["Nigeria", "Russia", "Iran", "Vietnam"],
     "Answer" : "Nigeria"],
    ["Question" : "In what year was the United Nations founded?",
     "Options" : ["1918", "1919", "1945", "1954"],
     "Answer" : "1945"],
    ["Question" : "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
     "Options" : ["Paris", "Washington D.C.", "New York City", "Boston"],
     "Answer" : "New York City"],
    ["Question" : "Which nation produces the most oil?",
     "Options" : ["Iran", "Iraq", "Brazil", "Canada"],
     "Answer" : "Canada"],
    ["Question" : "Which country has most recently won consecutive World Cups in Soccer?",
     "Options" : ["Italy", "Brazil", "Argetina", "Spain"],
     "Answer" : "Brazil"],
    ["Question" : "Which of the following rivers is longest?",
     "Options" : ["Yangtze", "Mississippi", "Congo", "Mekong"],
     "Answer" : "Mississippi"],
    ["Question" : "Which city is the oldest?",
     "Options" : ["Mexico City", "Cape Town", "San Juan", "Sydney"],
     "Answer" : "Mexico City"],
    ["Question" : "Which country was the first to allow women to vote in national elections?",
     "Options" : ["Poland", "United States", "Sweden", "Senegal"],
     "Answer" : "Poland"],
    ["Question" : "Which of these countries won the most medals in the 2012 Summer Games?",
     "Options" : ["France", "Germany", "Japan", "Great Britian"],
     "Answer" : "Great Britian"]
]

class TriviaModel {
    
    struct Question {
        var question = ""
        var options = [String]()
        var answer = ""
    }
    
    private var questions: [Question]
    
    init() {
        questions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: TriviaModel.triviaProvider()) as! [Question]
    }
    
    private static func triviaProvider() -> [Question] {
        var trivia: [Question] = []
        
        for questionDict in triviaList {
            var triviaQuestion = Question()
            triviaQuestion.question = questionDict[questionKey] as! String
            triviaQuestion.options = questionDict[optionsKey] as! [String]
            triviaQuestion.answer = questionDict[answerKey] as! String
            trivia.append(triviaQuestion)
        }
        
        return trivia
    }
    
    func randomQuestion() -> Question? {
        return questions.popLast()
    }
}
