//
//  King.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import Foundation
import SwiftUI

var tempParents = Parents() //temp parent... referenced from ParentStructs
var userEmoji = "🧑🏽"
var hasChildren = true
var tempChild = Child()
var tempChild2 = Child()
var tempChild3 = Child()
var numKids = 3

struct King {
    @State var directDepositOn = false
}

var user = King()
