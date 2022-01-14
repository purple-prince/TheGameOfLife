//
//  MainView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/20/21.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var userPreferences = UserPreferences()
    @StateObject var player = Player()
    
    
    @State var showActionsView: Bool = false
    @State var showRelationshipsView: Bool = false
    @State var showIdentityView: Bool = true
    @State var showLearnView: Bool = false
    @State var showWorkView: Bool = false
    @State var showAssetsView: Bool = false
    
    var body: some View {
        /*VStack {
            TabView {
                
                ActionTab()
                    .tabItem {
                        Image(systemName: "book.fill")
                            .frame(width: 4, height: 4)
                    }
                
                RelationshipTab()
                    .tabItem {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                
                HomeTab()
                    .tabItem {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                
                LearnTab()
                    .tabItem {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                
                OccupationTab()
                    .tabItem {
                        Image(systemName: "briefcase.fill")
                    }
                
                AssetTab()
                    .tabItem {
                        
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            
                    }
                
                
            }
            .accentColor(.red)
            .edgesIgnoringSafeArea(.all)
            
        }*/
        
        if(player.on_new_life) {
            NewLifeView()
                .environmentObject(player)
        } else {
            ZStack {
                if showActionsView { ActionTab() }
                if showRelationshipsView { RelationshipTab() }
                if showIdentityView { HomeTab() }
                if showLearnView { LearnTab() }
                if showWorkView { OccupationTab() }
                if showAssetsView { AssetTab() }
                
                VStack {
                    Spacer()
                    tabBar
                }
            }
            .environmentObject(userPreferences)
            .environmentObject(player)
        }
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
            
            Spacer()
            
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
                    .frame(width: 11)
                    
            }
            
            Spacer()
            
            HStack {
                Spacer()
                    .frame(width: 11)
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
            
            Spacer()
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
