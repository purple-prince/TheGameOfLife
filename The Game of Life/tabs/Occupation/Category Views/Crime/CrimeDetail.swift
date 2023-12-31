//
//  CrimeDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 4/5/22.
//

import SwiftUI

struct CrimeDetail: View {
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
    
    @Binding var showCrimeDetail: Bool
    @Binding var showCrimeView: Bool
    
    @State var mode: CrimeView.CrimeModes
    @State var showCrimeOutcome: Bool = true//false
    @State var crimeOutcome: Bool? = true//nil
    @State var crimeIndexTapped: Int = 0
    
    var body: some View {
        
        ZStack {
            
            Color("mainWhite").ignoresSafeArea()
            
            Main
                .disabled(showCrimeOutcome)
                .blur(radius: showCrimeOutcome ? 5 : 0)
            
            if showCrimeOutcome {
                CrimeOutcomeView(showCrimeOutcome: $showCrimeOutcome, mode: mode, indexTapped: crimeIndexTapped)
                //crimeOutcome: crimeOutcome!,
            }
            
            BackButton
                .disabled(showCrimeOutcome)
                .blur(radius: showCrimeOutcome ? 5 : 0)
        }
    }
}

struct CrimeOutcomeView: View {
    
    @Binding var showCrimeOutcome: Bool
    @State var crimeOutcome: Bool = true//nothing
    @State var mode: CrimeView.CrimeModes
    let indexTapped: Int
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    var body: some View {
        ZStack {
            
            Bg
            
            VStack {
                title
                
                Main
                
                Spacer()
            }
                
            BackButton
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
    
    var Main: some View {
        ZStack {
            if crimeOutcome {
                VStack(alignment: .leading) {
                    
                    switch mode {
                        case .violence:
                            Text(CrimeActionClass.ViolenceCrimes[indexTapped].descriptions.randomElement()!)
                        case .drugs:
                            Text(CrimeActionClass.DrugsCrimes[indexTapped].descriptions.randomElement()!)
                        case .theft:
                            Text(CrimeActionClass.TheftCrimes[indexTapped].descriptions.randomElement()!)
                        case .hacking:
                            Text(CrimeActionClass.HackingCrimes[indexTapped].descriptions.randomElement()!)
                    }
                    
                    HStack(spacing: 0) {
                        
                        Text("Earned: ")
                            .foregroundColor(Color("mainDarkGray"))
                        
                        Text("+ $23.4k")
                            .foregroundColor(.green)
                    }
                    
                    HStack(spacing: 0) {
                        Text("Exp: ")
                            .foregroundColor(Color("mainDarkGray"))
                        Text("+ 12")
                            .foregroundColor(.green)
                    }
                }.font(.title2)
            } else {
                VStack {
                    
                }
            }
        }
    }
    
    var title: some View {
        if crimeOutcome {
            return Title("Success!")
        } else {
            return Title("You got caught!")
        }
    }
    
    var BackButton: some View {
        VStack {
            HStack {
                Spacer()
                
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                    .font(Font.system(size: 32))
                    .onTapGesture {
                        showCrimeOutcome = false
                    }
            }
            Spacer()
        }
        .padding()
    }
    
    var Bg: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(Color("mainWhite"))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(userPreferences.appColor, lineWidth: 3)
            )
    }
}

extension CrimeDetail {
    
    var BackButton: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.red)
                    .font(Font.system(size: 40))
                    .onTapGesture {
                        showCrimeView = true
                        showCrimeDetail = false
                    }
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    var crimeList: [CrimeActionClass.CrimeAction] {
        switch mode {
            case .hacking:
                return CrimeActionClass.HackingCrimes
            case .drugs:
                return CrimeActionClass.DrugsCrimes
            case .theft:
                return CrimeActionClass.TheftCrimes
            case .violence:
                return CrimeActionClass.ViolenceCrimes
        }
    }
    
    func buttonLabel(num: Int) -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color("mainDarkGray"))
            Text(crimeList[num].title)
                .font(.title2)
                .foregroundColor(.white)
        }
        .aspectRatio(10/10, contentMode: .fit)
    }
    
    var Main: some View {
        VStack {
            Title(mode == .violence ? "Violence" : mode == .drugs ? "Drugs" : mode == .theft ? "Theft" : "Hacking")
                        
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Button(action: {
                        crimeOutcome = player.commit(crime: crimeList[0])
                        showCrimeOutcome = true
                        player.increaseCrimeExp(crime: crimeList[0])
                        crimeIndexTapped = 0
                    }, label: { buttonLabel(num: 0) })
                    .padding(.leading)
                    
                    Button(action: {
                        crimeOutcome = player.commit(crime: crimeList[1])
                        showCrimeOutcome = true
                        player.increaseCrimeExp(crime: crimeList[1])
                        crimeIndexTapped = 1
                    }, label: { buttonLabel(num: 1) })
                    .padding(.trailing)
                }
                
                HStack(spacing: 16) {
                    Button(action: {
                        crimeOutcome = player.commit(crime: crimeList[2])
                        showCrimeOutcome = true
                        player.increaseCrimeExp(crime: crimeList[2])
                        crimeIndexTapped = 2
                    }, label: { buttonLabel(num: 2) })
                    .padding(.leading)
                    
                    Button(action: {
                        crimeOutcome = player.commit(crime: crimeList[3])
                        showCrimeOutcome = true
                        player.increaseCrimeExp(crime: crimeList[3])
                        crimeIndexTapped = 3
                    }, label: { buttonLabel(num: 3) })
                    .padding(.trailing)
                }
            }
            
            Spacer()
        }
    }
}

class CrimeActionClass {
    
    init(player: Player) {
        self.player = player
    }
    let player: Player
    
    static let ViolenceCrimes: [CrimeAction] = [ViolenceCrime1, ViolenceCrime2, ViolenceCrime3, ViolenceCrime4]
    static let TheftCrimes: [CrimeAction] = [TheftCrime1, TheftCrime2, TheftCrime3, TheftCrime4]
    static let DrugsCrimes: [CrimeAction] = [DrugsCrime1, DrugsCrime2, DrugsCrime3, DrugsCrime4]
    static let HackingCrimes: [CrimeAction] = [HackingCrime1, HackingCrime2, HackingCrime3, HackingCrime4]
    
    static var ViolenceCrime1: CrimeAction {CrimeAction(title: "Intimidate", xp: 1, mode: .violence, caughtMonths: 3, difficulty: 1)}
    static var ViolenceCrime2: CrimeAction {CrimeAction(title: "Mug", xp: 3, mode: .violence, caughtMonths: 6, difficulty: 2)}
    static var ViolenceCrime3: CrimeAction {CrimeAction(title: "Assault", xp: 7, mode: .violence, caughtMonths: 12, difficulty: 3)}
    static var ViolenceCrime4: CrimeAction {CrimeAction(title: "Murder", xp: 12, mode: .violence, caughtMonths: 24, difficulty: 4)}
    
    static var TheftCrime1: CrimeAction {CrimeAction(title: "Pickpocket", xp: 1, mode: .theft, caughtMonths: 3, difficulty: 1)}
    static var TheftCrime2: CrimeAction  {CrimeAction(title: "Shoplift", xp: 3, mode: .theft, caughtMonths: 6, difficulty: 2)}
    static var TheftCrime3: CrimeAction  {CrimeAction(title: "Burgulary", xp: 7, mode: .theft, caughtMonths: 12, difficulty: 3)}
    static var TheftCrime4: CrimeAction  {CrimeAction(title: "Heist", xp: 12, mode: .theft, caughtMonths: 24, difficulty: 4)}
    
    static var DrugsCrime1: CrimeAction { CrimeAction(title: "Weed", xp: 1, mode: .drugs, caughtMonths: 3, difficulty: 1)}
    static var DrugsCrime2: CrimeAction { CrimeAction(title: "Psychedelics", xp: 3, mode: .drugs, caughtMonths: 6, difficulty: 2)}
    static var DrugsCrime3: CrimeAction { CrimeAction(title: "Pills", xp: 7, mode: .drugs, caughtMonths: 12, difficulty: 3)}
    static var DrugsCrime4: CrimeAction { CrimeAction(title: "Hardcore Drugs", xp: 12, mode: .drugs, caughtMonths: 24, difficulty: 4)}
    
    static var HackingCrime1: CrimeAction { CrimeAction(title: "Fraud", xp: 1, mode: .hacking, caughtMonths: 3, difficulty: 1)}
    static var HackingCrime2: CrimeAction { CrimeAction(title: "Phishing", xp: 3, mode: .hacking, caughtMonths: 6, difficulty: 2) }
    static var HackingCrime3: CrimeAction { CrimeAction(title: "Hack Business", xp: 7, mode: .hacking, caughtMonths: 12, difficulty: 3) }
    static var HackingCrime4: CrimeAction {CrimeAction(title: "Hack Government", xp: 12, mode: .hacking, caughtMonths: 24, difficulty: 4)}
    
    class CrimeAction {
        
        init(title: String, xp: Int, mode: CrimeView.CrimeModes, caughtMonths: Int, difficulty: Double) {
            self.xp = xp
            self.mode = mode
            self.caughtMonths = caughtMonths
            self.difficulty = difficulty
            self.title = title
        }
        
        let title: String
        let xp: Int
        let mode: CrimeView.CrimeModes
        let caughtMonths: Int
        let difficulty: Double
        
        var descriptions: [String] {
            switch mode {
                case .hacking:
                    switch title {
                        case "Fraud": return  [
                            "You used an old lady's credit card to buy fireworks",
                            "You stole someone's identity and used it to sell their house",
                            "You pretended to be someone else to access their subscriptions",
                            "You used a stolen credit card to buy a giraffe",
                            "You cashed out on a single parent's entire bank account"
                        ]
                        case "Phishing": return  [
                            "You phished an old man into giving you his bank details",
                            "You phished a kid into buying fake v-bucks"
                        ]
                        case "Hack Business": return  [
                            "You hacked Bamazon and stole all of their money",
                            "You hacked Bacebook and sold all of their user's information",
                            "You hacked all of Bapple's computers and helf them for ransom",
                            "You hacked Boogle and stole all of their sales money"
                        ]
                        case "Hack Government": return  [
                            "You hacked the IRS and stole all of their tax revenue",
                            "You hacked the Federal Reserve and stole, like, everything",
                            "You hacked the FBI and stole all of their confiscated Bitcoin",
                            "You hacked the whole government... whatever that means",
                            ""
                        ]
                        default: return  ["ERROR: CrimeDetail.swift ln. 303"]
                    }
                case .drugs:
                    switch title {
                        case "Weed": return  [
                            "You sold weed to some shrimpy teenagers",
                            "You sold zaza to your parents",
                            "You sold weed to a wandering monkey"
                        ]
                        case "Psychedelics": return  [
                            "You sold some LSD to a group of hippies",
                            "You sold shrooms to an infant",
                            "You sold DMT to an old lady"
                        ]
                        case "Pills": return  [
                            "You sold MDMA to a homeless man",
                            "You sold Xannax to a depressed college kid",
                            "You sold adderall to a fish",
                            "You sold laced pills to a grandma"
                        ]
                        case "Hardcore Drugs": return  [
                            "You sold heroine to a priest",
                            "You sold crack to a toddler at the playground",
                            "You sold meth to the entire staff at the hospital",
                            "You sold the lethal injection to a rooster",
                            ""
                        ]
                        default: return  ["ERROR: CrimeDetail.swift ln. 303"]
                    }
                case .violence:
                    switch title {
                        case "Intimidate": return  [
                            "You threatened to beat up a blind old man",
                            "You intimidated a disabled person",
                            "You scared a kid and he peed his pants",
                            "You scares a kid until he pooped his pants"
                        ]
                        case "Mug": return  [
                            "You mugged a random person for their phone, watch, and wallet",
                            "You mugged a person for everything they had...including their clothes",
                            "You mugged a celebrity for their shoes, watch, and an autograph",
                            "You mugged an athsma patient for their inhaler"
                        ]
                        case "Assault": return  [
                            "You assaulted everyone in the cancer ward at the hospital",
                            "You pepper sprayed a nursing home",
                            "You castrated a grocery store cashier",
                            "You cut off someone's toes and sold them on the dark web",
                            "You threw acid on your friend's dog"
                        ]
                        case "Murder": return  [
                            "You asassinated the vice president",
                            "You suffacated someone with your underwear",
                            "You poured bleach down a turtle's throat",
                            "You fed an old woman her own intestines",
                            "You played Justin Bieber for someone until they killed themselves"
                        ]
                        default: return  ["ERROR: CrimeDetail.swift ln. 303"]
                    }
                case .theft:
                    switch title {
                        case "Pickpocket": return  [
                            "You swiped someones phone from their back pocket",
                            "You grabbed the zookeeper's keys",
                            "You stole all the ones from a stripper's pocket"
                        ]
                        case "Shoplift": return  [
                            "You stole the slurpee machine from Seven Beleven",
                            "You robbed all of the peanut butter from Balmart",
                            "You stole all of of the Buuls from the smoke shop",
                            "You stole a refrigerator from the appliance store",
                            "The person who made this game was too lazy to write a description here"
                        ]
                        case "Burgulary": return  [
                            "You robbed the White House",
                            "You stole everything from the homeless shelter",
                            "You went to heaven, stole a bunch of stuff, then came back to earth",
                            "You broke into someone's house and stole all of their light bulbs",
                            "You broke into a mom's house and stole all of the kids"
                        ]
                        case "Heist": return  [
                            "You robbed a bank with finger guns",
                            "You robbed a luxury car dealership and took every car",
                            "You robbed the Bank of Spain (Shoutout \"Money Heist\" on Netflix. They dont sponsor me it's just a good show)",
                            "You robbed Fort Knox and sold all of the gold",
                            "You robbed a sperm bank and got into a sticky situation"
                        ]
                        default: return  ["ERROR: CrimeDetail.swift ln. 303"]
                    }
            }
        }
    }
    
    
    //violence: threaten, mug, assault, murder
    //theft: pickpocket, shoplift, rob house, rob bank
    //drugs: weed, psychedelics, pills, heroin/crack
    //hacking: carding, phishing, hack business, hack government
}

struct CrimeDetail_Previews: PreviewProvider {
    static var previews: some View {
        CrimeDetail(showCrimeDetail: .constant(true), showCrimeView: .constant(false), mode: .theft)
            .environmentObject(Player())
            .environmentObject(UserPreferences())
    }
}
