//
//  FriendsView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct FriendsView: View {
    @State var showFriendsDetail: Bool = false
    @State var showFriendsView: Bool = true
    @State var showFindFriends: Bool = false
    
    
    @Binding var showFriendsViewEx: Bool
    @Binding var showRelationshipTab: Bool
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
    
    @State var selectedFriend: Friends?

    var body: some View {
                
        ZStack {
            
            Color("mainWhite").ignoresSafeArea()
            
            if showFriendsView {
                ZStack {
                    VStack {
                        
                        BackButton
                        
                        banner
                        
                        Divider()
                        
                        if player.friend1_name == "" && player.friend2_name == "" && player.friend3_name == "" && player.friend4_name == "" {
                            findFriendsView
                        }
                        
                        VStack {
                            if player.friend1_name != "" {
                                FriendLink(friend: .friend1)
                            }
                            if player.friend2_name != "" {
                                FriendLink(friend: .friend2)
                            }
                            if player.friend3_name != "" {
                                FriendLink(friend: .friend3)
                            }
                            if player.friend4_name != "" {
                                FriendLink(friend: .friend4)
                            }
                        }
                        Spacer()
                    }
                    .blur(radius: showFindFriends ? 10 : 0)
                    
                    if showFindFriends {
                        if player.partner1_name == "" {
                            FindFriendsPopup(showFindFriends: $showFindFriends, numFriends: 0)
                        } else if player.partner2_name == "" {
                            FindFriendsPopup(showFindFriends: $showFindFriends, numFriends: 1)
                        } else if player.partner3_name == "" {
                            FindFriendsPopup(showFindFriends: $showFindFriends, numFriends: 2)
                        } else if player.partner4_name == "" {
                            FindFriendsPopup(showFindFriends: $showFindFriends, numFriends: 3)
                        }
                    }
                    
                }
            }
            
            if showFriendsDetail {
                FriendsDetail(showFriendsDetail: $showFriendsDetail, showFriendsView: $showFriendsView, friend: selectedFriend!)
            }
        }
    }
}

extension FriendsView {

    var findFriendsView: some View {
        VStack {
            Text("No friends 🤡🤣 loser")
                .foregroundColor(.pink)
                .font(.largeTitle)
                .fontWeight(.medium)

            Button(action: {
                showFindFriends = true
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 26)
                        .fill(Color.pink)
                        .brightness(0.1)
                    Text("Find Friends")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.title)
                }
            })
                .padding(.horizontal)
                .padding(.horizontal)
                .frame(height: 120)
        }
    }

    var banner: some View {
        VStack {
            Spacer()

            Text("Friends")
                .bold()
                .font(.largeTitle)
            Spacer()
            Text("-0.5/month")
                .font(.title3)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(Color("mainDarkGray"))
        .foregroundColor(.white)
        .cornerRadius(12)
        .shadow(radius: 12)
        .padding()
    }

    var BackButton: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(Font.system(size: 32))
                .foregroundColor(.red)
                .padding(.horizontal)
                .onTapGesture {
                    showRelationshipTab = true
                    showFriendsViewEx = false
                }
            Spacer()
        }
    }

    public enum Friends {
        case friend1, friend2, friend3, friend4
    }

    func friendInfo(friend: Friends) -> [String : String] {
        switch friend {
            case .friend1:
                return [
                    "name" : player.friend1_name,
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

    func FriendLink(friend: Friends) -> some View {
        VStack {
            HStack {
                Text(friendInfo(friend: friend)["emoji"]! + " " + friendInfo(friend: friend)["name"]!)
                    .lineLimit(1)
                    .layoutPriority(1)
                Color("mainWhite")
                    .frame(width: .infinity, height: 1)
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 100, height: 12)
                        .foregroundColor(Color.gray)

                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: CGFloat(Int(friendInfo(friend: friend)["status"]!)!), height: 12)
                        .foregroundColor(userPreferences.appColor)
                }
            }
            .padding()
            .font(.system(size: 20))
            .foregroundColor(.black)
            .onTapGesture {
                selectedFriend = friend
                showFriendsDetail = true
                showFriendsView = false
            }

            Capsule()
                .fill(Color("mainDarkGray"))
                .frame(width: .infinity, height: 1)
                .padding(.horizontal, 8)
                //.padding(.horizontal)
        }
    }
}

struct FindFriendsPopup: View {

    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var player: Player

    @Binding var showFindFriends: Bool
    var numFriends: Int

    func getFriendChoices() -> [Friend]/*[Int : [String : String]]*/ {
        return [Friend(player: player), Friend(player: player), Friend(player: player)]
    }

    let quotes: [String] = ["Sexy and I know it",
                            "Nothing is more beautiful than love",
                            "corn",
                            "Ranked #8 globally in clash. Check out my yt",
                            "I'm next up 😈💯💪 Peep my soundcloud",
                            "boi 😂 #TPOSE #BANDKIDZRULE #FORTNITE",
                            "Why can't we just print more money?"]

    var body: some View {
        ZStack {

            Background

            Main

            BackButton

        }
        .frame(width: .infinity, height: .infinity)
        .padding()
    }

    var BackButton: some View {
        VStack {
            HStack {

                Spacer()

                Image(systemName: "xmark")
                    .foregroundColor(.red)
                    .font(Font.system(size: 42))
                    .padding()
                    .onTapGesture {
                        showFindFriends = false
                    }
            }

            Spacer()
        }
        .frame(width: .infinity, height: 550)
    }

    var Main: some View {
        VStack {

            ForEach(getFriendChoices()) { friend in
                VStack {
                    HStack {
                        Text(friend.emoji)
                            .font(Font.system(size: 90))

                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 0) {
                                Text(friend.name.split(separator: " ")[0])
                                    .fontWeight(.medium)
                                    .font(.title)
                                Text(",  \(String(friend.age))")
                                    .fontWeight(.thin)
                                    .font(.title)
                            }

                            Text("\"\(quotes.randomElement()!)\"")
                                .italic()
                                .fontWeight(.thin)
                        }

                        Spacer()
                    }
                    .onTapGesture {
                        if numFriends == 0 {
                            player.friend1_name    = friend.name
                            player.friend1_age     = friend.age
                            player.partner1_emoji  = friend.emoji
                            player.partner1_status = 100
                        } else if numFriends == 1 {
                            player.friend2_name   = friend.name
                            player.friend2_age    = friend.age
                            player.friend2_emoji  = friend.emoji
                            player.friend2_status = 100
                        } else if numFriends == 2 {
                            player.friend3_name   = friend.name
                            player.friend3_age    = friend.age
                            player.friend3_emoji  = friend.emoji
                            player.friend3_status = 100
                        } else {
                            player.friend4_name   = friend.name
                            player.friend4_age    = friend.age
                            player.friend4_emoji  = friend.emoji
                            player.friend4_status = 100
                        }

                        showFindFriends = false
                    }
                    .padding()
                }
            }
        }
        .foregroundColor(.white)
    }

    var Background: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(Color("mainDarkGray"))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(userPreferences.appColor, lineWidth: 4)
        )
        .shadow(color: .black, radius: 16)
        .frame(width: .infinity, height: 550)
    }
}

struct Friend: Identifiable {

    enum Gender: CaseIterable {
        case male, female
    }

    let id: UUID = UUID()

    var player: Player

    let gender: Gender = Gender.allCases.randomElement()!
    var name: String { gender == .female ? femaleNames.randomElement()! : maleNames.randomElement()! }
    var emoji: String { gender == .female ? (player.age_stage == .kid ? girlEmojis.randomElement()! : player.age_stage == .adult ? momEmojis.randomElement()! : grandmaEmojis.randomElement()!) : (player.age_stage == .kid ? boyEmojis.randomElement()! : player.age_stage == .adult ? dadEmojis.randomElement()! : grandpaEmojis.randomElement()!) }
    var age: Int {
        Int.random(in: (player.yearsOld - 5)...(player.yearsOld + 5))
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(showFriendsViewEx: .constant(true), showRelationshipTab: .constant(false))
            .environmentObject(Player())
            .environmentObject(UserPreferences())
    }
}
