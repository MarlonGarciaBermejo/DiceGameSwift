//
//  ContentView.swift
//  DiceGameSwift
//
//  Created by Marlon Garcia-Bermejo on 2023-04-04.
//

import SwiftUI

struct ContentView: View {
    @State var diceNumber = 1      // variables showing the dice numbers and results
    @State var aiDiceNumber = 1
    @State var isShowingResult = false
    
    var body: some View {
        VStack {
            Image(systemName: "die.face.\(aiDiceNumber)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(50)
            Image(systemName: "die.face.\(diceNumber)")
                .resizable()
                .aspectRatio(contentMode: .fit)   // image size and fit, in this case the dice.
                .padding(50)
            Button(action: { roll() }, label: {
                Text("Roll")
                    .font(.largeTitle)   // text configurations for larger font and color style.
                    .foregroundColor(.white)
                    .padding()
            })
            .background(Color.black)
            .cornerRadius(15.0) // button bg color and rounded edges.
            .sheet(isPresented: $isShowingResult, content: {
                ResultView(diceNumber: diceNumber, aiDiceNumber: aiDiceNumber, playAgain: playAgain) // another page to preview the results
                })
            
        }
    }
    
    func playAgain() {
        diceNumber = 1
        aiDiceNumber = 1
        isShowingResult = false
    }
    
    func roll() {
        diceNumber = Int.random(in: 1...6)   // random number generator that auto rolls between 1 - 6 as an Int.
        aiDiceNumber = Int.random(in: 1...6)
        isShowingResult = true  // the results after the dice has been rolled
    }
}

struct ResultView: View {
    var diceNumber: Int
    var aiDiceNumber: Int
    var playAgain: () -> Void // result for the game, play again.
    
    var body: some View {
        let resultText = diceNumber > aiDiceNumber ? "You win!" : "AI wins!"
        // diceNumber bigger than ai then I win, then the other way around if AI wins.
        
        VStack {
            Text(resultText)
                .font(.largeTitle)
            Text("You rolled a \(diceNumber) and the AI rolled a \(aiDiceNumber).")
                .foregroundColor(.blue)
                .font(.headline)
            Button(action: { playAgain() }, label: {
                Text("Play again")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(15)
            })
            .background(Color.black)
            .cornerRadius(15.0)
            .padding(20)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
