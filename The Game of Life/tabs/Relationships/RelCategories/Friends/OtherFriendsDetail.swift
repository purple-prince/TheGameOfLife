//
//  OtherFriendsDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 3/14/22.
//

import SwiftUI

struct OtherFriendsDetailButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .brightness(configuration.isPressed ? 0.05 : 0)
    }
}

struct OtherFriendsDetail: View {
    
    @EnvironmentObject var player: Player
    
    @Binding var showFriendsDetail: Bool
    @Binding var showFriendsView: Bool
    
    @State var showFindFriends: Bool = false
    @State var showAskOutPopup: Bool = true
    
    var friend: FriendsView.Friends
    var firstName: String {

        
        String(friendInfo()["name"]!.split(separator: " ")[0])
        
    }
    
    func friendInfo() -> [String : String] {
        switch friend {
            case .friend1:
                return [
                    "name" : (player.friend1_name == "" ? "test worked" : player.friend1_name),
                    "emoji" : player.friend1_emoji,
                    "age" : String(player.friend1_age),
                    "status" : String(player.friend1_status)
                ]
            case .friend2:
                return [
                    "name" : player.friend2_name,
                    "emoji" : player.friend2_emoji,
                    "age" : String(player.friend2_age),
                    "status" : String(player.friend2_status)
                ]
            case .friend3:
                return [
                    "name" : player.friend3_name,
                    "emoji" : player.friend3_emoji,
                    "age" : String(player.friend3_age),
                    "status" : String(player.friend3_status)
                ]
            case .friend4:
                return [
                    "name" : player.friend4_name,
                    "emoji" : player.friend4_emoji,
                    "age" : String(player.friend4_age),
                    "status" : String(player.friend4_status)
                ]
        }
    }
    
    var body: some View {
        Text(firstName + "")
    }
    
}

struct OtherFriendsDetail_Previews: PreviewProvider {
    static var previews: some View {
        OtherFriendsDetail(showFriendsDetail: .constant(true), showFriendsView: .constant(false), friend: .friend1)
            .environmentObject(UserPreferences())
            .environmentObject(Player())
    }
}
