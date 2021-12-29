//
//  possible jobs?.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/24/21.
//

import Foundation

protocol Occupation: Hashable, Identifiable {
    var jobTitle: String { get }
}

struct HourlyJob: Occupation {
    let jobTitle : String
    var salary: Int
    var id = UUID()
}

struct OtherJob: Occupation {
    let jobTitle : String
    var salary: Int
    var id = UUID()
}

struct CareerJob: Occupation {
    let jobTitle : String
    var salary: Int
    var id = UUID()
}

var jobsAndSalaries = ["aerospace engineer": 10,
                       "prostitute": 10,
                       "farmer": 10,
                       "architect": 10,
                       "car mechanic" : 10,
                       "sandwhich maker": 10,
                       "waiter": 10,
                       "bus driver": 10,
                       "beggar": 10,
                       "construction worker": 10,
                       "dentist": 10,
                       "financial advisor": 10,
                       "translator": 10,
                       "teacher": 10,
                       "college professor": 10,
                       "physician": 10,
                       "chef": 10,
                       "plumber": 10,
                       "truck driver": 10,
                       "therapist": 10,
                       "receptionist": 10,
                       "doctor": 10,
                       "surgeon": 10,
                       "banker": 10,
                       "police": 10,
                       "software dev": 10,
                       "ethical hacker": 10,
                       "lawyer": 10,
                       "judge": 10,
                       "cashier": 10,
                       "janitor": 10,
                       "beauty parlor person": 10,
                       "baker": 10,
                       "detective": 10,
                       "accountant": 10,
                       "librarian": 10,
                       "business analyst": 10,
                       "pharmacist": 10]

let hourlyJobs : [Job] = [Job(jobTitle: "👨‍🔧 Car Mechanic", salary: 2880),
                          Job(jobTitle: "🥪 Sandwhich Maker", salary: 1400),
                          Job(jobTitle: "📝 Waiter", salary: 1760),
                          Job(jobTitle: "👷🏿‍♀️ Construction Worker", salary: 3050),
                          Job(jobTitle: "🚛 Truck Driver", salary: 3360),
                          Job(jobTitle: "💈 Barber", salary: 2600),
                          Job(jobTitle: "🌳 Lawn Mower", salary: 2400),
                          Job(jobTitle: "👨🏻‍🍼 Babysitter", salary: 2000),
                          Job(jobTitle: "📚 Librarian", salary: 4250),
]

let careerJobs: [Job] = [Job(jobTitle: "🛩 Aerospace Engineer", salary: 7083),
                         Job(jobTitle: "🧑🏼‍🌾 Farmer", salary: 6150),
                         Job(jobTitle: "🏙 Architect", salary: 5815),
                         Job(jobTitle: "🦷 Dentist", salary: 14166),
                         Job(jobTitle: "💸 Financial Advisor", salary: 5968),
                         Job(jobTitle: "🈺 Translator", salary: 9853),
                         Job(jobTitle: "🧑🏿‍🏫 Teacher", salary: 8373),
                         Job(jobTitle: "👨🏽‍🏫 Professor", salary: 7777),
                         Job(jobTitle: "🧑🏽‍⚕️ Physician", salary: 7667),
                         Job(jobTitle: "🪠 Plumber", salary: 6767),
                         Job(jobTitle: "🧠 Therapist", salary: 5987),
                         Job(jobTitle: "🩺 Doctor", salary: 5987),
                         Job(jobTitle: "👩‍⚕️ Surgeon", salary: 5987),
                         Job(jobTitle: "🏦 Banker", salary: 5987),
                         Job(jobTitle: "🚔 Police Officer", salary: 5987),
                         Job(jobTitle: "📲 Software Developer", salary: 5987),
                         Job(jobTitle: "🧑🏻‍💻 Ethican Hacker", salary: 5987),
                         Job(jobTitle: "👨🏼‍💼 Lawyer", salary: 5987),
                         Job(jobTitle: "👩🏿‍⚖️ Judge", salary: 5987),
                         Job(jobTitle: "🧾 Accountant", salary: 5987),
                         Job(jobTitle: "📊 Business Analyst", salary: 5987),
                         Job(jobTitle: "💊 Pharmacist", salary: 5987),
                         Job(jobTitle: "🧑‍🍳 Chef", salary: 5987)
]

let otherJobs: [Job] = [Job(jobTitle: "🍑 Prostitute", salary: 484),
                        Job(jobTitle: "⛺️ Beggar", salary: 454),
                        Job(jobTitle: "🤡 Clown", salary: 292),
                        Job(jobTitle: "🕺🏽 Street Dancer", salary: 345),
                        Job(jobTitle: "👩‍🍼 Babysitter", salary: 302),
                        Job(jobTitle: "🔫 Army", salary: 940),
                        Job(jobTitle: "🚒 Firefighter", salary: 696)
] // prostitute, beggar, army?, circus, street dancer/music, babysitter

/*
 aerospace engineer
 prostitute
 farmer
 architect
 car mechanic
 sandwhich maker
 waiter
 bus driver
 beggar
 construction worker
 dentist
 financial advisor
 translator
 teacher
 college professor
 physician
 chef
 plumber
 truck driver
 therapist
 receptionist
 doctor
 surgeon
 banker
 police
 software dev
 ethical hacker
 lawyer
 judge
 cashier
 janitor
 beauty parlor person
 baker
 detective
 accountant
 librarian
 business analyst
 pharmacist
 */


/*
 
 Salary Guide:
 
 200k year: 16,666
 100k year: 8,333
 50k year: 4,166
 
 10 hour: 1600
 15 hour: 2400
 20 hour: 3200
 
 */
