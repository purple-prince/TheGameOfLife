//
//  relationships.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

struct RelationshipTab: View {
        
    @State var showMainView: Bool = true
    @State var showParentsView: Bool = false
    @State var showRomanceView: Bool = false
    @State var showChildrenView: Bool = false
    @State var showFriendsView: Bool = false
    @State var showPetsView: Bool = false
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences

    var body: some View {
        
            
        ZStack {
            Color("mainWhite").ignoresSafeArea()
            
            if showMainView {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0..<RelationshipTypes.allCases.count) { occupation in
                            RelationshipButton(memberType: RelationshipTypes.allCases[occupation],
                                               showMainView: $showMainView,
                                               showParentsView: $showParentsView,
                                               showRomanceView: $showRomanceView,
                                               showChildrenView: $showChildrenView,
                                               showFriendsView: $showFriendsView,
                                               showPetsView: $showPetsView)
                                .padding(.vertical, 4)
                        }
                    }
                }
            }
            if showParentsView {
                ParentsView(showMainView: $showMainView, showParentsView: $showParentsView)
            } else if showRomanceView {
                RomanceView(showMainView: $showMainView, showRomanceView: $showRomanceView)
            //}  else if showChildrenView {
//
            } else if showFriendsView {
                FriendsView(showFriendsViewEx: $showFriendsView, showRelationshipTab: $showMainView)
            } else if showPetsView {
                PetsView(showRelationshipTab: $showMainView, showPetsView: $showPetsView)
//            } else {
//                Text("Error: RelationshipTab / RelationshipButton")
            }
        }
        
    }
}

struct RelationshipTab_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipTab()
            .environmentObject(UserPreferences())
            .environmentObject(Player())
    }
}
