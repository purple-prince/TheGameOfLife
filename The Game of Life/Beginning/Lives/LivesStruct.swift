//
//  LivesStruct.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/23/21.
//

import Foundation

struct Life: Identifiable, Equatable {
    var id: UUID = UUID()
    var name: String
    var age: Int
    var netWorth: Int
    var causeOfDeath: String
}

var cemetary = [
    Life(name: "John Adams", age: 78, netWorth: 45_200, causeOfDeath: "Died of cancer"),
    Life(name: "Bobby Wilson", age: 46, netWorth: -2_249, causeOfDeath: "Too many balls"),
    Life(name: "Ceedar James", age: 19, netWorth: 79, causeOfDeath: "Died in Fire"),
    Life(name: "Wow Bao", age: 101, netWorth: 579, causeOfDeath: "Died in idk"),
    Life(name: "Abe Lincoln", age: 45, netWorth: -5679, causeOfDeath: "Died in Hell"),
    Life(name: "Mark Bark", age: 99, netWorth: 83779, causeOfDeath: "Died in Heaven"),
    Life(name: "Forex Onyt", age: 28, netWorth: 73495, causeOfDeath: "Died in Building"),
    Life(name: "Fuckard Ihatethis", age: 34, netWorth: 38456, causeOfDeath: "Died in Water"),
]
