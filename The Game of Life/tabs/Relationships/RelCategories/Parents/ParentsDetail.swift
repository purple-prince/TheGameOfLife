//
//  ParentsDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 11/6/21.
//

import SwiftUI


struct ParentsDetialButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .brightness(configuration.isPressed ? 0.05 : 0)
    }
}

//CHANGING THE ASPECT RATIOS TO A DOUBLE RESULTS IN A MEMORY LEAK IDK WHY

struct ParentsDetail: View {
    
    enum Modes {
        case mom, dad
    }

    let mode: Modes
    
    @Binding var showMomDetail: Bool
    @Binding var showDadDetail: Bool
    @Binding var showParentsView2: Bool
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
    
    func StatusBar() -> some View {
        ZStack(alignment: .leading){
            
            //background bar
            RoundedRectangle(cornerRadius: 8)
                .stroke(userPreferences.appColor, lineWidth: 1)
                .frame(width: 100, height: 16)
                
            
            //foreground bar
            RoundedRectangle(cornerRadius: 8)
                .frame(width: CGFloat(mode == .mom ? player.mom_status : player.dad_status), height: 16)
                .foregroundColor(userPreferences.appColor)
        }
        .offset(y: -16)
    }
    
    func parentBanner() -> some View {
        
        VStack(alignment: .center) {
            Spacer()
            Text(mode == .mom ? player.mom_name : player.dad_name)
            Spacer()
            Text(mode == .mom ? player.mom_emoji : player.dad_emoji)
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
            
    var body: some View {
        
        VStack {
            
            //Text(String(mode == .mom ? player.mom_status : player.dad_status))
            //guard let decodedRatings = try? JSONDecoder().decode([String:Double].self, from: ratings) else { return }
            
            BackButton
            
            parentBanner()
            
            Divider()
            
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
    
    var BackButton: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(Font.system(size: 32))
                .foregroundColor(.red)
                .padding(.horizontal)
                .onTapGesture {
                    showMomDetail = false
                    showDadDetail = false
                    showParentsView2 = true
                }
            Spacer()
        }
    }
    
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

struct ParentsDetail_Previews: PreviewProvider {
    static var previews: some View {
        ParentsDetail(mode: .mom, showMomDetail: .constant(true), showDadDetail: .constant(false), showParentsView2: .constant(false))
            .environmentObject(Player())
            .environmentObject(UserPreferences())
    }
}
