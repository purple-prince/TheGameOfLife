//
//  relationships.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

protocol FamMember: Hashable, Identifiable {    
    var age: Int {get}
    var id: UUID {get}
    var status: Int {get}
    var emoji: String {get}
}

extension FamMember {
    var id: UUID {
        return UUID()
    }
    var emoji: String {
        return "NO EMOJI"
    }
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
                Color("mainWhite").ignoresSafeArea()
                ScrollView {
                    VStack {
                        ForEach(0..<relationshipCategories.count) { occupation in
                            RelationshipButton(memberType: relationshipCategories[occupation], status: 0)
                                .padding(.vertical, 4)
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
            .environmentObject(UserPreferences())
    }
}
