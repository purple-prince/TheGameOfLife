//
//  CasinoIcon.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/5/22.
//

import SwiftUI

struct CasinoIcon: View {
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    var body: some View {
        ZStack {
            iconBackground
            
            iconForeground
        }
    }
    //bitcoinsign.circle (.fill)🎰💰
    var iconForeground: some View {
        VStack(spacing: 0) {
            Text("Casino")
                .fontWeight(.medium)
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color(red: 240/255, green: 147/255, blue: 70/255),
                                 Color(red: 240/255, green: 45/255, blue: 40/255)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .font(Font.system(size: 64))
            
            HStack {
                Spacer()
                Image(systemName: "bitcoinsign.circle")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(red: 255/255, green: 165/255, blue: 0/255),
                                     Color(red: 255/255, green: 255/255, blue: 0/255),
                                     Color(red: 255/255, green: 165/255, blue: 0/255)
                                    ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                Spacer()
                Text("🎰")
                Spacer()
                Text("💰")
                Spacer()
            }
            .padding(.top)
            .font(Font.system(size: 56))
            .foregroundColor(.yellow)//
        }
    }
    
    var iconBackground: some View {
        RoundedRectangle(cornerRadius: 32)
            .fill(Color("mainDarkGray"))
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(userPreferences.appColor, lineWidth: 2)
            )
            .aspectRatio(3/2, contentMode: .fit)
            .padding()
    }
}

struct CasinoIcon_Previews: PreviewProvider {
    static var previews: some View {
        CasinoIcon()
            .environmentObject(UserPreferences())
    }
}
