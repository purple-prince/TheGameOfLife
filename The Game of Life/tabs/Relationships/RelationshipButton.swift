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
    let color: Color
    
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
            VStack {
                Text(memberType)
                    .padding(.top)
                    .font(Font.custom("mainFontBold", size: 28))
                    
                HStack {
                    Spacer()
                    Text("- 0.5 ❤️ /month")
                        .padding()
                    Spacer()
                }
                .padding(.bottom)
                //.foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255, opacity: 1))
                .foregroundColor(Color.black)
            }
            .font(Font.custom("mainFont", size: 20))
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
            .background(color)
            .cornerRadius(12)
            .shadow(radius: 6)
            .padding(.leading)
            .padding(.trailing)
            .padding(.top, 6)
            //.navigationBarHidden(true)
        }
    }
}

struct RelationshipButton_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipButton(memberType: "Parents", status: 69, color: Color.red)
    }
}
