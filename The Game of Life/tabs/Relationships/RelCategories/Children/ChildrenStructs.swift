//
//  ChildrenStructs.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/8/21.
//

import Foundation

var genders = ["Male", "Female"]

struct Child: FamMember {
    let gender = genders.randomElement()!
    var age: Int = 0
    let name: String = maleNames.randomElement()!
    var status: Int = 100
    lazy var emoji = age < 4 ? babyEmojis.randomElement()! : gender == "Male" ? boyEmojis.randomElement() : girlEmojis.randomElement()!
}
