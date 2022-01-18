//
//  ParentsView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct ParentsView: View {
    
    @Binding var showMainView: Bool
    @Binding var showParentsView: Bool
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
        
    var body: some View {
                
        NavigationView {
            VStack {
                banner

                Divider()

                VStack {

                    NavigationLink(destination: {
                        ParentsDetail(mode: .mom)
                    }, label:{
                        HStack {
                            Text(player.mom_emoji + " " + player.mom_name)
                            Spacer()
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 120, height: 12)
                                    .foregroundColor(Color.gray)

                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: CGFloat(player.mom_status), height: 12)
                                    .foregroundColor(userPreferences.appColor)
                            }
                        }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    })

                    NavigationLink(destination: {ParentsDetail(mode: .dad)}, label: {
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
                    })
                }
                Spacer()
            }
            .offset(y: 72)
            .ignoresSafeArea()
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
}

struct ParentsView_Previews: PreviewProvider {
    static var previews: some View {
        ParentsView(showMainView: .constant(true), showParentsView: .constant(true))
            .environmentObject(Player())
            .environmentObject(UserPreferences())
    }
}
