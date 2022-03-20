//
//  LottoFile.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 11/28/21.
//

import Foundation
//comment///
struct Lotto {
    var chances = 100_000
    var totalAttempts = 0
    
    lazy var userGuess = Int.random(in: 0...chances)
    
    mutating func didWin(bought ticketsBought: Int) -> Bool {
        lazy var winningNumber = Int.random(in: 0...(chances / ticketsBought))

        return userGuess == winningNumber
    }
    
    mutating func updateChances(amount: Int) -> Void {
        chances -= amount
    }
}
