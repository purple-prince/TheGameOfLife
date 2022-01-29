//
//  ParentsView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct ParentsView: View {
    
    @State var showMomDetail: Bool = false
    @State var showDadDetail: Bool = false
    @State var showParentsView2: Bool = true
    
    @Binding var showMainView: Bool
    @Binding var showParentsView: Bool
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
        
    var body: some View {
                
        ZStack {
            
            Color("mainWhite")
            
            if showParentsView2 {
                VStack {
                        
                        BackButton
                        
                        banner

                        Divider()

                        VStack {
                            MomLink
                            DadLink
                        }
                        Spacer()
                }
            }
            
            if showMomDetail {
                ParentsDetail(mode: .mom, showMomDetail: $showMomDetail, showDadDetail: $showDadDetail, showParentsView2: $showParentsView2)
            }
            
            if showDadDetail {
                ParentsDetail(mode: .dad, showMomDetail: $showMomDetail, showDadDetail: $showDadDetail, showParentsView2: $showParentsView2)
            }
        }
    }
}

extension ParentsView {
    var banner: some View {
        VStack /*current job*/ {
            Spacer()
            
            Text("Parents")
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
                    showParentsView = false
                    showMainView = true
                }
            Spacer()
        }
    }
    
    var MomLink: some View {
        //ParentsDetail(mode: .mom)
        HStack {
            Text(player.mom_emoji + " " + player.mom_name)
            Spacer()
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 100, height: 12)
                    .foregroundColor(Color.gray)

                RoundedRectangle(cornerRadius: 12)
                    .frame(width: CGFloat(player.mom_status), height: 12)
                    .foregroundColor(userPreferences.appColor)
            }
        }
        .padding()
        .font(.system(size: 20))
        .foregroundColor(.black)
        .onTapGesture {
            withAnimation(.easeInOut) {
                showMomDetail = true
                showParentsView2 = false
            }
        }
    }
    
    var DadLink: some View {
        //ParentsDetail(mode: .dad)
        HStack {
            Text(player.dad_emoji + " " + player.dad_name)
            Spacer()
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 120, height: 12)
                    .foregroundColor(Color.gray)

                RoundedRectangle(cornerRadius: 12)
                    .frame(width: CGFloat(player.dad_status), height: 12)
                    .foregroundColor(userPreferences.appColor)
            }
        }
        .padding()
        .font(.system(size: 20))
        .foregroundColor(.black)
        .onTapGesture {
            withAnimation(.easeInOut) {
                showDadDetail = true
                showParentsView2 = false
            }
        }
    }
}

struct ParentsView_Previews: PreviewProvider {
    static var previews: some View {
        ParentsView(showMainView: .constant(true), showParentsView: .constant(true))
            .environmentObject(Player())
            .environmentObject(UserPreferences())
    }
}
