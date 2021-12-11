//
//  ContentView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 7/2/21.
//

import SwiftUI

struct ContentView: View {
    
    //let swiftColor = UIColor(Color("appMainWhite"))
    
    //init() {
        //UITabBar.appearance().barTintColor = swiftColor
    //}
    
    var body: some View {
        ZStack {
            //Color("ainWhite").ignoresSafeArea()
            VStack {
                TabView {
                    AssetTab()
                        .tabItem {
                            
                            Image(systemName: "house.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                
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
                    OccupationTab()
                        .tabItem {
                            Image(systemName: "briefcase.fill")
                        }
                    ActionTab()
                        .tabItem {
                            Image(systemName: "book.fill")
                        }
                    
                }
                .accentColor(.red)
                
            }
        }
        //.background(Color("mainWhite"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
