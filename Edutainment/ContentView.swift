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
    
    var body: some View {
        NavigationView{
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
