//
//  SHDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/31/22.
//

import SwiftUI

struct SHWorkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

struct SHDetail: View {
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
            
    @Binding var mode: Player.SHTypes
    
    @State var buttonClickable: Bool = true
    @State var buttonProgress: Double = 0.0
    @State var buttonIncrement: Double = 100.0
    
    var body: some View {
        ZStack {

            Color("mainWhite")

            VStack {
                VStack(spacing: 0) {
                    Text(mode == .youtube ? "🎥 Youtube" : mode == .music ? "🎶 Music" : mode == .babysitting ? "👩‍🍼 Babysitting" : mode == .art ? "🎨 Art" : mode == .selling ? "🚛 Online Selling" : "🧑‍💻 App Development")
                        .font(.largeTitle)

                    Capsule()
                        .frame(width: .infinity, height: 1)
                        .padding(.top, 8)

                    Spacer()

                    Main

                    Spacer()
                }
                .padding()
                .foregroundColor(Color("mainDarkGray"))
            }
            
            
        }
        .cornerRadius(12)
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
    
    func ModeInfo() -> [Player.SHTypes : [String : String]] {
        return [
            .youtube : ["level" : String(player.sh_youtube),
                        "item"  : "Videos",
                        "count" : String(player.sh_youtube_count)],
            
            .apps     : ["level" : String(player.sh_apps),
                        "item"  : "Apps",
                        "count" : String(player.sh_apps_count)],
            
            .music   : ["level" : String(player.sh_music),
                        "item"  : "Songs",
                        "count" : String(player.sh_music_count)],
            
            .art     : ["level" : String(player.sh_artist),
                        "item"  : "Works",
                        "count" : String(player.sh_artist_count)],
            
            .selling : ["level" : String(player.sh_selling),
                        "item"  : "Products",
                        "count" : String(player.sh_selling_count)],
            
            .babysitting : ["level" : String(player.sh_babysitter),
                        "item"  : "Clients",
                        "count" : String(player.sh_babysitter_count)],
        ]
    }
    
    var Main: some View {
        ZStack {
            if (player.sh_youtube == 0 && player.sh_music == 0 && player.sh_apps == 0 && player.sh_babysitter == 0 && player.sh_selling == 0 && player.sh_artist == 0) {
                VStack(spacing: 0) {
                    Text("No Side Hustles!")
                        .font(.title2)
                    Text("Gary Vee does NOT approve 😾👎")
                        .fontWeight(.light)
                        .italic()
                        .padding()
                    
                    startButton(mode: mode)
                }
            } else {
                VStack {
                    Spacer()

                    VStack {
                        
                        //MULTIPLE STRING INTERPOLATIONS CAUSES SWIFT FRONTEND?!?!
                        HStack(spacing: 0) {
                            Spacer()
                            
                            Text(ModeInfo()[mode]!["count"]! + " " + ModeInfo()[mode]!["item"]!)
                            
                            Spacer()
                            
                            if mode == .youtube {
                                Text(formatNum(player.sh_youtube_income) + "/mo")
                            } else if mode == .music {
                                Text(formatNum(player.sh_music_income) + "/mo")
                            } else if mode == .babysitting {
                                Text(formatNum(player.sh_babysitter_income) + "/mo")
                            } else if mode == .selling {
                                Text(formatNum(player.sh_selling_income) + "/mo")
                            } else if mode == .apps {
                                Text(formatNum(player.sh_apps_income) + "/mo")
                            } else {
                                Text(formatNum(player.sh_artist_income) + "/mo")
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        //workButton()
                        Group {
                            switch mode {
                                case .youtube:
                                    if player.sh_youtube > 0 {
                                        workButton()
                                    } else {
                                        startButton(mode: .youtube)
                                    }
                                case .music:
                                    if player.sh_music > 0 {
                                        workButton()
                                    } else {
                                        startButton(mode: .music)
                                    }
                                case .apps:
                                    if player.sh_apps > 0 {
                                        workButton()
                                    } else {
                                        startButton(mode: .apps)
                                    }
                                case .selling:
                                    if player.sh_selling > 0 {
                                        workButton()
                                    } else {
                                        startButton(mode: .selling)
                                    }
                                case.babysitting:
                                    if player.sh_babysitter > 0 {
                                        workButton()
                                    } else {
                                        startButton(mode: .babysitting)
                                    }
                                case .art:
                                    if player.sh_artist > 0 {
                                        workButton()
                                    } else {
                                        startButton(mode: .art)
                                    }
                            }
                        }
                            .onChange(of: mode) { _ in
                                
                                withAnimation(.linear) {
                                    switch mode {
                                        case .youtube:
                                            buttonProgress = player.sh_youtube_progress
                                        case .babysitting:
                                            buttonProgress = player.sh_babysitter_progress
                                        case .selling:
                                            buttonProgress = player.sh_selling_progress
                                        case .art:
                                            buttonProgress = player.sh_artist_progress
                                        case .music:
                                            buttonProgress = player.sh_music_progress
                                        case .apps:
                                            buttonProgress = player.sh_apps_progress
                                    }

                                }
                                                            }
                    }
                    Spacer()
                }
            }
        }
    }
    
    func startButton(mode: Player.SHTypes) -> some View {
        var returnView = Button(action: {
            
            player.begun_sh = true
            HapticManager.instance.playHaptic(type: .soft)
            
            switch mode {
                case .youtube:
                    player.sh_youtube = 1.0
                case .music:
                    player.sh_music = 1.0
                case .apps:
                    player.sh_apps = 1.0
                case .babysitting:
                    player.sh_babysitter = 1.0
                case .selling:
                    player.sh_selling = 1.0
                case .art:
                    player.sh_artist = 1.0
            }

            
        }, label: {
            ZStack {
                Rectangle()
                    .fill(Color("mainDarkGray"))
                    .cornerRadius(20)
            
                Text("Start")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .aspectRatio(4, contentMode: .fit)
        })
            .buttonStyle(SHWorkButtonStyle())
        
        return returnView
    }
    
    func workButton() -> some View {
        var returnView = Button(action: {
            if buttonClickable {
                withAnimation(.linear) {
                    switch mode {
                        case .youtube:
                            buttonProgress += buttonIncrement
                        case .music:
                            //buttonProgress += (100 / player.shInfo[   .music   ]![.effort]!)
                            buttonProgress += buttonIncrement
                        case .apps:
                            //buttonProgress += (100 / player.shInfo[   .apps    ]![.effort]!)
                            buttonProgress += buttonIncrement
                        case .babysitting:
                            //buttonProgress += (100 / player.shInfo[.babysitting]![.effort]!)
                            buttonProgress += buttonIncrement
                        case .selling:
                            //buttonProgress += (100 / player.shInfo[  .selling  ]![.effort]!)
                            buttonProgress += buttonIncrement
                        case .art:
                            //buttonProgress += (100 / player.shInfo[    .art    ]![.effort]!)
                            buttonProgress += buttonIncrement
                    }
                }

                HapticManager.instance.playHaptic(type: .medium)
                
                player.months_old += 1
            }
        }, label: {
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .fill(Color("mainDarkGray"))
                        .overlay(
                            Rectangle()
                                .fill(userPreferences.appColor)
                                .frame(width: (geometry.size.width / 100) * buttonProgress * 2)
                                .offset(x: 0 - (geometry.size.width / 2))
                        )
                        .cornerRadius(20)
                        .clipped()
                
                    Text("Hustle")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    
                }
                
            }
            .aspectRatio(4, contentMode: .fit)
        })
            .buttonStyle(SHWorkButtonStyle())
            .onChange(of: buttonProgress) { _ in
                if buttonProgress >= 100 {
                    
                    switch mode {
                        case .youtube:
                            player.sh_youtube_count += 1
                            player.updateSHProgress(mode: .youtube)
                        case .babysitting:
                            player.updateSHProgress(mode: .babysitting)
                            player.sh_babysitter_count += 1
                        case .selling:
                            player.updateSHProgress(mode: .selling)
                            player.sh_selling_count += 1
                        case .art:
                            player.updateSHProgress(mode: .art)
                            player.sh_artist_count += 1
                        case .music:
                            player.updateSHProgress(mode: .music)
                            player.sh_music_count += 1
                        case .apps:
                            player.updateSHProgress(mode: .apps)
                            player.sh_apps_count += 1
                    }

                    UpdateButtonIncrement()

                    buttonClickable = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.spring()) {
                            buttonProgress = 0
                        }
                        buttonClickable = true
                    }
                }
                
                if buttonProgress < 0 {
                    buttonProgress = 0.0
                }
                
                switch mode {
                    case .youtube:
                        player.sh_youtube_progress = buttonProgress
                    case .babysitting:
                        player.sh_babysitter_progress = buttonProgress
                    case .selling:
                        player.sh_selling_progress = buttonProgress
                    case .art:
                        player.sh_artist_progress = buttonProgress
                    case .music:
                        player.sh_music_progress = buttonProgress
                    case .apps:
                        player.sh_apps_progress = buttonProgress
                }
            }
        
        return returnView
    }
    
    func UpdateButtonIncrement() {
        //.effort : sh_youtube == 0.0 ? 1.0 : Double(shEfforts[.youtube]![Int(sh_youtube) - 1]),
        
        switch mode {
            case .youtube:
                buttonIncrement = 100 / Double(player.shEfforts[.youtube]![Int(player.sh_youtube) - 1])
            case .babysitting:
                buttonIncrement = 100 / Double(player.shEfforts[.babysitting]![Int(player.sh_babysitter) - 1])
            case .selling:
                buttonIncrement = 100 / Double(player.shEfforts[.selling]![Int(player.sh_selling) - 1])
            case .art:
                buttonIncrement = 100 / Double(player.shEfforts[.art]![Int(player.sh_artist) - 1])
            case .music:
                buttonIncrement = 100 / Double(player.shEfforts[.music]![Int(player.sh_music) - 1])
            case .apps:
                buttonIncrement = 100 / Double(player.shEfforts[.apps]![Int(player.sh_apps) - 1])
        }
    }
}

struct SHDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SHDetail(mode: .constant(Player.SHTypes.youtube))
                .environmentObject(Player())
            .environmentObject(UserPreferences())
            SHDetail(mode: .constant(Player.SHTypes.youtube))
                .environmentObject(Player())
                .environmentObject(UserPreferences())
        }
    }
}
