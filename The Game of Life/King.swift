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
//jan 18: 4730 total (ALMOST AT 5k!!! 5 fucking k lets fucking go bro)




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
        
        self.gender = Genders.allCases.randomElement()! == .male ? "male" : "female"
        self.emoji = babyEmojis.randomElement()!
        self.name = gender == "male" ? maleNames.randomElement()! : femaleNames.randomElement()!
        //self.yearsOld = months_old / 12
        
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
    
    @AppStorage("mom_name") var mom_name = ""
    @AppStorage("mom_age") var mom_age = 0
    @AppStorage("mom_emoji") var mom_emoji = ""
    @AppStorage("mom_status") var mom_status = 100 {
        didSet {
            limitStatus()
        }
    }
    
    @AppStorage("dad_name") var dad_name = ""
    @AppStorage("dad_age") var dad_age = 0
    @AppStorage("dad_emoji") var dad_emoji = ""
    @AppStorage("dad_status") var dad_status = 100  {
        didSet {
            limitStatus()
        }
    }
    
    
    
    //MARK: ROMANCE STUFF
    @AppStorage("partner1_name") var partner1_name = ""
    @AppStorage("partner1_emoji") var partner1_emoji = ""
    @AppStorage("partner1_age") var partner1_age = 0
    @AppStorage("partner1_status") var partner1_status = 0 {
        didSet {
            limitStatus()
        }
    }
    
    @AppStorage("partner2_name") var partner2_name = ""
    @AppStorage("partner2_age") var partner2_age = 0
    @AppStorage("partner2_emoji") var partner2_emoji = ""
    @AppStorage("partner2_status") var partner2_status = 0 {
        didSet {
            limitStatus()
        }
    }
    
    @AppStorage("partner3_name") var partner3_name = ""
    @AppStorage("partner3_age") var partner3_age = 0
    @AppStorage("partner3_emoji") var partner3_emoji = ""
    @AppStorage("partner3_status") var partner3_status = 0 {
        didSet {
            limitStatus()
        }
    }
    
    @AppStorage("partner4_name") var partner4_name = ""
    @AppStorage("partner4_age") var partner4_age = 0
    @AppStorage("partner4_emoji") var partner4_emoji = ""
    @AppStorage("partner4_status") var partner4_status = 0 {
        didSet {
            limitStatus()
        }
    }
    
    
    
    //MARK: PLAYER STUFF

    @AppStorage("name") var name: String = ""
    @AppStorage("emoji") var emoji: String = ""
    @AppStorage("gender") var gender: String = ""
    @AppStorage("months_old") var months_old: Int = 0
    lazy var yearsOld: Int = months_old / 12
    
    @AppStorage("age_stage") var age_stage: AgeStages = .baby
    
    
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
    
    enum Partners {
        case all, partner1, partner2, partner3, partner4
    }
    
    
    enum AgeStages: String {
        case baby = "baby"
        case kid = "kid"
        case adult = "adult"
        case elder = "elder"
    }
    
    func reset() {
        resetFinances()
        resetEmotions()
        resetParents()
        resetSelf()
        resetRomance(.all)
    }
    
    func resetRomance(_ mode: Partners) {
        switch mode {
            case .all:
                resetRomance(.partner1)
                resetRomance(.partner2)
                resetRomance(.partner3)
                resetRomance(.partner4)
            case .partner1:
                partner1_age = 0
                partner1_status = 0
                partner1_name = ""
                partner1_emoji = ""
            case .partner2:
                partner2_age = 0
                partner2_status = 0
                partner2_name = ""
                partner2_emoji = ""
            case .partner3:
                partner3_age = 0
                partner3_status = 0
                partner3_name = ""
                partner3_emoji = ""
            case .partner4:
                partner4_age = 0
                partner4_status = 0
                partner4_name = ""
                partner4_emoji = ""
        }
    }
    func resetSelf() {
        gender = Genders.allCases.randomElement()! == .male ? "male" : "female"
        emoji = babyEmojis.randomElement()!
    }
    
    enum Resettable {
        case health
    }
    
    func limitStatus() {
        
        if partner4_status < 0 {
            partner4_status = 0
        }
        if partner4_status > 100 {
            partner4_status = 100
        }
        
        if partner3_status < 0 {
            partner3_status = 0
        }
        if partner3_status > 100 {
            partner3_status = 100
        }
        
        if partner2_status < 0 {
            partner2_status = 0
        }
        if partner2_status > 100 {
            partner2_status = 100
        }
        
        if partner1_status < 0 {
            partner1_status = 0
        }
        if partner1_status > 100 {
            partner1_status = 100
        }
        
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
    func resetParents() {
        mom_name = femaleNames.randomElement()!
        mom_age = Int.random(in: 25...45)
        mom_emoji = momEmojis.randomElement()!
        mom_status = 100
        
        dad_name = maleNames.randomElement()!
        dad_age = Int.random(in: 25...45)
        dad_emoji = dadEmojis.randomElement()!
        dad_status = 100
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
    func checkAgeStage() {
        if yearsOld < 5 {
            age_stage = .baby
        } else if yearsOld < 18 {
            age_stage = .kid
            emoji = gender == "male" ? boyEmojis.randomElement()! : girlEmojis.randomElement()!
        } else if yearsOld < 50 {
            age_stage = .adult
            emoji = gender == "male" ? dadEmojis.randomElement()! : momEmojis.randomElement()!
        } else {
            age_stage = .elder
            emoji = gender == "male" ? grandpaEmojis.randomElement()! : grandmaEmojis.randomElement()!
        }
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
