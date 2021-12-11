//
//  LovedOnes.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/15/21.
/*

import Foundation

/*protocol Spouse {
    var firstName: String { get }
    var lastName: String { get }
    var
    
}*/

let maleNames  = [
    "Deez Nuz",
    "Joeseph Mama",
    "Ader Titsoff",
    "Ben Dover",
    "Bo Nerr",
    "Hammad Nash",
   " Krishan O'Brien",
    "Daanyal Mueller",
    "Aayush Ventura",
    "Dillon Morris",
    "Jameel Croft",
    "Usamah Vega",
    "Lawson Kelley",
    "Gregor Mcphee",
    "Maxwell Hoffman",
    "Everett Bryan",
    "Jeevan Delarosa",
    "Zion Lindsey",
    "Aj Cherry",
   " Willie English",
    "Niall Guzman",
    "Jaeden Correa",
    "Gregg Beech",
    "Dwayne Rennie",
    "Jaidan Calderon",
    "Cathal Rivas"
]

let femaleNames = [
    "Tess Tickle",
    "Annabell Sparks",
    "Ember Vasquez",
   "Mikaela Blanchard",
    "Aalia Hanna",
    "Geraldine Greaves",
    "Miya Ortiz",
   "Dollie Stephenson",
    "Sumayyah Odling",
    "Jordana Coulson",
    "Mallory Jackson",
    "Aniyah Gilliam",
    "Ursula Ashton",
   "Weronika Branch",
   "Klaudia Wooten",
    "Umaiza Pitt",
    "Halimah Compton",
    "Hollie Golden",
    "Beverly Wilde",
    "Sameeha Herrera",
    "Ivy-Rose Sharpe",
    "Zaara Mckeown",
    "Amanda Henderson",
    "Tasneem Chavez"
]

struct Father: FamMember {
    let name = maleNames.randomElement()
    var age: Int {
        Int.random(in: 27...42)
    }
}

struct Mother: FamMember {
    func name(husbandLastName: String) -> String {
        return String(femaleNames.randomElement()!.split(separator: " ")[1] + " \(husbandLastName)")
    }
    var age = Int(Father().age + Int.random(in: -5...5))
}

struct Girlfriend {
    var name = femaleNames.randomElement()
}

struct Boyfriend {
    let name = maleNames.randomElement()
}

struct Husband {
    
}

struct Wife {
    
}

struct Brother {
    func name(husbandLastName: String) -> String {
        return String(maleNames.randomElement()!.split(separator: " ")[1] + " \(husbandLastName)")
    }
}

struct Sister {
    func name(husbandLastName: String) -> String {
        return String(femaleNames.randomElement()!.split(separator: " ")[1] + " \(husbandLastName)")
    }
}

struct FemaleChild {
    
}

struct MaleChild {
    
}

struct Pet {
    
}

struct Friend {
    
}
*/


// 6

let maleNames  = [
    "Deez Nuz",
    "Joeseph Mama",
    "Ader Titsoff",
    "Ben Dover",
    "Bo Nerr",
    "Hammad Nash",
   " Krishan O'Brien",
    "Daanyal Mueller",
    "Aayush Ventura",
    "Dillon Morris",
    "Jameel Croft",
    "Usamah Vega",
    "Lawson Kelley",
    "Gregor Mcphee",
    "Maxwell Hoffman",
    "Everett Bryan",
    "Jeevan Delarosa",
    "Zion Lindsey",
    "Aj Cherry",
   " Willie English",
    "Niall Guzman",
    "Jaeden Correa",
    "Gregg Beech",
    "Dwayne Rennie",
    "Jaidan Calderon",
    "Cathal Rivas"
]

let femaleNames = [
    "Tess Tickle",
    "Annabell Sparks",
    "Ember Vasquez",
   "Mikaela Blanchard",
    "Aalia Hanna",
    "Geraldine Greaves",
    "Miya Ortiz",
   "Dollie Stephenson",
    "Sumayyah Odling",
    "Jordana Coulson",
    "Mallory Jackson",
    "Aniyah Gilliam",
    "Ursula Ashton",
   "Weronika Branch",
   "Klaudia Wooten",
    "Umaiza Pitt",
    "Halimah Compton",
    "Hollie Golden",
    "Beverly Wilde",
    "Sameeha Herrera",
    "Ivy-Rose Sharpe",
    "Zaara Mckeown",
    "Amanda Henderson",
    "Tasneem Chavez"
]

let babyEmojis = ["👶", "👶🏻", "👶🏼", "👶🏽", "👶🏾", "👶🏿"]

let girlEmojis = ["👧🏿","👧🏾","👧🏽","👧🏼","👧🏻","👧"]

let boyEmojis = ["👦🏿","👦🏾","👦🏽","👦🏼","👦🏻","👦"]

let momEmojis = [
    "👩","👩🏻","👩🏼","👩🏽","👩🏾","👩🏿","👩‍🦱","👩🏻‍🦱","👩🏼‍🦱","👩🏽‍🦱","👩🏾‍🦱","👩🏿‍🦱","👩‍🦰","👩🏻‍🦰","👩🏼‍🦰","👩🏽‍🦰","👩🏾‍🦰","👩🏿‍🦰","👱‍♀️","👱🏻‍♀️","👱🏼‍♀️","👱🏽‍♀️","👱🏾‍♀️","👱🏿‍♀️","👩‍🦳","👩🏻‍🦳","👩🏼‍🦳","👩🏽‍🦳","👩🏾‍🦳","👩🏿‍🦳","👩‍🦲","👩🏻‍🦲","👩🏼‍🦲","👩🏽‍🦲","👩🏾‍🦲","👩🏿‍🦲","🧕","🧕🏻","🧕🏼","🧕🏽","🧕🏾","🧕🏿","👳🏿‍♀️","👳🏾‍♀️","👳🏽‍♀️","👳🏼‍♀️","👳🏻‍♀️","👳‍♀️"
]

let dadEmojis = [
    "👨","👨🏻","👨🏼","👨🏽","👨🏾","👨🏿","👨‍🦱","👨🏻‍🦱","👨🏼‍🦱","👨🏽‍🦱","👨🏾‍🦱","👨🏿‍🦱","👨‍🦰","👨🏻‍🦰","👨🏼‍🦰","👨🏽‍🦰","👨🏾‍🦰","👨🏿‍🦰","👱‍♂️","👱🏻‍♂️","👱🏼‍♂️","👱🏽‍♂️","👱🏾‍♂️","👱🏿‍♂️","👨‍🦳","👨🏻‍🦳","👨🏼‍🦳","👨🏽‍🦳","👨🏾‍🦳","👨🏿‍🦳","👨‍🦲","👨🏻‍🦲","👨🏼‍🦲","👨🏽‍🦲","👨🏾‍🦲","👨🏿‍🦲","🧔‍♂️","🧔🏻‍♂️","🧔🏼‍♂️","🧔🏽‍♂️","🧔🏾‍♂️","🧔🏿‍♂️","👳🏿‍♂️","👳🏾‍♂️","👳🏽‍♂️","👳🏼‍♂️","👳🏻‍♂️","👳‍♂️"
]

let grandmaEmojis = ["👵","👵🏻","👵🏼","👵🏽","👵🏾","👵🏿"]

let grandpaEmojis = ["👴","👴🏻","👴🏼","👴🏽","👴🏾","👴🏿"]
