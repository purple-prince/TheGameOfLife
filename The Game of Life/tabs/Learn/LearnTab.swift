//
//  LearnTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/10/22.
//

import SwiftUI

struct LearnTab: View {
    
    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var player: Player
    
    @State var showLearnTab: Bool = true
    @State var showEducationView: Bool = false
    
}

//BODY
extension LearnTab {
    var body: some View {
        ZStack {
            Color("mainWhite").ignoresSafeArea()
            
            if showLearnTab { main }
            if showEducationView { EducationView(showLearnTab: $showLearnTab, showEducationView: $showEducationView) }
        }
    }
}

extension LearnTab {
    var EducationIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("mainDarkGray"))
            
            VStack {
                Text("Education")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .font(Font.system(size: 48))
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("🤓")
                    Spacer()
                    Text("📚")
                    Spacer()
                    Text("🎓")
                    Spacer()
                }
                .font(Font.system(size: 70))
                
                Spacer()
            }
            .padding(.vertical)
        }
        .aspectRatio(3/2, contentMode: .fit)
        .padding()
        .onTapGesture {
            showEducationView = true
            showLearnTab = false
        }
    }
    
    var main: some View {
        ScrollView {
            VStack {
                EducationIcon
            }
        }
    }
}

struct LearnTab_Previews: PreviewProvider {
    static var previews: some View {
        LearnTab()
            .environmentObject(UserPreferences())
            .environmentObject(Player())
    }
}
