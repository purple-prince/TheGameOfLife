//
//  RomanceDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/22/22.
//

import SwiftUI

struct RomanceDetialButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .brightness(configuration.isPressed ? 0.05 : 0)
    }
}

struct RomanceDetail: View {
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
    
    @Binding var showRomanceDetail: Bool
    @Binding var showRomanceMain: Bool
    
    @State var showFindPartner: Bool = false
    @State var showBreakupPopup: Bool = false
    
    var partner: RomanceView.Partners
    var numPartners: Int {
        if player.partner1_name == "" {
            return 0
        } else if player.partner2_name == "" {
            return 1
        } else if player.partner3_name == "" {
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
                        
                        ActionButton(partnerStatusAffect: 10, healthMod: 0, hapMod: 10, energyMod: -2, cost: 0, description: "Visit park")
                        
                        ActionButton(partnerStatusAffect: 20, healthMod: 0, hapMod: 20, energyMod: 0, cost: 50, description: "Get dinner")
                        
                    }
                    
                    HStack(spacing: 12) {
                        
                        ActionButton(partnerStatusAffect: 35, healthMod: 0, hapMod: 5, energyMod: 0, cost: 150, description: "Give gift")
                        
                        ActionButton(partnerStatusAffect: 0, healthMod: 0, hapMod: 0, energyMod: 0, cost: 0, description: "Random...")

                    }
                    
                    HStack(spacing: 12) {
                        
                        ActionButton(partnerStatusAffect: 0, healthMod: 0, hapMod: 0, energyMod: 0, cost: 0, description: "Cheat")
                        
                        ActionButton(partnerStatusAffect: -80, healthMod: 0, hapMod: -70, energyMod: 0, cost: 0, description: "Break Up")

                    }
                    
                }
                .padding(12)
                
                Spacer()
            }.blur(radius: showBreakupPopup || showFindPartner ? 50 : 0)
            
            if showBreakupPopup {
                BreakupPopup(showBreakupPopup: $showBreakupPopup, showRomanceMain: $showRomanceMain, showRomanceDetail: $showRomanceDetail, partner: partner)
            }
            
            if showFindPartner {
                FindPartnerPopup(showFindPartner: $showFindPartner, numPartners: numPartners)
            }
            
        }
    }
}

extension RomanceDetail {
    
    func partnerInfo() -> [String : String] {
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
    
    func StatusBar() -> some View {
        ZStack(alignment: .leading){
            
            //background bar
            RoundedRectangle(cornerRadius: 8)
                .stroke(userPreferences.appColor, lineWidth: 1)
                .frame(width: 100, height: 16)
                
            
            //foreground bar
            RoundedRectangle(cornerRadius: 8)
                .frame(width: CGFloat(Int(partnerInfo()["status"]!)!), height: 16)
                .foregroundColor(userPreferences.appColor)
        }
        .offset(y: -16)
    }
    
    func ActionButton(partnerStatusAffect: Int, healthMod: Int, hapMod: Int, energyMod: Int, cost: Int, description: String) -> some View {
        
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
                    
                    if description != "Break Up" && description != "Cheat" {
                        
                        HapticManager.instance.playHaptic(type: .light)
                        
                        switch partner {
                            case .partner1:
                                player.partner1_status += partnerStatusAffect
                            case .partner2:
                                player.partner2_status += partnerStatusAffect
                            case .partner3:
                                player.partner3_status += partnerStatusAffect
                            case .partner4:
                                player.partner4_status += partnerStatusAffect
                        }
                        player.life_health_status += healthMod
                        player.life_happiness_status += hapMod
                        player.life_energy_status += energyMod
                        player.life_cash_balance -= cost
                    } else if description == "Break Up"{
                        showBreakupPopup = true
                    } else {
                        showFindPartner = true
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
                        } else if description == "Cheat" {
                            Text("+1 👩‍❤️‍💋‍👨")
                                .font(.title2)
                                .foregroundColor(.green)
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
                .buttonStyle(RomanceDetialButtonStyle())
        }
        
        return returnView
        
    }
    
    var Banner: some View {
        
        VStack(alignment: .center) {
            Spacer()
            Text(partnerInfo()["name"]!)
            Spacer()
            Text(partnerInfo()["emoji"]!)
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
                    showRomanceDetail = false
                    showRomanceMain = true
                }
            Spacer()
        }
    }
}

struct BreakupPopup: View {
    
    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var player: Player
    
    @Binding var showBreakupPopup: Bool
    @Binding var showRomanceMain: Bool
    @Binding var showRomanceDetail: Bool
    
    var partner: RomanceView.Partners
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(Color("mainDarkGray"))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(userPreferences.appColor, lineWidth: 4)
                )
            
            VStack {
                Text("Are you sure?")
                    .font(.largeTitle)
                    .padding()
                    .padding(.top)
                
                Spacer()
                
                Button(action: {
                    
                    HapticManager.instance.playHaptic(type: .error)
                
                    showBreakupPopup = false
                    
                    switch partner {
                        case .partner1:
                            player.resetRomance(.partner1)
                        case .partner2:
                            player.resetRomance(.partner2)
                        case .partner3:
                            player.resetRomance(.partner3)
                        case .partner4:
                            player.resetRomance(.partner4)
                    }
                    
                    player.life_happiness_status -= 70
                    
                    showRomanceMain = true
                    showRomanceDetail = false
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(userPreferences.appColor)
                            .padding()
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .padding(.horizontal)
                        
                        Text("Breakup 💔")
                            .font(.title)
                    }
                })
            }
            .foregroundColor(.white)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showBreakupPopup = false
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .font(Font.system(size: 32))
                    })
                        .padding()
                }
                
                Spacer()
            }
            
        }
        .frame(width: .infinity, height: UIScreen.main.bounds.height / 4)
        .padding()
    }
}

/*
struct ParentsDetail: View {
             
     var body: some View {
         
         VStack {
                          
             VStack(spacing: 12) {
                 HStack(spacing: 12) {
                     
                     ActionButton(parentStatusAffect: 10, healthMod: 0, hapMod: 10, energyMod: -2, cost: 0, description: "Visit park")
                     
                     ActionButton(parentStatusAffect: 20, healthMod: 0, hapMod: 20, energyMod: 0, cost: 50, description: "Get dinner")
                     
                 }
                 
                 HStack(spacing: 12) {
                     
                     ActionButton(parentStatusAffect: 35, healthMod: 0, hapMod: 5, energyMod: 0, cost: 150, description: "Give gift")
                     
                     ActionButton(parentStatusAffect: 75, healthMod: 0, hapMod: 75, energyMod: 40, cost: 2000, description: "Take vacation")

                 }
                 
                 HStack(spacing: 12) {
                     
                     ActionButton(parentStatusAffect: -80, healthMod: 0, hapMod: -70, energyMod: -50, cost: 0, description: "Kill")
                     
                     ActionButton(parentStatusAffect: -10, healthMod: 0, hapMod: -2, energyMod: 0, cost: 0, description: "Ask for money")

                 }
                 
             }
             .padding(12)
             
             Spacer()
         }
     }
 }

 extension ParentsDetail {
     
     
     
     func ActionButton(parentStatusAffect: Int, healthMod: Int, hapMod: Int, energyMod: Int, cost: Int, description: String) -> some View {
         
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
                     if mode == .mom {
                         player.mom_status += parentStatusAffect
                     } else {
                         player.dad_status += parentStatusAffect
                     }
                     player.life_health_status += healthMod
                     player.life_happiness_status += hapMod
                     player.life_energy_status += energyMod
                     player.life_cash_balance -= cost
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
                         //health        happ
                         //energy      money
                                                 
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
                     .foregroundColor(.white)
                 }
                 .overlay(
                     clickable ? nil : RoundedRectangle(cornerRadius: 12)
                         .foregroundStyle(Color.gray.opacity(0.5))
                 )
             })
                 .frame(maxHeight: 142)
                 .buttonStyle(ParentsDetialButtonStyle())
         }
         
         return returnView
         
     }
 }
 */

struct RomanceDetail_Previews: PreviewProvider {
    static var previews: some View {
        RomanceDetail(showRomanceDetail: .constant(true), showRomanceMain: .constant(false), partner: .partner1)
            .environmentObject(Player())
            .environmentObject(UserPreferences())
//        BreakupPopup(showBreakupPopup: .constant(true))
//            .environmentObject(UserPreferences())
    }
}
