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

enum RelationshipTypes: CaseIterable {
    case parents, romance, children, friends, pets
}

var colorOptions: [Color] = [Color("mainRed"), Color("mainOrange"), Color("mainLightGreen"), Color("mainMutedBlue")]

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

//Haptic manager singleton
class HapticManager {
    
    enum HapticTypes {
        case light, medium, heavy, rigid, soft, success, warning, error
    }
    
    //let type: HapticTypes
    static let instance = HapticManager()
    
    func playHaptic(type: HapticTypes) {
        switch type {
            case .light:
                let generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.light)
                generator.impactOccurred()
            case .medium:
                let generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.medium)
                generator.impactOccurred()
            case .heavy:
                let generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
                generator.impactOccurred()
            case .rigid:
                let generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.rigid)
                generator.impactOccurred()
            case .soft:
                let generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.soft)
                generator.impactOccurred()
            case .success:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            case .warning:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)
            case .error:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
        }
    }
    
}

class UserPreferences: ObservableObject {
        
    @AppStorage("app_color_index") var colorCount: Int = 0

    var appColor: Color {
        colorOptions[colorCount]
    }
}

class Player: ObservableObject {
    
    init() {
        //self.mom = Parent(parent: .mom)
        //self.dad = Parent(parent: .dad)
        
        self.mom_name = femaleNames.randomElement()!
        self.mom_age = Int.random(in: 25...45)
        self.mom_emoji = momEmojis.randomElement()!
        self.mom_status = 100
        
        self.dad_name = maleNames.randomElement()!
        self.dad_age = Int.random(in: 25...45)
        self.dad_emoji = dadEmojis.randomElement()!
        self.dad_status = 100
        
    }
    
    
    //MARK: PARENT STUFF
    // // // // // // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // // // // // // //
    //var mom: Parent
    //var dad: Parent
    
    @AppStorage("mom_name") var mom_name = ""
    @AppStorage("mom_age") var mom_age = 0
    @AppStorage("mom_emoji") var mom_emoji = ""
    @AppStorage("mom_status") var mom_status = 100
    
    @AppStorage("dad_name") var dad_name = ""
    @AppStorage("dad_age") var dad_age = 0
    @AppStorage("dad_emoji") var dad_emoji = ""
    @AppStorage("dad_status") var dad_status = 100
    
    
    
    //MARK: PLAYER STUFF
    // // // // // // // // // // // // // // // // // // // // // // // // //
    // // // // // // // // // // // // // // // // // // // // // // // // // 
    @AppStorage("emoji") var emoji: String = ""
    @AppStorage("on_new_life") var on_new_life: Bool = true
    @AppStorage("life_cash_balance") var life_cash_balance = 0
    @AppStorage("life_bank_balance") var life_bank_balance = 0
    
    @AppStorage("life_health_status") var life_health_status = 100 {
        didSet {
            limitStatus()
        }
    }
    @AppStorage("life_happiness_status") var life_happiness_status = 100 {
        didSet {
            limitStatus()
        }
    }
    @AppStorage("life_energy_status") var life_energy_status = 100 {
        didSet {
            limitStatus()
        }
    }
    
    enum Genders: CaseIterable {
        case male, female
    }
    
    func reset() {
        resetFinances()
        resetEmotions()
    }
    
    func limitStatus() {
        if life_health_status < 0 {
            on_new_life = true
        }
        if life_health_status > 100 {
            life_health_status = 100
        }
        
        if life_happiness_status < 0 {
            on_new_life = true
        }
        if life_happiness_status > 100 {
            life_happiness_status = 100
        }
        
        if life_energy_status < 0 {
            on_new_life = true
        }
        if life_energy_status > 100 {
            life_energy_status = 100
        }
        
        if mom_status > 100 {
            mom_status = 100
        }
        if dad_status > 100 {
            dad_status = 100
        }
        
        if mom_status < 0 {
            mom_status = 0
        }
        
        if dad_status < 0 {
            dad_status = 0
        }

    }
    
    func resetEmotions() {
        life_health_status = 100
        life_energy_status = 100
        life_happiness_status = 100
    }
    func resetFinances() {
        life_cash_balance = 0
        life_bank_balance = 0
    }
    
}

/*class Parent: ObservableObject {
    
    fileprivate var emoji: String
    fileprivate var parent: Parents
    fileprivate var name: String
    fileprivate var gender: Genders
    fileprivate var status: Int = 100 {
        didSet {
            if status > 100 {
                status = 100
            }
            if status < 0 {
                status = 0
            }
        }
    }
        
    init(parent: Parents) {
        self.parent = parent
        self.name = self.parent == .mom ? femaleNames.randomElement()! : maleNames.randomElement()!
        self.gender = self.parent == .mom ? .female : .male
        self.emoji = self.parent == .mom ? momEmojis.randomElement()! : dadEmojis.randomElement()!
    }
    
    fileprivate enum Parents {
        case mom, dad
    }
    fileprivate enum Genders {
        case female, male
    }
}*/
