//
//  OccupationTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI
//@AppStorage("life_net_worth") var life_net_worth: Int = 0

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
                Color(red: 235/255, green: 235/255, blue: 235/255).ignoresSafeArea()
                ScrollView {
                    
                    ZStack {
                        ZStack {
                            
                            Color(red: 235/255, green: 235/255, blue: 235/255)//.ignoresSafeArea()
                            
                            VStack {
                                
                                VStack {
                                    ForEach(0..<occupationCategories.count) { occupation in
                                        CategoryButton(category: occupationCategories[occupation], position: "None", salary: 0, color: backgroundColors[occupation])
                                    }
                                }
                            }
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
    }
}
