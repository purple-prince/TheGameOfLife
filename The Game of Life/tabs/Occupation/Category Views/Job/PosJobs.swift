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

let hourlyJobs : [HourlyJob] = [HourlyJob(jobTitle: "👨‍🔧 Car Mechanic", salary: 2880),
                                HourlyJob(jobTitle: "🥪 Sandwhich Maker", salary: 1400),
                                HourlyJob(jobTitle: "📝 Waiter", salary: 1760),
                                HourlyJob(jobTitle: "👷🏿‍♀️ Construction Worker", salary: 3050),
                                HourlyJob(jobTitle: "🚛 Truck Driver", salary: 3360),
                                HourlyJob(jobTitle: "💈 Barber", salary: 2600),
                                HourlyJob(jobTitle: "🌳 Lawn Mower", salary: 2400),
                                HourlyJob(jobTitle: "👨🏻‍🍼 Babysitter", salary: 2000),
                                HourlyJob(jobTitle: "📚 Librarian", salary: 4250),
]

let careerJobs: [CareerJob] = [CareerJob(jobTitle: "🛩 Aerospace Engineer", salary: 7083),
                               CareerJob(jobTitle: "🧑🏼‍🌾 Farmer", salary: 6150),
                               CareerJob(jobTitle: "🏙 Architect", salary: 5815),
                               CareerJob(jobTitle: "🦷 Dentist", salary: 14166),
                               CareerJob(jobTitle: "💸 Financial Advisor", salary: 5968),
                               CareerJob(jobTitle: "🈺 Translator", salary: 9853),
                               CareerJob(jobTitle: "🧑🏿‍🏫 Teacher", salary: 8373),
                               CareerJob(jobTitle: "👨🏽‍🏫 Professor", salary: 7777),
                               CareerJob(jobTitle: "🧑🏽‍⚕️ Physician", salary: 7667),
                               CareerJob(jobTitle: "🪠 Plumber", salary: 6767),
                               CareerJob(jobTitle: "🧠 Therapist", salary: 5987),
                               CareerJob(jobTitle: "🩺 Doctor", salary: 5987),
                               CareerJob(jobTitle: "👩‍⚕️ Surgeon", salary: 5987),
                               CareerJob(jobTitle: "🏦 Banker", salary: 5987),
                               CareerJob(jobTitle: "🚔 Police Officer", salary: 5987),
                               CareerJob(jobTitle: "📲 Software Developer", salary: 5987),
                               CareerJob(jobTitle: "🧑🏻‍💻 Ethican Hacker", salary: 5987),
                               CareerJob(jobTitle: "👨🏼‍💼 Lawyer", salary: 5987),
                               CareerJob(jobTitle: "👩🏿‍⚖️ Judge", salary: 5987),
                               CareerJob(jobTitle: "🧾 Accountant", salary: 5987),
                               CareerJob(jobTitle: "📊 Business Analyst", salary: 5987),
                               CareerJob(jobTitle: "💊 Pharmacist", salary: 5987),
                               CareerJob(jobTitle: "🧑‍🍳 Chef", salary: 5987)
]

let otherJobs: [OtherJob] = [OtherJob(jobTitle: "🍑 Prostitute", salary: 484),
                             OtherJob(jobTitle: "⛺️ Beggar", salary: 454),
                             OtherJob(jobTitle: "🤡 Clown", salary: 292),
                             OtherJob(jobTitle: "🕺🏽 Street Dancer", salary: 345),
                             OtherJob(jobTitle: "👩‍🍼 Babysitter", salary: 302),
                             OtherJob(jobTitle: "🔫 Army", salary: 940),
                             OtherJob(jobTitle: "🚒 Firefighter", salary: 696)
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
