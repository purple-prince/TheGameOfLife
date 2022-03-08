//
//  FoodShop.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 2/27/22.
//

import SwiftUI

struct FoodShopButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .brightness(configuration.isPressed ? 0.05 : 0)
    }
}

struct FoodShop: View {
    
    @EnvironmentObject var player: Player
    
    @Binding var showFoodView: Bool
    @Binding var showStoreView: Bool
    
    var body: some View {
        ZStack {
            Color("mainWhite").ignoresSafeArea()
            
            VStack {
                Title
                
                ScrollView {
                    
                    VStack(spacing: 0) {
                        
                        VStack(spacing: 0) {
                            CategoryRow(Meal.veganMeal)
                            
                            CategoryRow(Meal.vegetarianMeal)
                            
                            CategoryRow(Meal.averageMeal)
                            
                            CategoryRow(Meal.americaMeal)
                            
                            CategoryRow(Meal.fastfoodMeal)
                            
                            CategoryRow(Meal.poopMeal)
                        }
                        
                        VStack(spacing: 0) {
                        }
                    }
                }
            }
            
            BackButton
        }
    }
    
    var Title: some View {
        VStack(spacing: 8) {
            Text("Food")
                .font(.largeTitle)
            
            Capsule()
                .frame(width: .infinity, height: 2)
        }
        .padding(.horizontal)
        .foregroundColor(Color("mainDarkGray"))
    }
    
    func CategoryRow(_ meal: Meal) -> some View {
        
        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(meal.emoji)
                    .font(Font.system(size: 60))
                    .padding(.trailing, 12)
                
                VStack(alignment: .leading) {
                    Text(meal.title)
                        .fontWeight(.thin)
                        .lineLimit(1)
                        .font(Font.system(size: 32))
                    
                    HStack {
                        if let mod = meal.healthMod {
                            HStack(spacing: 0) {
                                Text((mod > 0 ? "+" : "") + String(mod))
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundColor(mod > 0 ? .green : .red)
                                Text(" ❤️")
                                    .font(.callout)
                            }
                        }
                        if let mod = meal.energyMod {
                            HStack(spacing: 0) {
                                Text((mod > 0 ? "+" : "") + String(mod))
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundColor(mod > 0 ? .green : .red)
                                Text(" ⚡️")
                                    .font(.callout)
                            }
                        }
                        
                        Text("- " + formatNum(meal.price))
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
                         
                Spacer()
                
                Button(action: {
                    if player.life_cash_balance >= meal.price {
                        HapticManager.instance.playHaptic(type: .medium)
                        
                        player.life_cash_balance -= meal.price
                        
                        switch meal.title {
                            case "Vegan Meal":
                                player.vegan_meals += 1
                            case "Vegetarian Meal":
                                player.vegetarian_meals += 1
                            case "Average Meal":
                                player.average_meals += 1
                            case "America Meal":
                                player.america_meals += 1
                            case "Fast Food Meal":
                                player.fastfood_meals += 1
                            case "Poop Meal":
                                player.poop_meals += 1
                            default:
                                player.vegan_meals += 1
                        }
                        
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color("mainDarkGray"))
                        
                        Text("Buy")
                            .foregroundColor(.white)
                    }
                    .aspectRatio(3/2, contentMode: .fit)
                    .frame(width: 74)
                }).buttonStyle(FoodShopButtonStyle())
                
                
            }
            .padding(8)
            
            
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
                    .padding(.horizontal)
                    .onTapGesture {
                        showStoreView = true
                        showFoodView = false
                    }
                Spacer()
            }
            Spacer()
        }
    }
}

struct Meal {
    
    static let veganMeal: Meal      = Meal(emoji: "🥗", title: "Vegan Meal",      healthMod: 2,   energyMod: 4, price: 1_200 )
    static let vegetarianMeal: Meal = Meal(emoji: "🥙", title: "Vegetarian Meal", healthMod: 1,   energyMod: 4, price: 1_000 )
    static let averageMeal: Meal    = Meal(emoji: "🌮", title: "Average Meal",    healthMod: 1,   energyMod: 6, price: 800   )
    static let americaMeal: Meal    = Meal(emoji: "🌭", title: "America Meal",    healthMod: nil, energyMod: 5, price: 600   )
    static let fastfoodMeal: Meal   = Meal(emoji: "🍟", title: "Fast Food Meal",  healthMod: -1,  energyMod: 3, price: 400   )
    static let poopMeal: Meal       = Meal(emoji: "💩", title: "Poop Meal",       healthMod: -2,  energyMod: 1, price: 200   )
    
    let title: String
    let emoji: String
    let healthMod: Int?
    let energyMod: Int?
    let price: Int
    
    init(emoji: String, title: String, healthMod: Int?, energyMod: Int?, price: Int) {
        self.title = title
        self.healthMod = healthMod
        self.energyMod = energyMod
        self.price = price
        self.emoji = emoji
    }
}

struct FoodShop_Previews: PreviewProvider {
    static var previews: some View {
        FoodShop(showFoodView: .constant(true), showStoreView: .constant(false))
            .environmentObject(Player())
    }
}
