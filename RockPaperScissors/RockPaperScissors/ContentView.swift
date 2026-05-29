//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Phillip Kim on 30/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var playerChoice: Int?
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var showScore = false
    @State private var isGameOver = false
    @State private var rounds = 1
    @State private var title = ""
    let plays = ["Rock", "Paper", "Scissors"]
    let wins = ["Paper", "Scissors", "Rock"]
    let loses = ["Scissors", "Rock", "Paper"]
    let SET_SIZE = 10
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .mint], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Round: \(rounds) / \(SET_SIZE)")
                Text("Computer chose: \(plays[computerChoice])")
                    .font(.headline)
                Text("Should \(shouldWin ? "win" : "lose")!")
                    .font(.largeTitle.bold())
                
                ForEach(plays, id: \.self) { play in
                    Button {
                        playChoice(play)
                    } label: {
                        Text(play)
                    }
                    .font(Font.largeTitle.bold())
                    .buttonStyle(.bordered)
                    .tint(.yellow)
                    .padding()
                    .foregroundStyle(.white)
                }
                Text("Current score: \(score)")
                    .padding()
            }
            .padding()
        }
        .alert(title, isPresented: $showScore) {
            Button("Continue", action: newRound)
        } message: {
            Text("Your score is \(score)!")
        }
        .alert("Game Over", isPresented: $isGameOver){
            Button("Play again", action: reset)
        } message: {
            Text("Your final score is \(score)!")
        }
    }
    
    func playChoice(_ choice: String) {
        if shouldWin {
            if choice == wins[computerChoice] {
                score += 1
                title = "Correct!"
            } else {
                score -= 1
                title = "Wrong!"
            }
        } else {
            if choice == loses[computerChoice] {
                score += 1
                title = "Correct!"
            } else {
                score -= 1
                title = "Wrong!"
            }
        }
        if rounds >= SET_SIZE {
            isGameOver = true
        } else {
            showScore = true
        }
        rounds += 1
    }
    
    func newRound() {
        computerChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func reset() {
        score = 0
        rounds = 0
        newRound()
    }
}

#Preview {
    ContentView()
}
