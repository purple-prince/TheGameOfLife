//
//  RelationshipButton.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct RelationshipButton: View {
    
    let memberType: RelationshipTypes
    @Binding var showMainView: Bool
    @Binding var showParentsView: Bool
    @Binding var showRomanceView: Bool
    @Binding var showChildrenView: Bool
    @Binding var showFriendsView: Bool
    @Binding var showPetsView: Bool
    
    var mode: String {
        switch memberType {
            case .pets:
                return "Pets"
            case .friends:
                return "Friends"
            case .children:
                return "Children"
            case .romance:
                return "Romance"
            case .parents:
                return "Parents"
        }
    }
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    
    
    //determines which view the button will go to after clicking, depending if it was the parent button, friend button, etc
    /*func destinationPicker(_ category: String) -> some View {
        Group {
            switch category {
            case "Parents":
                ParentsView()
            case "Romance":
                //RomanceView()
                    Text("")
            case "Children":
                //ChildrenView()
                    Text("")
            case "Friends":
                FriendsView()
            case "Pets":
                PetsView()
            default:
                Text("error in destination picker: categorybutton.swift")
            }
        }
    }*/
        
    var body: some View {
        
            
        ZStack {
            
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color("mainDarkGray"))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(userPreferences.appColor, lineWidth: 3)
                )
            
            
            VStack {
                Text(mode)
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
        .frame(width: .infinity, height: 150)
        .onTapGesture {
            switch memberType {
                case .parents:
                    showParentsView = true
                case .romance:
                    showRomanceView = true
                case .children:
                    showChildrenView = true
                case .friends:
                    showFriendsView = true
                case .pets:
                    showPetsView = true
            }
            
            //showMainView = false
            showMainView.toggle()
        }
        .padding(.horizontal)
        .padding(.vertical, 2)
    }
}

struct RelationshipButton_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipButton(memberType: .parents, showMainView: .constant(false), showParentsView: .constant(false), showRomanceView: .constant(false), showChildrenView: .constant(false), showFriendsView: .constant(false), showPetsView: .constant(false))
            .environmentObject(UserPreferences())
    }
}
