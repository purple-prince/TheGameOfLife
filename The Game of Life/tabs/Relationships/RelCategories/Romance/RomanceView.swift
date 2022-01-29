//
//  RomanceView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/22/22.
//


//flirt, ask them out, propose, marry, have kids, divorce,
//spend time, trip, gift, sex, date, vacation, hurt
//breakup, cheat

import SwiftUI

struct RomanceView: View {
    @State var showRomanceDetail: Bool = false
    @State var showRomanceMain: Bool = true
    @State var showFindPartner: Bool = false
    
    
    @Binding var showMainView: Bool
    @Binding var showRomanceView: Bool
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
    
    @State var clickedPartner: Partners?

    var body: some View {
                
        ZStack {
            
            Color("mainWhite").ignoresSafeArea()
            
            if showRomanceMain {
                ZStack {
                    VStack {
                        
                        BackButton
                        
                        banner
                        
                        Divider()
                        
                        if player.partner1_name == "" && player.partner2_name == "" && player.partner3_name == "" && player.partner4_name == "" {
                            findPartnerView
                        }
                        
                        VStack {
                            if player.partner1_name != "" {
                                PartnerLink(partner: .partner1)
                            }
                            if player.partner2_name != "" {
                                PartnerLink(partner: .partner2)
                            }
                            if player.partner3_name != "" {
                                PartnerLink(partner: .partner3)
                            }
                            if player.partner4_name != "" {
                                PartnerLink(partner: .partner4)
                            }
                        }
                        Spacer()
                    }
                    .blur(radius: showFindPartner ? 10 : 0)
                    
                    if showFindPartner {
                        if player.partner1_name == "" {
                            FindPartnerPopup(showFindPartner: $showFindPartner, numPartners: 0)
                        } else if player.partner2_name == "" {
                            FindPartnerPopup(showFindPartner: $showFindPartner, numPartners: 1)
                        } else if player.partner3_name == "" {
                            FindPartnerPopup(showFindPartner: $showFindPartner, numPartners: 2)
                        } else if player.partner4_name == "" {
                            FindPartnerPopup(showFindPartner: $showFindPartner, numPartners: 3)
                        }
                    }
                    
                }
            }
            
            if showRomanceDetail {
                RomanceDetail(showRomanceDetail: $showRomanceDetail, showRomanceMain: $showRomanceMain, partner: clickedPartner!)
            }
        }
    }
}

extension RomanceView {
    
    var findPartnerView: some View {
        VStack {
            Text("No partners 🤡🤣 loser")
                .foregroundColor(.pink)
                .font(.largeTitle)
                .fontWeight(.medium)
            
            Button(action: {
                showFindPartner = true
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 26)
                        .fill(Color.pink)
                        .brightness(0.1)
                    Text("Find a partner")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.title)
                }
            })
                .padding(.horizontal)
                .padding(.horizontal)
                .frame(height: 120)
        }
    }
    
    var banner: some View {
        VStack /*current job*/ {
            Spacer()
            
            Text("Romance")
                .bold()
                .font(.largeTitle)
            Spacer()
            Text("-0.5/month")
                .font(.title3)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(Color("mainDarkGray"))
        .foregroundColor(.white)
        .cornerRadius(12)
        .shadow(radius: 12)
        .padding()
    }
    
    var BackButton: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(Font.system(size: 32))
                .foregroundColor(.red)
                .padding(.horizontal)
                .onTapGesture {
                    showMainView = true
                    showRomanceView = false
                }
            Spacer()
        }
    }
    
    public enum Partners {
        case partner1, partner2, partner3, partner4
    }
    
    func partnerInfo(partner: Partners) -> [String : String] {
        switch partner {
            case .partner1:
                return [
                    "name" : player.partner1_name,
                    "emoji" : player.partner1_emoji,
                    "age" : String(player.partner1_age),
                    "status" : String(player.partner1_status)
                ]
            case .partner2:
                return [
                    "name" : player.partner2_name,
                    "emoji" : player.partner2_emoji,
                    "age" : String(player.partner2_age),
                    "status" : String(player.partner2_status)
                ]
            case .partner3:
                return [
                    "name" : player.partner3_name,
                    "emoji" : player.partner3_emoji,
                    "age" : String(player.partner3_age),
                    "status" : String(player.partner3_status)
                ]
            case .partner4:
                return [
                    "name" : player.partner4_name,
                    "emoji" : player.partner4_emoji,
                    "age" : String(player.partner4_age),
                    "status" : String(player.partner4_status)
                ]
        }
    }
        
    func PartnerLink(partner: Partners) -> some View {
        VStack {
            HStack {
                Text(partnerInfo(partner: partner)["emoji"]! + " " + partnerInfo(partner: partner)["name"]!)
                    .lineLimit(1)
                    .layoutPriority(1)
                Color("mainWhite")
                    .frame(width: .infinity, height: 1)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 100, height: 12)
                        .foregroundColor(Color.gray)

                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: CGFloat(Int(partnerInfo(partner: partner)["status"]!)!), height: 12)
                        .foregroundColor(userPreferences.appColor)
                }
            }
            .padding()
            .font(.system(size: 20))
            .foregroundColor(.black)
            .onTapGesture {
                clickedPartner = partner
                showRomanceDetail = true
                showRomanceMain = false
            }
            
            Capsule()
                .fill(Color("mainDarkGray"))
                .frame(width: .infinity, height: 1)
                .padding(.horizontal, 8)
                //.padding(.horizontal)
        }
    }
}

struct FindPartnerPopup: View {
    
    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var player: Player
    
    @Binding var showFindPartner: Bool
    var numPartners: Int
    
    func getPartnerChoices() -> [Partner]/*[Int : [String : String]]*/ {
        return [Partner(player: player), Partner(player: player), Partner(player: player)]
    }
    
    let quotes: [String] = ["Sexy and I know it",
                            "Nothing is more beautiful than love",
                            "corn",
                            "Ranked #8 globally in clash. Check out my yt",
                            "I'm next up 😈💯💪 Peep my soundcloud",
                            "boi 😂 #TPOSE #BANDKIDZRULE #FORTNITE",
                            "Why can't we just print more money?"]
    
    var body: some View {
        ZStack {
            
            Background
            
            Main
            
            BackButton
            
        }
        .frame(width: .infinity, height: .infinity)
        .padding()
    }
    
    var BackButton: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                    .font(Font.system(size: 42))
                    .padding()
                    .onTapGesture {
                        showFindPartner = false
                    }
            }
            
            Spacer()
        }
        .frame(width: .infinity, height: 550)
    }
    
    var Main: some View {
        VStack {
            
            ForEach(getPartnerChoices()) { partner in
                VStack {
                    HStack {
                        Text(partner.emoji)
                            .font(Font.system(size: 90))
                            
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 0) {
                                Text(partner.name.split(separator: " ")[0])
                                    .fontWeight(.medium)
                                    .font(.title)
                                Text(",  \(String(partner.age))")
                                    .fontWeight(.thin)
                                    .font(.title)
                            }
                            
                            Text("\"\(quotes.randomElement()!)\"")
                                .italic()
                                .fontWeight(.thin)
                        }
                        
                        Spacer()
                    }
                    .onTapGesture {
                        if numPartners == 0 {
                            player.partner1_name   = partner.name
                            player.partner1_age    = partner.age
                            player.partner1_emoji  = partner.emoji
                            player.partner1_status = 100
                        } else if numPartners == 1 {
                            player.partner2_name   = partner.name
                            player.partner2_age    = partner.age
                            player.partner2_emoji  = partner.emoji
                            player.partner2_status = 100
                        } else if numPartners == 2 {
                            player.partner3_name   = partner.name
                            player.partner3_age    = partner.age
                            player.partner3_emoji  = partner.emoji
                            player.partner3_status = 100
                        } else {
                            player.partner4_name   = partner.name
                            player.partner4_age    = partner.age
                            player.partner4_emoji  = partner.emoji
                            player.partner4_status = 100
                        }
                        
                        showFindPartner = false
                    }
                    .padding()
                }
            }
            
//                HStack {
////                    Text(getPartnerChoices()[1]!["emoji"]!)
////                    Text(getPartnerChoices()[1]!["name"]!)
////                    Text(getPartnerChoices()[1]!["age"]!)
//                    Text(getPartnerChoices()[0])
//                }
//
//                HStack {
////                    Text(getPartnerChoices()[2]!["emoji"]!)
////                    Text(getPartnerChoices()[2]!["name"]!)
//                }
//
//                HStack {
////                    Text(getPartnerChoices()[3]!["emoji"]!)
////                    Text(getPartnerChoices()[3]!["name"]!)
//                }
            
            
        }
        .foregroundColor(.white)
    }
    
    var Background: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(Color("mainDarkGray"))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(userPreferences.appColor, lineWidth: 4)
        )
        .shadow(color: .black, radius: 16)
        .frame(width: .infinity, height: 550)
    }
    
    
}

struct RomanceView_Previews: PreviewProvider {
    static var previews: some View {
        RomanceView(showMainView: .constant(false), showRomanceView: .constant(true))
            .environmentObject(UserPreferences())
            .environmentObject(Player())
//        FindPartnerPopup(showFindPartner: .constant(true))
//            .environmentObject(UserPreferences())
//            .environmentObject(Player())
    }
}

struct Partner: Identifiable {
    
    enum Gender: CaseIterable {
        case male, female
    }
    
    let id: UUID = UUID()
    
    var player: Player
    
    let gender: Gender = Gender.allCases.randomElement()!
    var name: String { gender == .female ? femaleNames.randomElement()! : maleNames.randomElement()! }
    var emoji: String { gender == .female ? (player.age_stage == .kid ? girlEmojis.randomElement()! : player.age_stage == .adult ? momEmojis.randomElement()! : grandmaEmojis.randomElement()!) : (player.age_stage == .kid ? boyEmojis.randomElement()! : player.age_stage == .adult ? dadEmojis.randomElement()! : grandpaEmojis.randomElement()!) }
    var age: Int {
        Int.random(in: (player.yearsOld - 5)...(player.yearsOld + 5))
    }
}
