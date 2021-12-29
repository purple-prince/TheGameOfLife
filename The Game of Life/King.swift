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

func formatNum(_ _num: Int) -> String {
        var num = _num
        let strNum = String(num)
        var digits: [String] = []
        var i = 1

        while num != 0 {
          digits.append(String(num % 10))
          num /= 10
          if i % 3 == 0 {
              digits.append(",")
          }
          i += 1
        }
        digits.reverse()
        if strNum.count % 3 == 0 {
          digits.removeFirst(1)
        }

        return digits.joined()
}



