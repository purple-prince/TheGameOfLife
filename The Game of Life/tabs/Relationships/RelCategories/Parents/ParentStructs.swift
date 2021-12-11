//
//  ParentStructs.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import Foundation
import SwiftUI

struct Mother: FamMember {
    var age: Int = Int.random(in: (27...45))
    let name: String = femaleNames.randomElement()!
    var status: Int = 100
    var emoji = momEmojis.randomElement()!
}

struct Father: FamMember {
    var age: Int = Int.random(in: (27...45))
    let name: String = maleNames.randomElement()!
    var status: Int = 100
    var emoji = dadEmojis.randomElement()!
}

struct Parents {
    var mom = Mother()
    var dad = Father()
}
