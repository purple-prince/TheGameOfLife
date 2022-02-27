//
//  MainView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/20/21.
//

import SwiftUI

struct AgeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .aspectRatio(contentMode: .fit)
            .frame(width: 72)
            .foregroundColor(.red)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
    }
}

struct MainView: View {
    
    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var player: Player
    
    
    @State var showActionsView: Bool = false
    @State var showRelationshipsView: Bool = false
    @State var showIdentityView: Bool = true
    @State var showLearnView: Bool = false
    @State var showWorkView: Bool = false
    @State var showAssetsView: Bool = false
    @State var showShop: Bool = false
    
    var body: some View {
        
        if(player.on_new_life) {
            NewLifeView()
                .environmentObject(player)
                //.environmentObject(userPreferences)
        } else if showShop {
            ShopView(showShop: $showShop)
        } else {
            ZStack {

                Color("mainWhite").ignoresSafeArea()
                
                VStack {
                    topInfo
                    Spacer()
                    if showActionsView { ActionTab() }
                    if showRelationshipsView { RelationshipTab() }
                    if showIdentityView { HomeTab() }
                    if showLearnView { LearnTab() }
                    if showWorkView { OccupationTab() }
                    if showAssetsView { AssetTab() }
                    Spacer()
                    tabBar
                }
                
                AgeButton
                
            }
            //.environmentObject(userPreferences)
            //.environmentObject(player)
        }
    }
    
    var AgeButton: some View {
        VStack {
            
            Spacer()
            
            Button(action: {
                HapticManager.instance.playHaptic(type: .rigid)
                player.months_old += 1
            }, label: {
                Image(systemName: "plus.diamond.fill")
                    .resizable()

            })
                .buttonStyle(AgeButtonStyle())
            
        }
    }
    
    enum StatusModes {
        case health, happiness, energy
    }
    
    func topInfoStatusBar(mode: StatusModes) -> some View {
        
        var color: Color = mode == .health ? Color.red : mode == .happiness ? Color.yellow : Color.green
        
        var returnView: some View {
            ZStack(alignment: .leading) {
                Capsule()
                    .stroke(color, lineWidth: 1)
                    .frame(width: 35, height: 10)
                
                Capsule()
                    .frame(width: CGFloat(Double((mode == .health ? player.life_health_status : mode == .happiness ? player.life_happiness_status : player.life_energy_status)) * 0.35), height: 10)
            }
            .foregroundColor(color)
        }
        
        return returnView
    }
    
    var topInfo: some View {
        HStack {
            HStack {
                Spacer()
                Text(formatNum(player.life_cash_balance))
                Spacer()
                Text("|")
                Spacer()
                Text(String(player.yearsOld) + " y/o")
                Spacer()
            }
            
            
            Spacer()
            HStack {
                topInfoStatusBar(mode: .health)
                topInfoStatusBar(mode: .happiness)
                topInfoStatusBar(mode: .energy)
            }
            
            Spacer()
            
            
            
            Image(systemName: "cart.fill")
                .foregroundColor(userPreferences.appColor)
                .onTapGesture {
                    showShop = true
                }
            
            Spacer()
        
        }
        .font(.title3)
        .padding(.horizontal)
        .padding(.bottom, 8)
        .foregroundColor(.white)
        .background(Color("mainDarkGray").ignoresSafeArea())
    }
    
    func resetViewBools(except: Tabs) -> Void {
        showActionsView = false
        showRelationshipsView = false
        showIdentityView = false
        showLearnView = false
        showWorkView = false
        showAssetsView = false
        
        switch except {
            case .action:
                showActionsView = true
            case .relationship:
                showRelationshipsView = true
            case .identity:
                showIdentityView = true
            case .learn:
                showLearnView = true
            case .work:
                showWorkView = true
            case .assets:
                showAssetsView = true
        }
    }
        
    var tabBar: some View {
        
        
        
        HStack(spacing: 0) {
            
            
            HStack {
                Spacer()
                tabImage("flame.fill", color: .orange)
                    .onTapGesture {
                        resetViewBools(except: .action)
                    }
                
                Spacer()
                tabImage("heart.fill", color: .red)
                    .onTapGesture {
                        resetViewBools(except: .relationship)
                    }
                
                Spacer()
                tabImage("person.text.rectangle", color: .blue)
                    .onTapGesture {
                        resetViewBools(except: .identity)
                    }
                
                Spacer()
                Spacer()
                    
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Spacer()
                tabImage("books.vertical", color: .brown)
                    .onTapGesture {
                        resetViewBools(except: .learn)
                    }
                Spacer()
                tabImage("briefcase.fill", color: .gray)
                    .onTapGesture {
                        resetViewBools(except: .work)
                    }
                Spacer()
                tabImage("banknote.fill", color: .green)
                    .onTapGesture {
                        resetViewBools(except: .assets)
                    }
                Spacer()
            }
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
        .background(Color("mainDarkGray"))
        
    }
    
    func tabImage(_ imageName: String, color: Color) -> some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(color)
            .padding(.top, 10)
            .frame(maxWidth: 32)
    }
}

enum Tabs {
    case action, relationship, identity, learn, work, assets
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserPreferences())
            .environmentObject(Player())
    }
}








