//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Phillip Kim on 17/05/2026.
//

import SwiftUI

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
    
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreValue = 0
    @State private var message = ""
    @State private var gameCount = 0
    @State private var gameEnded = false
    let GAME_END_SCORE = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreValue)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(message)
        }
        .alert("Game over", isPresented: $gameEnded) {
            Button("Play again", action: newGame)
        } message: {
            Text("Your score is \(scoreValue)!")
        }
    }
    
    func flagTapped(_ number: Int) {
        gameCount += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreValue += 1
            message = "Your score is \(scoreValue)!"
        } else {
            scoreTitle = "Wrong"
            message = "That's the flag of \(countries[number]). Your score is \(scoreValue)!"
        }
        
        showingScore = true
        
        if gameCount >= GAME_END_SCORE {
            gameEnded = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func newGame() {
        scoreValue = 0
        gameCount = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
