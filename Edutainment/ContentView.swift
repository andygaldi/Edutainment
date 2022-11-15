//
//  ContentView.swift
//  Edutainment
//
//  Created by Andy Galdi on 10/28/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gameIsActive = false
    @State private var selectedNumber = 2
    @State private var allowedNumQuestions = [5, 10, 20]
    @State private var selectedNumQuestions = 5
    @State private var allowedDifficulty = ["Easy", "Medium", "Hard"]
    @State private var selectedDifficulty = "Easy"
    @State private var questions = [Question]()
    
    struct Question {
        let text: String
        let answer: Int
    }
    
    var body: some View {
        NavigationView{
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
                
                Button("Start Game"
                      // , action: startGame
                ) {
                    gameIsActive.toggle()
                }
                .padding(50)
                .background(.green)
                .foregroundColor(.white)
                .clipShape(Circle())
            }
        }
    }
    
    func createQuestions(selectedNum: Int, numQuestions: Int, difficulty: String) {
        questions = [Question]()
        for _ in 1...numQuestions {
            let randomInt = Int.random(in: 0..<13)
            let question = Question(text: "What is \(selectedNum) x \(randomInt)?", answer: selectedNum*randomInt)
            questions.append(question)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
