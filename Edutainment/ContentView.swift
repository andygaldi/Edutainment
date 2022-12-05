//
//  ContentView.swift
//  Edutainment
//
//  Created by Andy Galdi on 10/28/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gameIsActive: Bool = false
    @State private var selectedNumber: Int = 2
    @State private var allowedNumQuestions: Array<Int> = [5, 10, 20]
    @State private var selectedNumQuestions: Int = 5
    @State private var allowedDifficulty: Array<String> = ["Easy", "Medium", "Hard"]
    @State private var selectedDifficulty: String = "Easy"
    @State private var questions: Array<Question> = []
    @State private var questionIndex: Int = 0
    @State private var userAnswer: String = ""
    @State private var userScore: Int = 0
    @State private var isGameComplete: Bool = false
    @State private var gameCompleteMessage: String = ""
    
    struct Question {
        let text: String
        let answer: Int
    }
    
    var body: some View {
        if gameIsActive {
            Group {
                VStack {
                    Text(questions[questionIndex].text)
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    
                    TextField("Type your answer here", text: $userAnswer)
                        .keyboardType(.decimalPad)
                    Spacer()
                    Button("Enter") {
                        checkAnswer(givenAnswer: Int(userAnswer) ?? 0, answer: questions[questionIndex].answer)
                    }
                    .alert(isPresented: $isGameComplete) {
                        Alert(title: Text(gameCompleteMessage), message: Text("Restart game"), primaryButton: .destructive(Text("Okay")) {
                            gameIsActive = false
                            userAnswer = ""
                            userScore = 0
                            gameCompleteMessage = ""
                            questionIndex = 0
                        }, secondaryButton: .cancel())
                    }
                }
            }
        } else {
            Group {
                VStack {
                    Form {
                        Section("Select multiplication table") {
                            Stepper("\(selectedNumber) times table", value: $selectedNumber, in: 2...12)
                        }
                        
                        Section("Select number of questions") {
                            Picker("Question", selection: $selectedNumQuestions) {
                                ForEach(allowedNumQuestions, id: \.self) {
                                    Text($0, format: .number)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        Section("Select difficulty") {
                            Picker("Difficulty", selection: $selectedDifficulty) {
                                ForEach(allowedDifficulty, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        
                    }
                    .navigationTitle("Multiply")
                    
                    Button("Start Game") {
                        createQuestions()
                        gameIsActive.toggle()
                    }
                    .padding(50)
                    .background(.green)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                }
            }
        }
    }
    
    func createQuestions() {
        questions.removeAll()
        for i in 1...selectedNumQuestions {
            let question = Question(text: "What is \(selectedNumber) x \(i)?", answer: selectedNumber * i)
            questions.append(question)
        }
    }
    
    func checkAnswer(givenAnswer: Int, answer: Int) {
        if answer == givenAnswer {
            userScore += 1
        }
        userAnswer = ""
        if questionIndex < selectedNumQuestions - 1 {
            questionIndex += 1
        } else {
            gameCompleteMessage = "Your score is \(userScore)"
            isGameComplete = true
        }
    }
    
    func startGame() {
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
