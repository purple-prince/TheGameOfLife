//
//  OccupationTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

struct OccupationTab: View {
    
    
    let occupationCategories = ["Job", "Side Hustle", "Sports",
                                "Real Estate", "Crime"]
        
    let backgroundColors = [Color("mainRed"),
                            Color("mainOrange"),
                            Color("mainLightGreen"),
                            Color("mainMutedBlue"),
                            Color("mainBrown")]

    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color("mainWhite").ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        ForEach(0..<occupationCategories.count) { occupation in
                            CategoryButton(category: occupationCategories[occupation], position: "None", salary: 0, color: backgroundColors[occupation])//TODO: IMPLEMENT THIS!! diff colors for each... makes more interesting
                        }
                    }
                }
            }
        }
    }
}


struct OccupationTab_Previews: PreviewProvider {
    static var previews: some View {
        OccupationTab()
            .environmentObject(UserPreferences())
    }
}
