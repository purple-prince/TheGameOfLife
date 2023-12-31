//
//  SportsView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 4/3/22.
//

import SwiftUI
import CoreGraphics

class Sport:Identifiable {
    
    static public let Soccer    : Sport = Sport(emoji: "⚽️", title: "Soccer", leagueName: "MLS", mode: .soccer)
    static public let Football  : Sport = Sport(emoji: "🏈", title: "Football", leagueName: "NFL", mode: .football)
    static public let Basketball: Sport = Sport(emoji: "🏀", title: "Basketball", leagueName: "NBA", mode: .basketball)
    static public let Hockey    : Sport = Sport(emoji: "🏒", title: "Hockey", leagueName: "NHL", mode: .hockey)
    static public let Baseball  : Sport = Sport(emoji: "⚾️", title: "Baseball", leagueName: "MLB", mode: .baseball)
    
    init(emoji: String, title: String, leagueName: String, mode: SportsView.SportModes) {
        self.emoji = emoji
        self.title = title
        self.leagues = ["Casual", "Travel", "High School", "College", "Minors", leagueName]
        self.mode = mode
    }
    
    var emoji: String
    var title: String
    var level: Int = 0
    let leagues: [String]
    var mode: SportsView.SportModes
    var id: UUID = UUID()
}

struct SportsView: View {
    
    public enum SportModes {
        case baseball, hockey, soccer, basketball, football
    }
    
    @Binding var showOccupationMain: Bool
    @Binding var pShowSportsView: Bool
    
    @State var showSportsView: Bool = true
    @State var showSportDetail: Bool = false
    @State var mode: SportModes? = nil
    
    let sportsList: [Sport] = [Sport.Soccer, Sport.Football, Sport.Basketball, Sport.Hockey, Sport.Baseball]
    
    var body: some View {
        ZStack {
            
            Color("mainWhite").ignoresSafeArea()
            
            if showSportsView {
                Main
                
                Color("mainWhite").frame(width: .infinity, height: 10)
                    .offset(x: 0, y: 350)
                
                BackButton
            }
            if showSportDetail {
                SportDetail(showSportsView: $showSportsView, showSportDetail: $showSportDetail, mode: mode!)
            }
        }
    }
}

extension SportsView {
    
    var Main: some View {
        VStack(spacing: 20) {
            Title("Sports")
            
            ForEach(sportsList) { sport in
                VStack(spacing: 20) {
                    
                    HStack {
                        Text(sport.emoji)
                            .font(Font.system(size: 80))
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text(sport.title)
                                .fontWeight(.medium)
                                .font(.title)
                                                        
                            if true {//sport.level > 0 {
                                Text("League: " + sport.leagues[sport.level])
                            }
                        }
                        
                        Spacer()
                    }
                    DottedLine()
                        .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [12], dashPhase: 6))
                        .frame(height: 1)
                    
                    
                }
                .foregroundColor(Color("mainDarkGray"))
                .onTapGesture {
                    mode = sport.mode
                    showSportDetail = true
                    showSportsView = false
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.vertical)
    }
    
    var BackButton: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .font(Font.system(size: 40))
                    .foregroundColor(.red)
                    .onTapGesture {
                        showOccupationMain = true
                        pShowSportsView = false
                    }
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct SportsView_Previews: PreviewProvider {
    static var previews: some View {
        SportsView(showOccupationMain: .constant(false), pShowSportsView: .constant(true))
    }
}
