//
//  SideHustleView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 9/5/21.
//

import SwiftUI

struct SHView: View {
    let tempSH = listOfSideHustles.randomElement()!
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    var body: some View {
        VStack {
            banner
            
            Divider()
            
            ScrollView {
                ForEach(listOfSideHustles, id: \.self) { sh in
                    Button(action: {}, label: {
                        HStack {
                            Text(sh.shTitle)
                            Spacer()
                            Text("$\(tempSH.salaryMin) - $\(tempSH.salaryMax)/month")
                        }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(userPreferences.appColor)
                    })
                }
            }
        }
        //.navigationBarHidden(true)
    }
}

extension SHView {
    var banner: some View {
        VStack /*current job*/ {
            Text(tempSH.shTitle)
                .bold()
                .font(.largeTitle)
            Text("Level \(tempSH.level)")
                .font(.title3)
            Text("$\(tempSH.salaryMin) - $\(tempSH.salaryMax)/month")
                .font(.title3)

            
            Spacer()
            
            HStack {
                Spacer()
                Text("- 0.3⚡️")
                    .padding(1)
                Spacer()
                Text("-0.5😀")
                Spacer()
            }
            
            Spacer()
        }
        .font(Font.custom("mainFont", size: 20))
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(userPreferences.appColor)
        .foregroundColor(userPreferences.appColor)
        .cornerRadius(12)
        .shadow(radius: 12)
        .padding()
    }
}

struct SHView_Previews: PreviewProvider {
    static var previews: some View {
        SHView()
    }
}
