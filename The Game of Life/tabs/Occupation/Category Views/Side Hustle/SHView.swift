//
//  SideHustleView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 9/5/21.
//

import SwiftUI

struct SHView: View {
            
    @State var mode: Player.SHTypes = .youtube
    
    @State var clicked: Bool = false
    
    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var player: Player
    
    var body: some View {
        VStack {
            banner
                .blur(radius: clicked ? 10 : 0)
                .onTapGesture {
                    clicked = false
                }
            
            ZStack {
                VStack {
                    
                    Divider()
                        .blur(radius: clicked ? 10 : 0)
                    
                    SHDetail(mode: $mode)
                        .blur(radius: clicked ? 10 : 0)
                }
                .onTapGesture {
                    clicked = false
                }
                
                //SHModePicker(mode: $mode, clicked: $clicked)
                SHModePicker(mode: $mode, clicked: $clicked)
            }
        }
        .background(Color("mainWhite"))
        //.navigationBarHidden(true)
    }
}

extension SHView {
    
    func ModeView() -> some View {
        ZStack {
            HStack {
                
            }
        }
        .padding()
    }
    
    var banner: some View {
        
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Side Hustles")
                        .font(.title)
                        .fontWeight(.medium)
                    Spacer()
                }
                .foregroundColor(.white)
                
                Capsule()
                    .foregroundColor(.white)
                    .frame(width: .infinity, height: 1)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.horizontal)
                
                VStack {
                    
                    if player.sh_apps > 0 {
                        Text("" + "Apps: " + "")
                    }
                    if player.sh_music > 0 {
                        Text("" + "Songs: " + "")
                    }
                    if player.sh_artist > 0 {
                        Text("" + "Works: " + "")
                    }
                    if player.sh_selling > 0 {
                        Text("" + "Products: " + "")
                    }
                    if player.sh_youtube > 0 {
                        Text("" + "Videos: " + "")
                    }
                    if player.sh_babysitter > 0 {
                        Text("" + "Clients: " + "")
                    }
                }
                .foregroundColor(.white)
                .padding(.top)
                
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color("mainDarkGray"))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(userPreferences.appColor, lineWidth: 2)
                )
        )
        .padding()
    }
}

struct SHModePicker: View {
    
    @Binding var mode: Player.SHTypes
    
    @Binding var clicked: Bool
    
    func optionLabel(title: String, isMain: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("mainDarkGray"))
            
            Text(title)
                .foregroundColor(.white)
                .padding()
                //.padding(.trailing, isMain ? 0 : 9)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: 60)
        .padding(.trailing, isMain ? 0 : 18)
    }
    
    var body: some View {
        
        VStack {
            DisclosureGroup(isExpanded: $clicked, content: {
                VStack {
                    if mode != .youtube {
                        optionLabel(title: "🎥 Youtube", isMain: false)
                            .onTapGesture {
                                mode = .youtube
                                clicked.toggle()
                            }
                    }
                    if mode != .music {
                        optionLabel(title: "🎶 Music", isMain: false)
                            .onTapGesture {
                                mode = .music
                                clicked.toggle()
                            }
                    }
                    if mode != .babysitting {
                        optionLabel(title: "👩‍🍼 Babysitting", isMain: false)
                            .onTapGesture {
                                mode = .babysitting
                                clicked.toggle()
                            }
                    }
                    if mode != .art {
                        optionLabel(title: "🎨 Art", isMain: false)
                            .onTapGesture {
                                mode = .art
                                clicked.toggle()
                            }
                    }
                    if mode != .selling {
                        optionLabel(title: "🚛 Online Selling", isMain: false)
                            .onTapGesture {
                            mode = .selling
                            clicked.toggle()
                        }
                    }
                    if mode != .apps {
                        optionLabel(title: "🧑‍💻 App Development", isMain: false)
                            .onTapGesture {
                                mode = .apps
                                clicked.toggle()
                            }
                    }
                }
            }, label: {
                optionLabel(title: mode == .youtube ? "🎥 Youtube" :
                                mode == .music ? "🎶 Music" :
                                mode == .babysitting ? "👩‍🍼 Babysitting" :
                                mode == .art ? "🎨 Art" :
                                mode == .selling ? "🚛 Online Selling" : "🧑‍💻 App Development", isMain: true)
                    
            })
                .padding(.horizontal)
                .padding(.leading)
            
            Spacer()
        }
    }
}



struct SHView_Previews: PreviewProvider {
    static var previews: some View {
        SHView()
            .environmentObject(UserPreferences())
            .environmentObject(Player())
    }
}
