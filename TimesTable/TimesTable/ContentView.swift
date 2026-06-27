//
//  ContentView.swift
//  TimesTable
//
//  Created by Phillip Kim on 22/06/2026.
//

import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    @State private var gameActive = false
    @State private var timesTable = 2
    @State private var questionNum = 5
    @State private var score = 0
    @State private var questions: [Question] = []
    @State private var currentQuestion = 0
    @State private var userAnswer: Int? = nil
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var endAlert = false
    let questionNumbers = [5, 10, 20]
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .green], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            if gameActive {
                VStack {
                    HStack {
                        Text(questions[currentQuestion].text)
                        TextField("", value: $userAnswer, format: .number)
                            .keyboardType(.numberPad)
                            .frame(width: 40)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Answer") {
                        checkAnswer()
                    }
                    .foregroundStyle(.white)
                    .padding()
                }
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("Continue", action: nextQuestion)
                } message: {
                    Text(alertMessage)
                }
                .alert("Game Over", isPresented: $endAlert) {
                    Button("Play Again", action: resetGame)
                } message: {
                    Text("Your score is \(score)")
                }
            } else {
                VStack {
                    Stepper("Times tables up to \(timesTable)", value: $timesTable, in: 2...12)
                        .padding(30)
                        .animation(.bouncy, value: 1)
                    Picker("Number of questions", selection: $questionNum) {
                        ForEach(questionNumbers, id: \.self) { question in
                            Text(String(question))
                        }
                    }
                    .pickerStyle(.palette)
                    .padding(20)
                    Button("Start") {
                        gameActive = true
                        startNewGame()
                    }
                    .foregroundStyle(.black)
                }
            }
        }
    }
    
    func startNewGame() {
        for _ in 0..<questionNum {
            let number1 = Int.random(in: 1...timesTable)
            let number2 = Int.random(in: 1...timesTable)
            let answer = number1 * number2
            let questionText = "What is \(number1) x \(number2)?"
            let question = Question(text: questionText, answer: answer)
            questions.insert(question, at: 0)
        }
    }
    
    func checkAnswer() {
        if userAnswer == questions[currentQuestion].answer {
            score += 1
            alertTitle = "Correct!"
            alertMessage = "Your score is now \(score)"
        } else {
            alertTitle = "Wrong!"
            alertMessage = "The corrent answer is \(questions[currentQuestion].answer)"
        }
        showingAlert = true
    }
    
    func nextQuestion() {
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            endAlert = true
        }
        userAnswer = nil
    }
    
    func resetGame() {
        score = 0
        timesTable = 2
        questions = []
        gameActive = false
    }
}

#Preview {
    ContentView()
}
