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

let hourlyJobs : [Job] = [
    Job(jobTitle: "👨‍🔧 Car Mechanic",        salary: 2880, requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -2, energyMod: -4, description: ""),
    Job(jobTitle: "🥪 Sandwhich Maker",     salary: 1400, requirements: [.elementary, .highSchool], healthMod: 0, hapMod: -2, energyMod: -2, description: ""),
    Job(jobTitle: "📝 Waiter",              salary: 1760, requirements: [.elementary, .highSchool], healthMod: 0, hapMod: -2, energyMod: -2, description: ""),
    Job(jobTitle: "👷🏿‍♀️ Construction Worker", salary: 3050, requirements: [.elementary], healthMod: 0, hapMod: -2, energyMod: -2, description: ""),
    Job(jobTitle: "🚛 Truck Driver",        salary: 3360, requirements: [.elementary], healthMod: 0, hapMod: -2, energyMod: -2, description: ""),
    Job(jobTitle: "💈 Barber",              salary: 2600, requirements: [.elementary], healthMod: 0, hapMod: -2, energyMod: -2, description: ""),
    Job(jobTitle: "🌳 Lawn Mower",          salary: 2400, requirements: nil, healthMod: 0, hapMod: -2, energyMod: -2, description: ""),
    Job(jobTitle: "📚 Librarian",           salary: 4250, requirements: [.elementary, .highSchool], healthMod: 0, hapMod: -2, energyMod: -2, description: "Tell me you're boring and don't have a life without telling me you're boring and dont have a life")
]

let careerJobs: [Job] = [
    Job(jobTitle: "🛩 Aerospace Engineer", salary: 7083,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -2, energyMod: -2, description: "Big brain stuff. Elon who?"),
    Job(jobTitle: "🧑🏼‍🌾 Farmer",             salary: 6150,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -2, energyMod: -2, description: "It ain't much but it's honest work."),
    Job(jobTitle: "🏙 Architect",          salary: 5815,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -2, energyMod: -2, description: "Bob the builder, Sr."),
    Job(jobTitle: "🦷 Dentist",            salary: 14166, requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -2, energyMod: -2, description: "People hate seeing you."),
    Job(jobTitle: "💸 Financial Advisor",  salary: 3968,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "🈺 Translator",         salary: 2968,  requirements: [.elementary, .highSchool], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "🧑🏿‍🏫 Teacher",            salary: 5968,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: "Lame version of professor"),
    Job(jobTitle: "👨🏽‍🏫 Professor",          salary: 8968,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: "Cool version of teacher."),
    Job(jobTitle: "🧑🏽‍⚕️ Physician",          salary: 968,   requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: "The only plus of this job is getting to crack people's necks and backs everyday."),
    Job(jobTitle: "🪠 Plumber",            salary: 2968,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: "Uh oh, stinky"),
    Job(jobTitle: "🧠 Therapist",          salary: 1968,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "🩺 Doctor",             salary: 5968,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: "I'm just gonna take a peek down here to make sure everything's growing alright..."),
    Job(jobTitle: "👩‍⚕️ Surgeon",            salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "🏦 Banker",             salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "🚔 Police Officer",     salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: "<Insert description that isn't political or  controversial>"),
    Job(jobTitle: "📲 Software Developer", salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "🧑🏻‍💻 Ethican Hacker",     salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "👨🏼‍💼 Lawyer",             salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "👩🏿‍⚖️ Judge",              salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "🧾 Accountant",         salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "📊 Business Analyst",   salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "💊 Pharmacist",         salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: "Workin in da Perc Palace 😳"),
    Job(jobTitle: "🧑‍🍳 Chef",               salary: 5987,  requirements: [.elementary, .highSchool, .college], healthMod: 0, hapMod: -3, energyMod: -2, description: "Serve people a crumb of steak with some sauce in a fancy design and charge them so much they lose their house"),
]

let otherJobs: [Job] = [
    Job(jobTitle: "🍑 Prostitute",    salary: 484,  requirements: nil, healthMod: 0, hapMod: -3, energyMod: -2, description: "Hey, $20 is $20 🤷‍♂️"),
    Job(jobTitle: "⛺️ Beggar",        salary: 454,  requirements: nil, healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "🤡 Clown",         salary: 292,  requirements: nil, healthMod: 0, hapMod: -3, energyMod: -2, description: "Also known as \"Chicago Bears fan\" or \"Vegans\""),
    Job(jobTitle: "🕺🏽 Street Dancer", salary: 345,  requirements: nil, healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "👩‍🍼 Babysitter",    salary: 302,  requirements: nil, healthMod: 0, hapMod: -3, energyMod: -2, description: "Not to be confused with sitting on babies."),
    Job(jobTitle: "🔫 Army",          salary: 940,  requirements: nil, healthMod: 0, hapMod: -3, energyMod: -2, description: ""),
    Job(jobTitle: "📱TikTokker",      salary: 320,  requirements: nil, healthMod: 0, hapMod: 0,  energyMod: 0,  description: "Talent-less scum of society"),
    Job(jobTitle: "🚒 Firefighter",   salary: 696,  requirements: nil, healthMod: 0, hapMod: -3, energyMod: -2, description: "")
]


// prostitute, beggar, army?, circus, street dancer/music, babysitter

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
