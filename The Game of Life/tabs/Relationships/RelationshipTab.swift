//
//  relationships.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

protocol FamMember: Hashable {
    var age: Int {get}
}

struct RelationshipTab: View {
    let relationshipCategories = ["Parents", "Romance", "Children",
                                "Friends", "Pets"]
        
    /*let backgroundColors = [Color.white,
                            Color.white,
                            Color.white,
                            Color.white,
                            Color.white]*/

    var body: some View {
        
        NavigationView {
            
            ZStack {
                //Color(red: 235/255, green: 35/255, blue: 195/255, opacity: 0.5).ignoresSafeArea()
                ScrollView {
                    VStack {
                        ForEach(0..<relationshipCategories.count) { occupation in
                            RelationshipButton(memberType: relationshipCategories[occupation], status: 0, color: Color(red: 235/255, green: 35/255, blue: 195/255, opacity: 0.5))
                        }
                    }
                }
            }
        }
    }
}

struct RelationshipTab_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipTab()
    }
}
