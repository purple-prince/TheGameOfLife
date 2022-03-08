//
//  StoreView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 2/27/22.
//

import SwiftUI

struct StoreView: View {
    
    @State var showStoreView: Bool = true
    @State var showFoodView: Bool = false
    
    @Binding var showMainView: Bool
    @Binding var showStoreViewBinding: Bool
    
    @EnvironmentObject var player: Player
    
    enum Category {
        case food
    }
    
    var body: some View {
        ZStack {
            Color("mainWhite").ignoresSafeArea()
            
            if showStoreView {
                ZStack {
                    VStack {
                        Title
                        
                        ScrollView {
                            
                            VStack {
                                CategoryRow(emoji: "🍎", title: "Food")
                                    .onTapGesture {
                                        showFoodView = true
                                        showStoreView = false
                                    }
                            }
                        }
                    }
                    
                    BackButton
                }
            }
            
            if showFoodView {
                FoodShop(showFoodView: $showFoodView, showStoreView: $showStoreView)
            }
        }
    }
    
    var Title: some View {
        VStack(spacing: 8) {
            Text("The Everything Shop")
                .font(.largeTitle)
            
            Capsule()
                .frame(width: .infinity, height: 2)
        }
        .padding(.horizontal)
        .foregroundColor(Color("mainDarkGray"))
    }
    
    func CategoryRow(emoji: String, title: String) -> some View {
        
        @State var owned = player.poop_meals + player.fastfood_meals + player.vegan_meals + player.vegetarian_meals + player.average_meals + player.america_meals
        
        return VStack(spacing: 8) {
            HStack(spacing: 40) {
                Text(emoji)
                    .font(Font.system(size: 60))
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(Font.system(size: 48))
                        .fontWeight(.thin)
                    
                    Text("\(owned) owned")
                        .fontWeight(.thin)
                }
                
                Spacer()
            }
            
            Capsule()
                .foregroundColor(Color("mainDarkGray"))
                .frame(width: .infinity, height: 1)
                .padding(.horizontal)
                .padding(.horizontal)
        }
    }
    
    var BackButton: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color("mainDarkGray"))
                    .font(Font.system(size: 32))
                    .padding(.top, 8)
                    .padding(.horizontal, 8)
                    .onTapGesture {
                        showMainView = true
                        showStoreViewBinding = false
                    }
                Spacer()
            }
            Spacer()
        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(showMainView: .constant(false), showStoreViewBinding: .constant(true))
            .environmentObject(Player())
    }
}
