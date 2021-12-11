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
    
    let category: String
    let position: String
    let salary: Int
    let color: Color
    
    func destinationPicker(_ category: String) -> some View {
        Group {
            switch category {
            case "Job":
                JobView()
            case "Side Hustle":
                SHView()
            default:
                Text("error in destination picker: categorybutton.swift")
            }
        }
    }
        
    var body: some View {
        
        NavigationLink(destination: destinationPicker(category)) {
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
            //.navigationBarHidden(true)
        }
    }
}

struct OccupationButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(category: "Job", position: "Junior Developer", salary: 69, color: Color.red)
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
