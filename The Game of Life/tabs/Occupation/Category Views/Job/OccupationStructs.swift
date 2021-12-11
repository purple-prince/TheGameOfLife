//
//  OccupationStructs.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/23/21.
//

import Foundation

struct Job {
    var jobTitle: String
    var salary: Int
}

struct SideHustle: Hashable {
    let id = UUID()
    var shTitle: String
    var level = 1
    var salaryMin: Int
    var salaryMax: Int
}

struct Sports {
    
}

struct RealEstate {
    
}

struct Crime {
    
}
