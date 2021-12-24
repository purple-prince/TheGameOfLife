//
//  King.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//



//CODE COUNT

//cd /Users/charliereeder/Desktop/xcode\ projs/The\ Game\ of\ Life
//find . -path ./Pods -prune -o -name '*.swift' -print0 ! -name '/Pods' | xargs -0 wc -l
//3106 total




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

protocol Person {
    var name: String { get }
}

var allPartners: [Partner] = []

var tempPartner = Partner(gender: "Female", age: 25)

///////////////////////////////////////
struct UserPreferences {
    @AppStorage("color_index") var colorCount: Int = 0
    
    var colorOptions: [Color] = [Color("mainRed"), Color("mainOrange"), Color("mainYellow"), Color("mainLightGreen"), Color("mainMutedBlue"), Color("mainDarkGray")]
    
    var appColor: Color {
        colorOptions[colorCount]
    }
}

var colorOptions: [Color] = [Color("mainDarkGray"), Color("mainRed"), Color("mainOrange"), Color("mainYellow"), Color("mainLightGreen"), Color("mainMutedBlue")]


//MARK: APP COLOR
/*
 @AppStorage("app_color_index") var colorCount: Int = 0

 var appColor: Color {
     colorOptions[colorCount]
 }
 */

//struct userPreferences {
    //var colorCount: Int = {}()
    //var colorOptions: [Color] = {}()
    //@AppStorage var appColor: Color = colorOptions[colorCount]
//}

//var user = userPreferences(colorCount: 0, colorOptions: [Color("mainDarkGray"), Color("mainRed"), Color("mainOrange"), Color("mainYellow"), Color("mainLightGreen"), Color("mainMutedBlue")])
