//
//  RelationshipButton.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct RelationshipButton: View {
    
    let memberType: String
    let status: Int //use for later, replace 0.5/heart with the status percentage %
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    //determines which view the button will go to after clicking, depending if it was the parent button, friend button, etc
    func destinationPicker(_ category: String) -> some View {
        Group {
            switch category {
            case "Parents":
                ParentsView()
            case "Romance":
                RomanceView()
            case "Children":
                ChildrenView()
            case "Friends":
                FriendsView()
            case "Pets":
                PetsView()
            default:
                Text("error in destination picker: categorybutton.swift")
            }
        }
    }
        
    var body: some View {
        
        NavigationLink(destination: destinationPicker(memberType)) {
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color("mainDarkGray"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(userPreferences.appColor, lineWidth: 3)
                    )
                
                VStack {
                    Text(memberType)
                        .padding(.top)
                        .font(Font.custom("mainFontBold", size: 28))
                        .foregroundColor(userPreferences.appColor)
                        
                    HStack {
                        Spacer()
                        Text("- 0.5 ❤️ /month")
                            .padding()
                        Spacer()
                    }
                    .padding(.bottom)
                    .foregroundColor(userPreferences.appColor)
                }
                .font(Font.custom("mainFont", size: 20))
                .padding(.top, 6)
                .padding(.horizontal)
            }
            .frame(width: .infinity, height: 100)
            
        }
        .padding()
    }
}

struct RelationshipButton_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipButton(memberType: "Parents", status: 69)
            .environmentObject(UserPreferences())
    }
}
