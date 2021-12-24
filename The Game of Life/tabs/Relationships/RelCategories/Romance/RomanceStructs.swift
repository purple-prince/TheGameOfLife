//
//  RomanceStructs.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/15/21.
//

import Foundation
import SwiftUI

struct Partner: FamMember {
    
    let gender: String//= "Male"
    
    var age: Int = 0
        
    var name: String {
        
        get {
            if gender == "Male" {
                return maleNames.randomElement()!
            } else {
                return femaleNames.randomElement()!
            }
        }
    }
    
    var status: Int = 100
    
    lazy var emoji = age < 4 ? babyEmojis.randomElement()! : gender == "Male" ? boyEmojis.randomElement() : girlEmojis.randomElement()
    
    var jobTitle: String {
        if age < 31 {
            return hourlyJobs.randomElement()!.jobTitle
        } else {
            return careerJobs.randomElement()!.jobTitle
        }
    }
    
    init(gender: String, age: Int) {
        self.gender = gender
        self.age = age
        allPartners.append(self)
    }
}
