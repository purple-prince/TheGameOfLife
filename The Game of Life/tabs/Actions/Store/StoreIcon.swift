//
//  StoreIcon.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 2/27/22.
//

import SwiftUI

struct StoreIcon: View {
    
    var body: some View {
        ZStack {
            Background
            
            Foreground
        }
        .aspectRatio(3/2, contentMode: .fit)
        .padding()
    }
    
    var Background: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color("mainDarkGray"))
            /*.overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(userPreferences.appColor, lineWidth: 2)
            )*/
    }
    
    var Foreground: some View {
        ZStack {
            VStack(spacing: 8) {
                Text("The")
                    .fontWeight(.light)
                    .font(.title)
                Text("Everything")
                    .font(Font.system(size: 48))
                Text("Store")
                    .fontWeight(.light)
                    .font(.title)
                
                Spacer()
                //🍕
                HStack {
                    HStack {
                        Spacer()
                        Text("📠")
                        Spacer()
                        Text("🛍")
                        Spacer()
                        Text("🍎")
                        Spacer()
                    }
                    .font(Font.system(size: 40))
                    .offset(x: 0, y: -20)
                }
            }
            .padding(.top)
            .foregroundColor(.white)
        }
    }
}

struct StoreIcon_Previews: PreviewProvider {
    static var previews: some View {
        StoreIcon()
    }
}
