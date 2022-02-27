//
//  OccupationTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

struct OccupationTab: View {
    
    @State var showOccupationMain: Bool = true
    @State var showJobView: Bool = false
    @State var showSHView: Bool = false
    @State var showSportsView: Bool = false
    @State var showRealEstateView: Bool = false
    @State var showCrimeView: Bool = false
    
    
    let occupationCategories = ["Job", "Side Hustle", "Sports",
                                "Real Estate", "Crime"]
        
    let backgroundColors = [Color("mainRed"),
                            Color("mainOrange"),
                            Color("mainLightGreen"),
                            Color("mainMutedBlue"),
                            Color("mainBrown")]

    
    var body: some View {
        
            
        ZStack {
            
            Color("mainWhite").ignoresSafeArea()
            
            if showOccupationMain {
                ScrollView {
                    VStack {
                        ForEach(0..<occupationCategories.count) { occupation in
                            CategoryButton(showOccupationMain: $showOccupationMain, showJobView: $showJobView, showSHView: $showSHView, showSportsView: $showSportsView, showRealEstateView: $showRealEstateView, showCrimeView: $showCrimeView, category: occupationCategories[occupation], position: "None", salary: 0, color: backgroundColors[occupation])//TODO: IMPLEMENT THIS!! diff colors for each... makes more interesting
                        }
                    }
                }
            } else if showJobView {
                JobView(showOccupationMain: $showOccupationMain, showJobView: $showJobView)
            } else if showSHView {
                SHView()
            } else if showSportsView {
                
            } else if showRealEstateView {
                
            } else {
                
            }
        }
    }
}


struct OccupationTab_Previews: PreviewProvider {
    static var previews: some View {
        OccupationTab()
            .environmentObject(UserPreferences())
            .environmentObject(Player())
    }
}
