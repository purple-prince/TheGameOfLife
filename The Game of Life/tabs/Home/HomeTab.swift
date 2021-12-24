//
//  HomeTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

struct HomeTab: View {
    
    @AppStorage("app_color_index") var colorCount: Int = 0

    var appColor: Color {
        colorOptions[colorCount]
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .aspectRatio(5/8, contentMode: .fit)
                .padding(20)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 12, x: 0, y: 0)
            VStack {
                Spacer()
                Text(userEmoji)
                    .font(Font.system(size: 100))
                    .padding()
                Text(maleNames.randomElement()!)
                    .font(.title)
                    .foregroundColor(appColor)
                VStack(/*alignment: .leading*/) {
                    Text("Net Worth: $ 8,475")
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
                .foregroundColor(appColor)
                .padding(.top, 32)
                Spacer()
            }
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
