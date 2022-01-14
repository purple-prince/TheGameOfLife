//
//  NewLifeView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/11/22.
//

import SwiftUI

struct NewLifeView: View {
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
    //@Binding var showMainView: Bool
    //@Binding var showLivesView: Bool
    @AppStorage("entered") var entered = false
    
    @State var off: CGFloat = 0
    @State var clicked = false
    
    var body: some View {
        ZStack {
            
            Color("mainWhite").ignoresSafeArea()
            
            VStack {
                
                if entered {
                    Text("You Died!")
                        .foregroundColor(Color("mainDarkGray"))
                        .font(Font.system(size: 72))
                        .fontWeight(.medium)
                        .padding()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.gray)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 4 / 5, height: UIScreen.main.bounds.height / 6)
                        .blur(radius: 12)
                        .offset(x: 0, y: 12)
                   
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(userPreferences.appColor)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 4 / 5, height: UIScreen.main.bounds.height / 6)
                    
                    Text("New Life")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        player.on_new_life = false
                        player.reset()
                        entered = true
                    }
                }
            }
        }
    }
}

struct NewLifeView_Previews: PreviewProvider {
    static var previews: some View {
        NewLifeView(/*showMainView: .constant(false), showLivesView: .constant(true)*/)
            .environmentObject(UserPreferences())
    }
}
