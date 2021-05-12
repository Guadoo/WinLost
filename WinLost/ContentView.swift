//
//  ContentView.swift
//  WinLost
//
//  Created by Guadoo on 2021/5/11.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves = [1:"Rock", 2:"Paper", 3:"Scissors"].shuffled()
    @State private var results = ["WIN", "LOST"].shuffled()
    
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var showResult = false
    
    @State private var times = 10
    
    var body: some View {
        VStack {
            VStack{
                Text(moves[0].value)
                Text(results[0])
                    .padding(5)
                HStack {
                    ForEach (0 ..< 3) { item in
                        Button(action: {
                            moveTapped(move: moves[0].key, result: results[0], number: item)
                            
                        }, label: {
                            Text(moves[item].value)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                        })
                        .alert(isPresented: $showResult, content: {
                            Alert(title: Text(scoreTitle), message: Text("Your current score is \(score)"), dismissButton: .default(Text("Continue"),
                            action: {
                                self.askAgain()
                            }))
                        })
                    }
                }
                Text("Your current scose is \(score) \n and left try times is \(times)")
                    .padding()
            }
            .blur(radius: times < 1 ? 3.0 : 0)
            .disabled(times < 1 ? true : false)
            
            Button(action: {
                self.restart()
            }, label: {
                Text("Restart")
            })
            .disabled(times >= 1 ? true : false)
        }
    }
    
    func moveTapped(move: Int, result: String, number: Int) {
        if (move - moves[number].key == 1 || move - moves[number].key == -2) && result == "WIN" {
            scoreTitle = "Correct!!!"
            score += 1
        } else if (move - moves[number].key == -1 || move - moves[number].key == 2) && result == "LOST" {
            scoreTitle = "Correct!!!"
            score += 1
        } else {
            scoreTitle = "Wrong!!!"
            score -= 1
        }
        
        if times >= 1 {
            showResult = true
        }
    }
    
    func askAgain() {
        moves.shuffle()
        results.shuffle()
        times -= 1
    }
    
    func restart() {
        moves.shuffle()
        results.shuffle()
        times = 10
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
