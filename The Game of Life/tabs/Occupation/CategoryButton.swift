//
//  OccupationButton.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/23/21.
//

import SwiftUI

/*protocol Tab: View where Body: View {
    var body: Self.Body { get }
    
}*/

struct CategoryButton: View {
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    @Binding var showOccupationMain: Bool
    @Binding var showJobView: Bool
    @Binding var showSHView: Bool
    @Binding var showSportsView: Bool
    @Binding var showRealEstateView: Bool
    @Binding var showCrimeView: Bool
    
    let category: String
    let position: String
    let salary: Int
    let color: Color
        
    var body: some View {
        
        Button(action: {
            switch category {
                case "Job":
                    showJobView = true
                case "Side Hustle":
                    showSHView = true
                case "Sports":
                    showSportsView = true
                case "Real Estate":
                    showRealEstateView = true
                default:
                    showCrimeView = true
            }
            
            showOccupationMain = false
            
        }, label: {
            VStack {
                Text(category)
                    .padding(.top)
                    .font(Font.custom("mainFontBold", size: 28))
                
                HStack {
                    Spacer()
                    Text("\(position)")
                        .padding()
                    Spacer()
                    Text("$\(salary)/month")
                        .padding()
                    Spacer()
                }
                .padding(.bottom)
            }
            .font(Font.custom("mainFont", size: 20))
            
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color("mainDarkGray"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(userPreferences.appColor, lineWidth: 4)
            )
            .foregroundColor(userPreferences.appColor)
            .shadow(radius: 6)
        })
            .frame(maxWidth: .infinity)
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.top, 6)
            .buttonStyle(.plain)
    }
}

struct OccupationButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(showOccupationMain: .constant(false), showJobView: .constant(false), showSHView: .constant(false), showSportsView: .constant(false), showRealEstateView: .constant(false), showCrimeView: .constant(false), category: "Job", position: "Junior Developer", salary: 69, color: Color.red)
            .environmentObject(UserPreferences())
    }
}

/*
 //
 //  OccupationButton.swift
 //  The Game of Life
 //
 //  Created by Charlie Reeder on 8/23/21.
 //

 import SwiftUI

 struct CategoryButton: View {
     
     let category: String
     let position: String
     let salary: Int
     let color: Color
         
     var body: some View {
         Button(action: {
             
         }, label: {
             VStack {
                 VStack {
                     Text(category)
                         .padding(.top)
                         .font(Font.custom("mainFontBold", size: 28))
                         
                     HStack {
                         Spacer()
                         Text("\(position)")
                             .padding()
                         Spacer()
                         Text("$\(salary)/month")
                             .padding()
                         Spacer()
                     }
                     .padding(.bottom)
                     .foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255, opacity: 1))
                 }
                 .font(Font.custom("mainFont", size: 20))
                 .frame(maxWidth: .infinity)
                 .foregroundColor(.white)
                 .background(color)
                 .cornerRadius(12)
                 .shadow(radius: 6)
                 .padding(.leading)
                 .padding(.trailing)
                 .padding(.top, 6)
             }
         })

     }
 }

 struct OccupationButton_Previews: PreviewProvider {
     static var previews: some View {
         CategoryButton(category: "Job", position: "Junior Developer", salary: 69, color: Color.red)
     }
 }

 */
