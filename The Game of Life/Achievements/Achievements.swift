//
//  Achievements.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 4/9/22.
//

import Foundation

class Achievement {
    
    static let AchOkBoomer: Achievement = Achievement(title: "Ok, boomer")
    static let AchEatTheRich: Achievement = Achievement(title: "Eat the rich")
    static let AchMoody: Achievement = Achievement(title: "Moody")
    
    init(title: String) {
        self.title = title
    }
    
    let title: String
}
