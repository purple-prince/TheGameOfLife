//
//  King.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//



//CODE COUNT

//cd /Users/charliereeder/Desktop/xcode\ projs/The\ Game\ of\ Life
//find . -path ./Pods -prune -o -name '*.swift' -print0 ! -name '/Pods' | xargs -0 wc -l
//3106 total :
//jan 18: 4730 total (ALMOST AT 5k!!! 5 fucking k lets fucking go bro)
//feb 9: 7103 total  ez. ez shit.
//march 7: 8922 we gna finish this withing 20k lines fasho  ! !




import Foundation
import SwiftUI

enum RelationshipTypes: CaseIterable {
    case parents, romance, children, friends, pets
}

var colorOptions: [Color] = [Color("mainRed"), Color("mainOrange"), Color("mainLightGreen"), Color("mainMutedBlue")]

func formatNum(_ num: Int) -> String {

    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 1

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
        //colorOptions[colorCount]
        Color.red
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
        
        setStockPoints()

    }
    
    func setStockPoints() {
        stock_points = ""
        var num = 50
        var variation = 25
        for _ in 0...9 {
            //num = Int.random(in: (num - 50 > 0 ? num - 50 : 0)...(num + 50 < 100 ? num + 50 : 100))
            num = Int.random(in: (num - variation > 0 ? num - variation : 0)...(num + variation < 100 ? num + variation : 100))
            stock_points += String(num)
            stock_points += " "
        }
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
    @AppStorage("partner1_name")   var partner1_name   = ""
    @AppStorage("partner1_emoji")  var partner1_emoji  = ""
    @AppStorage("partner1_age")    var partner1_age    = 0
    @AppStorage("partner1_status") var partner1_status = 0 {
        didSet {
            limitStatus()
        }
    }
    @AppStorage("partner2_name")   var partner2_name   = ""
    @AppStorage("partner2_age")    var partner2_age    = 0
    @AppStorage("partner2_emoji")  var partner2_emoji  = ""
    @AppStorage("partner2_status") var partner2_status = 0 {
        didSet {
            limitStatus()
        }
    }
    @AppStorage("partner3_name")   var partner3_name   = ""
    @AppStorage("partner3_age")    var partner3_age    = 0
    @AppStorage("partner3_emoji")  var partner3_emoji  = ""
    @AppStorage("partner3_status") var partner3_status = 0 {
        didSet {
            limitStatus()
        }
    }
    @AppStorage("partner4_name")   var partner4_name   = ""
    @AppStorage("partner4_age")    var partner4_age    = 0
    @AppStorage("partner4_emoji")  var partner4_emoji  = ""
    @AppStorage("partner4_status") var partner4_status = 0 {
        didSet {
            limitStatus()
        }
    }
    
    
    //MARK: FRIENDS STUFF
    @AppStorage("friend1_name")   var friend1_name   = ""
    @AppStorage("friend1_emoji")  var friend1_emoji  = ""
    @AppStorage("friend1_age")    var friend1_age    = 0
    @AppStorage("friend1_status") var friend1_status = 0
    @AppStorage("friend2_name")   var friend2_name   = ""
    @AppStorage("friend2_emoji")  var friend2_emoji  = ""
    @AppStorage("friend2_age")    var friend2_age    = 0
    @AppStorage("friend2_status") var friend2_status = 0
    @AppStorage("friend3_name")   var friend3_name   = ""
    @AppStorage("friend3_emoji")  var friend3_emoji  = ""
    @AppStorage("friend3_age")    var friend3_age    = 0
    @AppStorage("friend3_status") var friend3_status = 0
    @AppStorage("friend4_name")   var friend4_name   = ""
    @AppStorage("friend4_emoji")  var friend4_emoji  = ""
    @AppStorage("friend4_age")    var friend4_age    = 0
    @AppStorage("friend4_status") var friend4_status = 0
    
    
    //MARK: PETS STUFF
    @AppStorage("pet_types") var pet_types = "" {
        didSet {
            if pet_types != "" && pet_types.last != " " {
                pet_types += " "
            }
        }
    }
    @AppStorage("pet_names") var pet_names = "" {
        didSet {
            if pet_names != "" && pet_names.last != " " {
                pet_names += " "
            }
        }
    }
    @AppStorage("pet_status") var pet_status = "" {
        didSet {
            if pet_status != "" && pet_status.last != " " {
                pet_status = pet_status + " "
            }
        }
    }
    @AppStorage("pet_ids") var pet_ids = "" {
        didSet {
            if pet_ids != "" && pet_ids.last != " "{
                pet_ids += " "
                updateAllPets()
            }
        }
    }
    
    func getPetEmoji(index: Int) -> String {
        switch pet_types.split(separator: " ")[index] {
            case "Cat":
                return "🐱"
            case "Dog":
                return "🐶"
            case "Fish":
                return "🐠"
            case "Bird":
                return "🐦"
            case "Rabbit":
                return "🐰"
            case "Turtle":
                return "🐢"
            case "Alligator":
                return "🐊"
            case "Monke":
                return "🦧"
            default:
                return "error!!"
        }
    }
    func getPetHapMod(index: Int) -> Int {
        switch pet_types.split(separator: " ")[index] {
            case "Cat":
                return Pet.Cat.hapMod
            case "Dog":
                return Pet.Dog.hapMod
            case "Fish":
                return Pet.Fish.hapMod
            case "Bird":
                return Pet.Bird.hapMod
            case "Rabbit":
                return Pet.Rabbit.hapMod
            case "Turtle":
                return Pet.Turtle.hapMod
            case "Alligator":
                return Pet.Alligator.hapMod
            case "Monkey":
                return Pet.Monkey.hapMod
            default:
                return -1
        }
    }
    func getPetCost(index: Int) -> Int {
        switch pet_types.split(separator: " ")[index] {
            case "Cat":
                return Pet.Cat.cost
            case "Dog":
                return Pet.Dog.cost
            case "Fish":
                return Pet.Fish.cost
            case "Bird":
                return Pet.Bird.cost
            case "Rabbit":
                return Pet.Rabbit.cost
            case "Turtle":
                return Pet.Turtle.cost
            case "Alligator":
                return Pet.Alligator.cost
            case "Monkey":
                return Pet.Monkey.cost
            default:
                return -1
        }
    }
    
    func updateAllPets() {
        
        allPets.removeAll()
        
        for i in 0...(pet_types.split(separator: " ").count - 1) {
            allPets.append(Pet(emoji: getPetEmoji(index: i),
                               animal: String(pet_types.split(separator: " ")[i]),
                               hapMod: getPetHapMod(index: i),
                               cost: getPetCost(index: i),
                               name: String(pet_names.split(separator: " ")[i]),
                               status: Int(pet_status.split(separator: " ")[i])!,
                               id: String(pet_ids.split(separator: " ")[i])
                              )
            )
        }
    }
    var allPets: [Pet] = []





    //MARK: PLAYER STUFF

    @AppStorage("name") var name: String = ""
    @AppStorage("emoji") var emoji: String = ""
    @AppStorage("gender") var gender: String = ""
    @AppStorage("months_old") var months_old: Int = 0 {
        didSet {
            if (months_old / 12) / 100 >= 1 {
                on_new_life = true
                reset()
            }
            
            life_bank_balance += Int(Double(life_bank_balance) * (Double(interest_percent) / 100.0))
            loan_debt += Int(Double(loan_debt) * (Double(interest_percent) / 100.0))
            addSHIncome()
            
            for pet in pet_types.split(separator: " ") {
                switch pet {
                    case Pet.Dog.animal:
                        life_cash_balance -= Pet.Dog.cost
                        life_happiness_status += Pet.Dog.hapMod
                        //pet_status.split(separator)
                    case Pet.Cat.animal:
                        life_cash_balance -= Pet.Cat.cost
                        life_happiness_status += Pet.Cat.hapMod
                    case Pet.Fish.animal:
                        life_cash_balance -= Pet.Fish.cost
                        life_happiness_status += Pet.Fish.hapMod
                    case Pet.Bird.animal:
                        life_cash_balance -= Pet.Bird.cost
                        life_happiness_status += Pet.Bird.hapMod
                    case Pet.Turtle.animal:
                        life_cash_balance -= Pet.Turtle.cost
                        life_happiness_status += Pet.Turtle.hapMod
                    case Pet.Rabbit.animal:
                        life_cash_balance -= Pet.Rabbit.cost
                        life_happiness_status += Pet.Rabbit.hapMod
                    case Pet.Alligator.animal:
                        life_cash_balance -= Pet.Alligator.cost
                        life_happiness_status += Pet.Alligator.hapMod
                    case Pet.Monkey.animal:
                        life_cash_balance -= Pet.Monkey.cost
                        life_happiness_status += Pet.Monkey.hapMod
                    default:
                        print("Error in pet thing in age update in king")
                }
            }
            
            eat()
            
            var tempPoints = stockPoints
            for i in 0...tempPoints.count - 2 {
                tempPoints[i] = tempPoints[i + 1]
            }
            tempPoints[tempPoints.count - 1] = Int.random(in: 0...100)
            stock_points = ""
            for elem in tempPoints {
                stock_points += String(elem)
                stock_points += " "
            }
            
        }
    }

    var yearsOld: Int {months_old / 12}

    @AppStorage("age_stage") var age_stage: AgeStages = .baby
    @AppStorage("on_new_life") var on_new_life: Bool = true

    //MARK: STATUS STUFF
    
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
    
    @AppStorage("vegan_meals")      var vegan_meals:      Int = 0
    @AppStorage("vegetarian_meals") var vegetarian_meals: Int = 0
    @AppStorage("average_meals")    var average_meals:    Int = 0
    @AppStorage("america_meals")    var america_meals:    Int = 0
    @AppStorage("fastfood_meals")   var fastfood_meals:   Int = 0
    @AppStorage("poop_meals")       var poop_meals:       Int = 0




    //MARK: MONEY STUFF

    @AppStorage("life_cash_balance") var life_cash_balance = 0
    @AppStorage("life_bank_balance") var life_bank_balance = 0
    @AppStorage("direct_deposit_on") var direct_deposit_on = false
    @AppStorage("interest_percent") var interest_percent: Double = 2.5
    @AppStorage("loan_debt") var loan_debt: Int = 0
    @AppStorage("loan_taken") var loan_taken: Int = 0
    @AppStorage("life_job_title") var life_job_title: String?
    @AppStorage("life_job_salary") var life_job_salary: Int?
    @AppStorage("total_lottery_winnings") var total_lottery_winnings = 0
    
    @AppStorage("stock_points") var stock_points = ""
    var stockPoints: [Int] {
        var arr: [Int] = []
        let stockPointsArray = stock_points.split(separator: " ")
        for i in stockPointsArray {
            arr.append(Int(i) ?? 0)
        }
        return arr
    }
    


    @AppStorage("begun_sh") var begun_sh = false

    @AppStorage("sh_youtube") var sh_youtube = 0.0 {
        didSet {
            if sh_youtube != 0 {
                if Int(sh_youtube) - Int(oldValue) > 0 {
                    incrementIncome(mode: .youtube)
                }
            }
            
            if sh_youtube > 10.0 {
                sh_youtube = 10.0
            }
        }
    }
    @AppStorage("sh_youtube_count") var sh_youtube_count = 0 {
        didSet {
            setNewIncomeItem(mode: .youtube)
        }
    }
    @AppStorage("sh_youtube_progress") var sh_youtube_progress = 0.0
    @AppStorage("sh_youtube_income") var sh_youtube_income = 0
    @AppStorage("sh_youtube_time") var sh_youtube_time = 0 {
        didSet {
            if sh_youtube_time != 0 {
                //i think this updates the level every year of time spend sh-ing
                if Int(sh_youtube_time) % 12 - Int(oldValue) % 12 > 0 {
                    updateSHProgress(mode: .youtube)
                }
            }
        }
    }

    @AppStorage("sh_music") var sh_music = 0.0 {
        didSet {
            if sh_music != 0 {
                if Int(sh_music) - Int(oldValue) > 0 {
                    incrementIncome(mode: .music)
                }
            }
            
            /*if sh_music > shInfo[.music]![.maxLevel]! {
                sh_music = shInfo[.music]![.maxLevel]!
            }*/
            if sh_music > 10.0 {
                sh_music = 10.0
            }
        }
    }
    @AppStorage("sh_music_count") var sh_music_count = 0 {
        didSet {
            setNewIncomeItem(mode: .music)
        }
    }
    @AppStorage("sh_music_progress") var sh_music_progress = 0.0
    @AppStorage("sh_music_income") var sh_music_income = 0
    @AppStorage("sh_music_time") var sh_music_time = 0 {
        didSet {
            if sh_music_time != 0 {
                //i think this updates the level every year of time spend sh-ing
                if Int(sh_music_time) % 12 - Int(oldValue) % 12 > 0 {
                    updateSHProgress(mode: .music)
                }
            }
        }
    }
    
    @AppStorage("sh_apps") var sh_apps = 0.0 {
        didSet {
            if sh_apps != 0 {
                if Int(sh_apps) - Int(oldValue) > 0 {
                    incrementIncome(mode: .apps)
                }
            }
            
            if sh_apps > 10 {
                sh_apps = 10
            }
        }
    }
    @AppStorage("sh_apps_count") var sh_apps_count = 0 {
        didSet {
            setNewIncomeItem(mode: .apps)
        }
    }
    @AppStorage("sh_apps_progress") var sh_apps_progress = 0.0
    @AppStorage("sh_apps_income") var sh_apps_income = 0//3/5
    @AppStorage("sh_apps_time") var sh_apps_time = 0 {
        didSet {
            if sh_apps_time != 0 {
                //i think this updates the level every year of time spend sh-ing
                if Int(sh_apps_time) % 12 - Int(oldValue) % 12 > 0 {
                    updateSHProgress(mode: .apps)
                }
            }
        }
    }

    @AppStorage("sh_babysitter") var sh_babysitter = 0.0 {
        didSet {
            if sh_babysitter != 0 {
                if Int(sh_babysitter) - Int(oldValue) > 0 {
                    incrementIncome(mode: .babysitting)
                }
            }
            
            if sh_babysitter > 10.0 {
                sh_babysitter = 10.0
            }
        }
    }
    @AppStorage("sh_babysitter_count") var sh_babysitter_count = 0 {
        didSet {
            setNewIncomeItem(mode: .babysitting)
        }
    }
    @AppStorage("sh_babysitter_progress") var sh_babysitter_progress = 0.0
    @AppStorage("sh_babysitter_income") var sh_babysitter_income = 0
    @AppStorage("sh_babysitter_time") var sh_babysitter_time = 0 {
        didSet {
            if sh_babysitter_time != 0 {
                //i think this updates the level every year of time spend sh-ing
                if Int(sh_babysitter_time) % 12 - Int(oldValue) % 12 > 0 {
                    updateSHProgress(mode: .babysitting)
                }
            }
        }
    }

    @AppStorage("sh_selling") var sh_selling = 0.0 {
        didSet {
            if sh_selling != 0 {
                if Int(sh_selling) - Int(oldValue) > 0 {
                    incrementIncome(mode: .selling)
                }
            }
            
            if sh_selling > 10.0 {
                sh_selling = 10.0
            }
        }
    }
    @AppStorage("sh_selling_count") var sh_selling_count = 0 {
        didSet {
            setNewIncomeItem(mode: .selling)
        }
    }
    @AppStorage("sh_selling_progress") var sh_selling_progress = 0.0
    @AppStorage("sh_selling_income") var sh_selling_income = 0
    @AppStorage("sh_selling_time") var sh_selling_time = 0 {
        didSet {
            if sh_selling_time != 0 {
                //i think this updates the level every year of time spend sh-ing
                if Int(sh_selling_time) % 12 - Int(oldValue) % 12 > 0 {
                    updateSHProgress(mode: .selling)
                }
            }
        }
    }

    @AppStorage("sh_artist") var sh_artist = 0.0 {
        didSet {
            if sh_artist != 0 {
                if Int(sh_artist) - Int(oldValue) > 0 {
                    incrementIncome(mode: .art)
                }
            }
            
            if sh_artist > 10.0 {
                sh_artist = 10.0
            }
        }
    }
    @AppStorage("sh_artist_count") var sh_artist_count = 0 {
        didSet {
            setNewIncomeItem(mode: .art)
        }
    }
    @AppStorage("sh_artist_progress") var sh_artist_progress = 0.0
    @AppStorage("sh_artist_income") var sh_artist_income = 0
    @AppStorage("sh_artist_time") var sh_artist_time = 0 {
        didSet {
            
            if sh_artist_time != 0 {
                //i think this updates the level every year of time spend sh-ing
                if Int(sh_artist_time) % 12 - Int(oldValue) % 12 > 0 {
                    updateSHProgress(mode: .art)
                }
            }
            
        }
    }

    public enum SHTypes {
        case youtube, music, apps, babysitting, selling, art
    }

    lazy var shEfforts: [SHTypes : [Int]] = [
        .youtube     : [1, 1, 2, 2, 3, 3, 4, 4, 5, 5], //16
        .music       : [1, 1, 1, 2, 2, 2, 3, 3, 4, 4], //10
        .apps        : [2, 2, 3, 3, 4, 4, 5, 5, 6, 7], //20
        .babysitting : [1, 1, 1, 1, 1, 1, 1, 1, 1, 1], //10
        .selling     : [1, 1, 1, 2, 2, 2, 3, 3, 3, 4], //16
        .art         : [1, 2, 3, 5, 7, 8, 9, 10, 11, 12], //20
    ]
    
    enum shInfoTypes {
        case baseIncome,
             incomeRange,
             promotionIncrease,
             maxLevel,
             effort,
             progressMultiplier
        //workBonus, //bonus for working on the same project
    }

    //adds new item's income
    func setNewIncomeItem(mode: SHTypes) {

        var min: Int
        var max: Int

        switch mode {
            case .youtube:

                min = Int(shInfo[.youtube]![.baseIncome]! - (shInfo[.youtube]![.baseIncome]! * shInfo[.youtube]![.incomeRange]!))
                max = Int(shInfo[.youtube]![.baseIncome]! + (shInfo[.youtube]![.baseIncome]! * shInfo[.youtube]![.incomeRange]!))

                sh_youtube_income += Int.random(in: min...max)
            case .apps:
                min = Int((shInfo[.apps]![.baseIncome]! - (shInfo[.apps]![.baseIncome]! * shInfo[.apps]![.incomeRange]!)))
                max = Int((shInfo[.apps]![.baseIncome]! + (shInfo[.apps]![.baseIncome]! * shInfo[.apps]![.incomeRange]!)))

                sh_apps_income += Int.random(in: min...max)
            case .music:
                min = Int((shInfo[.music]![.baseIncome]! - (shInfo[.music]![.baseIncome]! * shInfo[.music]![.incomeRange]!)))
                max = Int((shInfo[.music]![.baseIncome]! + (shInfo[.music]![.baseIncome]! * shInfo[.music]![.incomeRange]!)))

                sh_music_income += Int.random(in: min...max)
            case .babysitting:
                min = Int((shInfo[.babysitting]![.baseIncome]! - (shInfo[.babysitting]![.baseIncome]! * shInfo[.babysitting]![.incomeRange]!)))
                max = Int((shInfo[.babysitting]![.baseIncome]! + (shInfo[.babysitting]![.baseIncome]! * shInfo[.babysitting]![.incomeRange]!)))

                sh_babysitter_income += Int.random(in: min...max)
            case .selling:
                min = Int((shInfo[.selling]![.baseIncome]! - (shInfo[.selling]![.baseIncome]! * shInfo[.selling]![.incomeRange]!)))
                max = Int((shInfo[.selling]![.baseIncome]! + (shInfo[.selling]![.baseIncome]! * shInfo[.selling]![.incomeRange]!)))

                sh_selling_income += Int.random(in: min...max)
            case .art:
                min = Int((shInfo[.art]![.baseIncome]! - (shInfo[.art]![.baseIncome]! * shInfo[.art]![.incomeRange]!)))
                max = Int((shInfo[.art]![.baseIncome]! + (shInfo[.art]![.baseIncome]! * shInfo[.art]![.incomeRange]!)))

                sh_artist_income += Int.random(in: min...max)
        }
    }
    
    func incrementIncome(mode: SHTypes) {
        switch mode {
            case .youtube:
                shInfo[.youtube]![.baseIncome]! *= shInfo[.youtube]![.promotionIncrease]!
            case .apps:
                shInfo[.apps]![.baseIncome]! *= shInfo[.apps]![.promotionIncrease]!
            case .music:
                shInfo[.music]![.baseIncome]! *= shInfo[.music]![.promotionIncrease]!
            case .babysitting:
                shInfo[.babysitting]![.baseIncome]! *= shInfo[.babysitting]![.promotionIncrease]!
            case .selling:
                shInfo[.selling]![.baseIncome]! *= shInfo[.selling]![.promotionIncrease]!
            case .art:
                shInfo[.art]![.baseIncome]! *= shInfo[.art]![.promotionIncrease]!
        }
    }
    
    //update level progress
    func updateSHProgress(mode: SHTypes) {
        switch mode {
            case .youtube:
                sh_youtube    += shInfo[.youtube]![.progressMultiplier]!
            case .apps:
                sh_apps       += shInfo[.apps]![.progressMultiplier]!
            case .music:
                sh_music      += shInfo[.music]![.progressMultiplier]!
            case .babysitting:
                sh_babysitter += shInfo[.babysitting]![.progressMultiplier]!
            case .selling:
                sh_selling    += shInfo[.selling]![.progressMultiplier]!
            case .art:
                sh_artist     += shInfo[.art]![.progressMultiplier]!
        }
    }

    lazy var shInfo: [SHTypes : [shInfoTypes : Double]] = [
        .youtube     : [
            .baseIncome : 1.0,
            .incomeRange : 0.3,
            .promotionIncrease : 2.4,
            .effort : sh_youtube == 0.0 ? 1.0 : Double(shEfforts[.youtube]![Int(sh_youtube) - 1]),
            .progressMultiplier : 0.625,
            .maxLevel : 10.0
        ],
        .apps        : [
            .baseIncome : 100.0,
            .incomeRange : 0.5,
            .promotionIncrease : 1.8,
            .effort :   5.0,//sh_apps == 0.0 ? 1.0 : Double(shEfforts[.apps]![Int(sh_apps) - 1]),
            .progressMultiplier : 0.5,
            .maxLevel : 10.0
        ],
        .music       : [
            .baseIncome : 10.0,
            .incomeRange : 0.8,
            .promotionIncrease : 2.8,
            .effort : sh_music == 0.0 ? 1.0 : Double(shEfforts[.music]![Int(sh_music) - 1]),
            .progressMultiplier : 1.0,
            .maxLevel : 10.0
        ],

        .babysitting : [
            .baseIncome : 3_000.0,
            .incomeRange: 0.1,
            .promotionIncrease : 1.2,
            .effort : sh_babysitter == 0.0 ? 1.0 : Double(shEfforts[.babysitting]![Int(sh_babysitter) - 1]),
            .progressMultiplier : 1.0,
            .maxLevel : 10.0
        ],

        .selling     : [
            .baseIncome : 1.0,
            .incomeRange : 0.6,
            .promotionIncrease : 2.25,
            .effort : sh_selling == 0.0 ? 1.0 : Double(shEfforts[.selling]![Int(sh_selling) - 1]),
            .progressMultiplier : 0.625,
            .maxLevel : 10.0
        ],

        .art         : [
            .baseIncome : 10.0,
            .incomeRange: 0.9,
            .promotionIncrease : 2.0,
            .effort : 5.0,//sh_artist == 0.0 ? 1.0 : Double(shEfforts[.art]![Int(sh_artist) - 1]),
            .progressMultiplier : 0.5,
            .maxLevel : 10.0
        ]
    ]

    //adds income to balance
    func addSHIncome() {

        if direct_deposit_on {
            life_bank_balance += sh_youtube_income
            life_bank_balance += sh_apps_income
            life_bank_balance += sh_music_income
            life_bank_balance += sh_babysitter_income
            life_bank_balance += sh_selling_income
            life_bank_balance += sh_artist_income
        } else {
            life_cash_balance += sh_youtube_income
            life_cash_balance += sh_apps_income
            life_cash_balance += sh_music_income
            life_cash_balance += sh_babysitter_income
            life_cash_balance += sh_selling_income
            life_cash_balance += sh_artist_income
        }

        //shInfo[sh]![.base]!
    }

    func getNetWorth() -> Int {
        
        //TODO: CATCH EXCEDING MAX INT ERROR
        return life_cash_balance + life_bank_balance
    }
    
    

    private func eat() -> Void {
        if vegan_meals > 0 {
            vegan_meals -= 1
            life_energy_status += Meal.veganMeal.energyMod!
            life_health_status += Meal.veganMeal.healthMod!
        }else if vegetarian_meals > 0 {
            vegetarian_meals -= 1
            life_energy_status += Meal.vegetarianMeal.energyMod!
            life_health_status += Meal.vegetarianMeal.healthMod!
        } else if average_meals > 0 {
            average_meals -= 1
            life_energy_status += Meal.averageMeal.energyMod!
            life_health_status += Meal.averageMeal.healthMod!
        } else if america_meals > 0 {
            america_meals -= 1
            life_energy_status += Meal.americaMeal.energyMod!
            life_health_status += Meal.americaMeal.healthMod!
        } else if fastfood_meals > 0 {
            fastfood_meals -= 1
            life_energy_status += Meal.fastfoodMeal.energyMod!
            life_health_status += Meal.fastfoodMeal.healthMod!
        } else if poop_meals > 0 {
            poop_meals -= 1
            life_energy_status += Meal.poopMeal.energyMod!
            life_health_status += Meal.poopMeal.healthMod!
        }
    }

    
    

    enum Genders: CaseIterable {
        case male, female
    }

    enum Partners {
        case all, partner1, partner2, partner3, partner4
    }
    
    enum Resettable {
        case health
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
        resetAge()
        resetPets()
        resetFriend(friend: .friend1)
        resetFriend(friend: .friend2)
        resetFriend(friend: .friend3)
        resetFriend(friend: .friend4)
    }

    func resetMeals() {
        vegan_meals = 0
        vegetarian_meals = 0
        average_meals = 0
        america_meals = 0
        fastfood_meals = 0
        poop_meals = 0
    }
    func resetAge() {
        months_old = 0
        age_stage = .baby
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
        name = (gender == "male" ? maleNames.randomElement()! : femaleNames.randomElement()!)
        emoji = babyEmojis.randomElement()!
    }
    func limitStatus() {
        
        if friend1_status < 0          { partner1_status = 0         }
        if friend1_status > 100        { friend1_status = 100        }
        if friend2_status < 0          { partner2_status = 0         }
        if friend2_status > 100        { friend2_status = 100        }
        if friend3_status < 0          { partner3_status = 0         }
        if friend3_status > 100        { friend3_status = 100        }
        if friend4_status < 0          { partner4_status = 0         }
        if friend4_status > 100        { friend4_status = 100        }
        
        if partner4_status < 0         { partner4_status = 0         }
        if partner4_status > 100       { partner4_status = 100       }
        if partner3_status < 0         { partner3_status = 0         }
        if partner3_status > 100       { partner3_status = 100       }
        if partner2_status < 0         { partner2_status = 0         }
        if partner2_status > 100       { partner2_status = 100       }
        if partner1_status < 0         { partner1_status = 0         }
        if partner1_status > 100       { partner1_status = 100       }
        
        if life_health_status < 0      { on_new_life = true          }
        if life_health_status > 100    { life_health_status = 100    }
        if life_happiness_status < 0   { on_new_life = true          }
        if life_happiness_status > 100 { life_happiness_status = 100 }
        if life_energy_status < 0      { on_new_life = true          }
        if life_energy_status > 100    { life_energy_status = 100    }
        
        if mom_status > 100            { mom_status = 100            }
        if dad_status > 100            { dad_status = 100            }
        if mom_status < 0              { mom_status = 0              }
        if dad_status < 0              { dad_status = 0              }

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
        loan_debt = 0
        
        life_job_title = nil
        life_job_salary = nil
        total_lottery_winnings = 0

        sh_youtube=0.0;sh_youtube_progress=0.0;sh_youtube_count=0;sh_youtube_income=0;sh_youtube_time=0
        sh_music=0.0;sh_music_progress=0.0;sh_music_count=0;sh_music_income=0;sh_music_time=0
        sh_apps=0.0;sh_apps_progress=0.0;sh_apps_count=0;sh_apps_income=0;sh_apps_time=0
        sh_babysitter=0.0;sh_babysitter_progress=0.0;sh_babysitter_count=0;sh_babysitter_income=0;sh_babysitter_time=0
        sh_selling=0.0;sh_selling_progress=0.0;sh_selling_count=0;sh_selling_income=0;sh_selling_time=0
        sh_artist=0.0;sh_artist_progress=0.0;sh_artist_count=0;sh_artist_income=0;sh_artist_time=0
        begun_sh = false
        direct_deposit_on = false
        
        stock_points = ""
        for _ in 0...9 {
            stock_points += String(Int.random(in: 0...100))
            stock_points += " "
        }
    }
    func resetPets() {
        pet_ids = ""
        pet_types = ""
        pet_names = ""
        pet_status = ""
        allPets.removeAll()
    }
    func resetAssets() -> Void {
        vegan_meals = 0
        vegetarian_meals = 0
        average_meals = 0
        america_meals = 0
        fastfood_meals = 0
        poop_meals = 0
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
    public func resetFriend(friend: FriendsView.Friends) -> Void {
        switch friend {
            case .friend1:
                friend1_name = ""
                friend1_emoji = ""
                friend1_status = 0
                friend1_age = 0
            case .friend2:
                friend2_name = ""
                friend2_emoji = ""
                friend2_status = 0
                friend2_age = 0
            case .friend3:
                friend3_name = ""
                friend3_emoji = ""
                friend3_status = 0
                friend3_age = 0
            case .friend4:
                friend4_name = ""
                friend4_emoji = ""
                friend4_status = 0
                friend4_age = 0
        }
    }
}
