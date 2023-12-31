//
//  OccupationStructs.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/23/21.
//

import Foundation

struct Job: Occupation, Equatable {
    
    enum JobRequirement {
        case elementary, highSchool, college
    }
    
    var jobTitle: String
    var salary: Int
    var requirements: [JobRequirement]?
    var healthMod: Int
    var hapMod: Int
    var energyMod: Int
    var description: String
    var id = UUID()
}

struct SideHustle: Hashable {
    let id = UUID()
    var shTitle: String
    var level = 0
    var salaryMin: Int
    var salaryMax: Int
    
    
}
