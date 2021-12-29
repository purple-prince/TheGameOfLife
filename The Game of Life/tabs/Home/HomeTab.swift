//
//  HomeTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

struct HomeTab: View {
    
    @AppStorage("life_net_worth") var life_net_worth: Int = 0
    
    @AppStorage("app_color_index") var colorCount: Int = 0
    var appColor: Color {
        colorOptions[colorCount]
    }
    
    @State var showSettings: Bool = false
    @State var showOptions: Bool = false
    
    var body: some View {
        
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .aspectRatio(5/8, contentMode: .fit)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(appColor, lineWidth: 1)
                    )
                    .padding(20)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 12, x: 0, y: 0)
                
                VStack {
                    Spacer()
                    
                    header
                    
                    Text(maleNames.randomElement()!)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color("mainDarkGray"))
                    
                    statusLabels
                    
                    Spacer()
                }
            }
            
            showSettings ? SettingsView(showSettings: $showSettings) : nil
        }        
    }
}

extension HomeTab {
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
                .frame(width: 0, height: 112)
        }
    }
    
    var statusLabels: some View {
        VStack(/*alignment: .leading*/) {
            Text("Net Worth: $" + formatNum(life_net_worth))
                .padding(.bottom)
            Text("Monthly Income")
                .padding(.bottom)
            Text("Relationship Status: Single")
                .padding(.bottom)
            Button(action: {}, label: {
                Text("Traits >")
            })
                .padding(.bottom)
            Text("Stats")
                .padding(.bottom)
            Text("Goals")
                .padding(.bottom)
        }
        .foregroundColor(Color("mainDarkGray"))
        .padding(.top, 32)
    }
    
    //stuff for the top half of the card
    var header: some View {
        HStack {
            
            Spacer()
            
            //for settings button
            settingsButton
            
            Spacer()
            
            Text(userEmoji)
                .font(Font.system(size: 100))
            
            Spacer()
            
            menuButton
            
            Spacer()
        }
    }
    
    var menuButton: some View {
        VStack {
            Image(systemName: "person")
                .font(Font.system(size: 48))
                .foregroundColor(appColor)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showSettings = true
                    }
                }
            
            Spacer()
                .frame(width: 0, height: 112)
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}

/* contextualmenu.and.cursorarrow
 person
 person.fill
 person.circle
 person.circle.fill
 slider.horizontal.3
 list.bullet
 square.grid.2x2
 
 */


//person.text.rectangle (.fill)
