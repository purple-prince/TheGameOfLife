//
//  HomeTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

struct HomeTab: View {
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    @State var showSettings: Bool = false
    @State var showOptions: Bool = false
    @EnvironmentObject var player: Player
    
    func getNetWorth() -> Int {
        return player.life_cash_balance + player.life_bank_balance
    }
    
    var body: some View {
        
        ZStack {
            ZStack {
                background
                
                VStack {
                    Spacer()
                        .frame(width: 0, height: 124)
                    
                    header
                    
                    HStack {
                        Text(player.name)
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(Color("mainWhite"))
                        
                        Text(" ·  \(player.yearsOld)")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(Color("mainWhite"))
                    }
                    
                    statusLabels
                    
                    infoLabels
                    
                    Spacer()
                }
            }
            
            showSettings ? SettingsView(showSettings: $showSettings) : nil
            
            showOptions ? OptionsView(showOptions: $showOptions) : nil
        }        
    }
}

extension HomeTab {
    

    
    func statusBar(mode: String, color: Color) -> some View {
        
        var stat: CGFloat {
            if mode == "Health" {
                return CGFloat(player.life_health_status)
            } else if mode == "Happiness" {
                return CGFloat(player.life_happiness_status)
            } else {
                return CGFloat(player.life_energy_status)
            }
        }
        
        
        return VStack(spacing: 12) {
            switch mode {
            case "Health":
                Text("♥️")
                    .font(.largeTitle)
            case "Happiness":
                Text("😀")
                    .font(.largeTitle)
            default:
                Text("⚡️")
                    .font(.largeTitle)
            }
            
            /*
             x  =  100
             -      -
             100    72
             */
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(color, lineWidth: 1)
                    .frame(width: 70, height: 12)
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: (stat * 0.7), height: 12)
                    .foregroundColor(color)
            }
        }
        .padding(.horizontal, 8)
    }
    
    var statusLabels: some View {
        HStack {
            statusBar(mode: "Health", color: Color.red)
            
            statusBar(mode: "Happiness", color: Color.yellow)
            
            statusBar(mode: "Energy", color: Color.green)
        }
        .padding()
        .background(Color(hue: 1.0, saturation: 0.027, brightness: 0.356))
        .foregroundColor(.white)
        .cornerRadius(12)
    }
    var settingsButton: some View {
        VStack {
            Image(systemName: "gearshape")
                .font(Font.system(size: 48))
                .foregroundColor(.red)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showSettings = true
                    }
                }
            
            Spacer()
                .frame(width: 0, height: 64)
        }
    }
    var background: some View {
        RoundedRectangle(cornerRadius: 40)
            .aspectRatio(5/8, contentMode: .fit)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(userPreferences.appColor, lineWidth: 1)
            )
            .padding(20)
            .foregroundColor(Color("mainDarkGray"))
            .shadow(color: .gray, radius: 12, x: 0, y: 0)
    }
    
    //net worth, age, month income, traitss, stats, goals
    var infoLabels: some View {
        
        VStack(spacing: 2) {
            Text("Stats")
                .font(.title)
            
            Color.white
                .clipShape(Capsule())
                .frame(width: UIScreen.main.bounds.width / 3, height: 2)
                .padding(.bottom, 6)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Net worth: ")
                        .bold()
                    Text(formatNum(getNetWorth()))
                }
                HStack {
                    Text("Monthly Income: ")
                        .bold()
                }
                HStack {
                    Text("Years Lived: ")
                        .bold()
                    Text("104")
                    
                }
            }
        }
        .padding(.top, 6)
        .foregroundColor(.white)
    }

    
    //stuff for the top half of the card
    var header: some View {
        HStack {
            
            Spacer()
            
            //for settings button
            settingsButton
            
            Spacer()
            
            Text(player.emoji)
                .font(Font.system(size: 84))
            
            Spacer()
            
            menuButton
            
            Spacer()
        }
    }
    
    var menuButton: some View {
        VStack {
            Image(systemName: "square.grid.2x2")
                .font(Font.system(size: 48))
                .foregroundColor(userPreferences.appColor)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showOptions = true
                    }
                }
            
            Spacer()
                .frame(width: 0, height: 64)
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
            .environmentObject(UserPreferences())
            .environmentObject(Player())
    }
}

/* contextualmenu.and.cursorarrow
 person
 person.fill
 slider.horizontal.3
 list.bullet
 square.grid.2x2
 
 */


//person.text.rectangle (.fill)
