//
//  FriendsDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/22/22.
//

import SwiftUI

struct FriendsDetailButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .brightness(configuration.isPressed ? 0.05 : 0)
    }
}

struct FriendsDetail: View {
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
    
    @Binding var showFriendsDetail: Bool
    @Binding var showFriendsView: Bool
    
    @State var showFindFriends: Bool = false
    @State var showAskOutPopup: Bool = true//false
    
    var friend: FriendsView.Friends
    var numFriends: Int {
        if player.friend1_name == "" {
            return 0
        } else if player.friend2_name == "" {
            return 1
        } else if player.friend3_name == "" {
            return 2
        } else {
            return 3
        }
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                BackButton

                Banner

                Divider()

                VStack(spacing: 12) {
                    HStack(spacing: 12) {

                        ActionButton(friendStatusEffect: 10, healthMod: 0, hapMod: 10, energyMod: -2, cost: 0, description: "Visit park")

                        ActionButton(friendStatusEffect: 20, healthMod: 0, hapMod: 20, energyMod: 0, cost: 50, description: "Get dinner")

                    }

                    HStack(spacing: 12) {

                        ActionButton(friendStatusEffect: 35, healthMod: 0, hapMod: 5, energyMod: 0, cost: 150, description: "Give gift")

                        ActionButton(friendStatusEffect: 0, healthMod: 0, hapMod: 0, energyMod: 0, cost: 0, description: "Random...")

                    }

                    HStack(spacing: 12) {

                        ActionButton(friendStatusEffect: 0, healthMod: 0, hapMod: 0, energyMod: 0, cost: 0, description: "Ask Out")

                        ActionButton(friendStatusEffect: -80, healthMod: 0, hapMod: -70, energyMod: 0, cost: 0, description: "Break Up")

                    }

                }
                .padding(12)

                Spacer()
            }.blur(radius: showFindFriends || showAskOutPopup ? 50 : 0)

            if showFindFriends {
                FindFriendsPopup(showFindFriends: $showFindFriends, numFriends: numFriends)
            }
            
            if showAskOutPopup {
                AskOutView()
            }
            
        }
    }
}

extension FriendsDetail {
    
    var numPartners: Int {
        if player.partner1_name == "" {
            return 0
        } else if player.partner2_name == "" {
            return 1
        } else if player.partner3_name == "" {
            return 2
        } else if player.partner4_name == "" {
            return 3
        } else {
            return 4
        }
    }
    //test change
    func AskOutView() -> some View {
        
        if false {
            print("")
        }
        
        @State var accepted: Bool?
        
        var posRejectionMessages = [
            "Ew.",
            "Haha no! You're like a sibling to me",
            "I'm already seeing someone, sorry",
            "I'm gay, sorry",
            "You wish",
            "You look so absolutely stupid right now. You really thought YOU could date ME? You're 5"
        ]
        var firstName = String(friendInfo()["name"]!.split(separator: " ")[1])
        
        return ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(Color("mainDarkGray"))
            
            if accepted == nil {
                VStack {
                    Text("Ask \(firstName) out?")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            showAskOutPopup = false
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .aspectRatio(3/2, contentMode: .fit)
                                    //.foregroundColor(.red)
                                    .foregroundColor(Color(red: 180/255, green: 0.0, blue: 0.0))
                                Text("No")
                                    .font(Font.system(size: 26))
                                    .foregroundColor(.white)
                            }
                        })
                            .padding()
                        
                        
                        
                        Button(action: {
                            
                            accepted = Bool.random()
                            
                            if accepted! {
                                switch numPartners {
                                    case 0:
                                        player.partner1_emoji = friendInfo()["emoji"]!
                                        player.partner1_age = Int(friendInfo()["emoji"]!)!
                                        player.partner1_status = Int(friendInfo()["status"]!)!
                                        player.partner1_name = friendInfo()["name"]!
                                    case 1:
                                        player.partner2_emoji = friendInfo()["emoji"]!
                                        player.partner2_age = Int(friendInfo()["emoji"]!)!
                                        player.partner2_status = Int(friendInfo()["status"]!)!
                                        player.partner2_name = friendInfo()["name"]!
                                    case 2:
                                        player.partner3_emoji = friendInfo()["emoji"]!
                                        player.partner3_age = Int(friendInfo()["emoji"]!)!
                                        player.partner3_status = Int(friendInfo()["status"]!)!
                                        player.partner3_name = friendInfo()["name"]!
                                    default:
                                        player.partner4_emoji = friendInfo()["emoji"]!
                                        player.partner4_age = Int(friendInfo()["emoji"]!)!
                                        player.partner4_status = Int(friendInfo()["status"]!)!
                                        player.partner4_name = friendInfo()["name"]!
                                }
                                
                                player.resetFriend(friend: friend)
                                
                            } else {
                                HapticManager.instance.playHaptic(type: .error)
                            }
                            
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .aspectRatio(3/2, contentMode: .fit)
                                    .foregroundColor(Color(red: 0.0, green: 160/255, blue: 0.0))
                                Text("Say less 😍")
                                    .font(Font.system(size: 26))
                                    .foregroundColor(.white)
                            }
                        })
                            .padding()
                    }
                }
            } else if accepted! {
                Text("\(firstName) said yes!")
            } else {
                Text("\(firstName) said: \n \(posRejectionMessages.randomElement()!)")
            }

            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .font(Font.system(size: 32))
                        .padding()
                        .onTapGesture {
                            showAskOutPopup = false
                        }
                }
                Spacer()
            }
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(userPreferences.appColor, lineWidth: 2)
        )
        .shadow(color: .black, radius: 16)
        .aspectRatio(3/2, contentMode: .fit)
        .padding()
    }

    func friendInfo() -> [String : String] {
        switch friend {
            case .friend1:
                return [
                    "name" : player.friend1_name,
                    "emoji" : player.friend1_emoji,
                    "age" : String(player.friend1_age),
                    "status" : String(player.friend1_status)
                ]
            case .friend2:
                return [
                    "name" : player.friend2_name,
                    "emoji" : player.friend2_emoji,
                    "age" : String(player.friend2_age),
                    "status" : String(player.friend2_status)
                ]
            case .friend3:
                return [
                    "name" : player.friend3_name,
                    "emoji" : player.friend3_emoji,
                    "age" : String(player.friend3_age),
                    "status" : String(player.friend3_status)
                ]
            case .friend4:
                return [
                    "name" : player.friend4_name,
                    "emoji" : player.friend4_emoji,
                    "age" : String(player.friend4_age),
                    "status" : String(player.friend4_status)
                ]
        }
    }

    func StatusBar() -> some View {
        ZStack(alignment: .leading){

            //background bar
            RoundedRectangle(cornerRadius: 8)
                .stroke(userPreferences.appColor, lineWidth: 1)
                .frame(width: 100, height: 16)


            //foreground bar
            RoundedRectangle(cornerRadius: 8)
                .frame(width: CGFloat(Int(friendInfo()["status"]!)!), height: 16)
                .foregroundColor(userPreferences.appColor)
        }
        .offset(y: -16)
    }

    func ActionButton(friendStatusEffect: Int, healthMod: Int, hapMod: Int, energyMod: Int, cost: Int, description: String) -> some View {

        enum ModTypes {
            case health, happiness, energy, cost
        }

        var numAffected: Int = 0

        if healthMod != 0 {
            numAffected += 1
        }
        if hapMod != 0 {
            numAffected += 1
        }
        if energyMod != 0 {
            numAffected += 1
        }
        if cost != 0 {
            numAffected += 1
        }

        func ModLabel(mod: ModTypes) -> some View {

            var parameter: Int
            switch mod {
                case .health:
                    parameter = healthMod
                case .happiness:
                    parameter = hapMod
                case .energy:
                    parameter = energyMod
                case .cost:
                    parameter = cost
            }

            return HStack {

                if mod == .health || mod == .happiness || mod == .energy {
                    HStack(spacing: 4) {
                        Text(parameter > 0 ? "+ \(parameter)" : "- \(abs(parameter))")
                            .foregroundColor(parameter > 0 ? .green : .red)
                        if mod == .health {Text("❤️")} else if mod == .happiness {Text("😀")} else if mod == .energy {Text("⚡️")}
                    }
                } else {
                    Text("- \(formatNum(cost))").foregroundColor(.red)
                }

            }
        }

        @State var clickable: Bool = player.life_cash_balance >= cost

        var returnView: some View {
            Button(action: {

                if clickable {

                    if description != "Break Up" && description != "Ask Out" {

                        HapticManager.instance.playHaptic(type: .light)

                        switch friend {
                            case .friend1:
                                player.friend1_status += friendStatusEffect
                            case .friend2:
                                player.friend2_status += friendStatusEffect
                            case .friend3:
                                player.friend3_status += friendStatusEffect
                            case .friend4:
                                player.friend4_status += friendStatusEffect
                        }
                        player.life_health_status += healthMod
                        player.life_happiness_status += hapMod
                        player.life_energy_status += energyMod
                        player.life_cash_balance -= cost
                    } else if description == "Ask Out" {
                        showAskOutPopup = true
                    } else {
                        showFindFriends = true
                    }
                }

            }, label: {

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("mainDarkGray"))
                        .aspectRatio(5/4, contentMode: .fit)
                        .shadow(color: Color.black, radius: 4)
                        .frame(maxHeight: 142)

                    VStack(spacing: 0) {
                        Text(description)
                            .fontWeight(.light)
                            .font(Font.system(size: 26))
                            .padding(.top)

                        Spacer()

                        if description == "Random..." {
                            Text("❔❔❔")
                                .font(.title)
                            Spacer()
                        } else {

                            Spacer()

                            VStack {

                                switch numAffected {
                                    case 1:
                                        if energyMod != 0 {
                                            ModLabel(mod: .energy)
                                        } else if healthMod != 0 {
                                            ModLabel(mod: .health)
                                        } else if hapMod != 0 {
                                            ModLabel(mod: .happiness)
                                        } else {
                                            Text("- \(formatNum(cost))")
                                                .foregroundColor(.red)
                                        }
                                    case 2:
                                        HStack {
                                            if healthMod != 0 {
                                                ModLabel(mod: .health)
                                                if hapMod != 0 {
                                                    ModLabel(mod: .happiness)
                                                } else if energyMod != 0 {
                                                    ModLabel(mod: .energy)
                                                } else {
                                                    ModLabel(mod: .cost)
                                                }
                                            } else if hapMod != 0 {

                                                ModLabel(mod: .happiness)

                                                if energyMod != 0 {
                                                    ModLabel(mod: .energy)
                                                } else {
                                                    ModLabel(mod: .cost)
                                                }

                                            } else {
                                                ModLabel(mod: .energy)

                                                ModLabel(mod: .cost)
                                            }
                                        }
                                    case 3:
                                        if healthMod != 0 {
                                            HStack {
                                                ModLabel(mod: .health)

                                                if hapMod != 0 {
                                                    ModLabel(mod: .happiness)
                                                } else {
                                                    ModLabel(mod: .energy)
                                                }
                                            }

                                            if energyMod != 0 {
                                                ModLabel(mod: .energy)
                                            } else {
                                                ModLabel(mod: .cost)
                                            }
                                        } else {
                                            HStack {
                                                ModLabel(mod: .happiness)

                                                ModLabel(mod: .energy)
                                            }

                                            ModLabel(mod: .cost)
                                        }
                                    case 4:
                                        HStack {
                                            ModLabel(mod: .health)

                                            ModLabel(mod: .happiness)
                                        }
                                        HStack {
                                            ModLabel(mod: .energy)

                                            ModLabel(mod: .cost)
                                        }
                                    default:
                                        Text("")
                                }
                            }
                            .font(.title2)

                            Spacer()
                        }

                    }
                    .foregroundColor(.white)
                }
                .overlay(
                    clickable ? nil : RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(Color.gray.opacity(0.5))
                )
            })
                .frame(maxHeight: 142)
                .buttonStyle(FriendsDetailButtonStyle())
        }

        return returnView
    }
    var Banner: some View {

        VStack(alignment: .center) {
            Spacer()
            Text(friendInfo()["name"]!)
            Spacer()
            Text(friendInfo()["emoji"]!)
                .font(Font.system(size: 40))
            StatusBar()
            Spacer()
        }
        //.font(Font.system(size: 20))
        .font(.largeTitle)
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(Color("mainDarkGray"))
        .foregroundColor(.white)
        .cornerRadius(12)
        .shadow(radius: 12)
        .padding(.horizontal)
    }

    var BackButton: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(Font.system(size: 32))
                .foregroundColor(.red)
                .padding(.horizontal)
                .onTapGesture {
                    showFriendsDetail = false
                    showFriendsView = true
                }
            Spacer()
        }
    }
}

struct FriendsDetail_Previews: PreviewProvider {
    static var previews: some View {
        FriendsDetail(showFriendsDetail: .constant(true), showFriendsView: .constant(false), friend: .friend1)
            .environmentObject(Player())
            .environmentObject(UserPreferences())
    }
}
