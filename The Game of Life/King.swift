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

var colorOptions: [Color] = [Color("mainDarkGray"), Color("mainRed"), Color("mainOrange"), Color("mainLightGreen"), Color("mainMutedBlue")]

func formatNum(_ num: Int) -> String {
    
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 2
    
    if num < 1000 {
        return "$" + String(num)
    }
    
    //                 4-6  7-9  10-12 13-15
    let prefixes = ["", "K", "M", "B", "T", "Qa", "Qi", "Sex", "Sep", "Oct", "Non", "Dec", "Und", "Duo", "Tre", "Quatt", "Quindec", "Sexdec", "Septen", "Octo", "Novem", "Vigin", "Cent"]
    let strNum = String(num)//2000
    var index: Int {((strNum.count - 1) / 3)}
    //formatter(Float(num / 1000))
    //formatter.string(from: NSNumber(value: ___))
    if num < 1_000_000 { // million
        return "$" + formatter.string(from: NSNumber(value: Float(num) / 1000))! + prefixes[index]
    } else if num < 1_000_000_000 { // billion
        return "$" + formatter.string(from: NSNumber(value: Float(num) / 1000000))! + prefixes[index]
    } else if num < 1000000000000 { // trillion
        return "$" + formatter.string(from: NSNumber(value: Float(num) / 1000000000))! + prefixes[index]
    } else if num < 1000000000000000 { //quadrillion
        return "$" + formatter.string(from: NSNumber(value: Float(num) / 1000000000000))! + prefixes[index]
    } else if num < 1_000_000_000_000_000_000 { //quintillion
        return "$" + formatter.string(from: NSNumber(value: Float(num) / 1000000000000000))! + prefixes[index]
    } else {
        return "Wayyyy too much money. you're rich af"
    }

    //formatter.numberStyle = .currency
    
    
}

func restartLife() -> Void {
    @AppStorage("life_cash_balance") var life_cash_balance = 0
    @AppStorage("life_bank_balance") var life_bank_balance = 0
    life_cash_balance -= life_cash_balance
    life_bank_balance -= life_bank_balance
}

func limitStatus() -> Void {
    @AppStorage("life_health_status") var life_health_status: Int = 0
    @AppStorage("life_happiness_status") var life_happiness_status: Int = 0
    @AppStorage("life_energy_status") var life_energy_status: Int = 0
    
    if life_health_status < 0 {
        life_health_status = 0
    }
    if life_health_status > 100 {
        life_health_status = 100
    }
    
    if life_happiness_status < 0 {
        life_happiness_status = 0
    }
    if life_happiness_status > 100 {
        life_happiness_status = 100
    }
    
    if life_energy_status < 0 {
        life_energy_status = 0
    }
    if life_energy_status > 100 {
        life_energy_status = 100
    }
}



/*
 net worth:
 
 - cash
 - bank
 - real estate
 - assets
 */
