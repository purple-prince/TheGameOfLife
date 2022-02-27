//
//  ShopView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 2/12/22.
//

import SwiftUI

struct ShopView: View {
    
    @Binding var showShop: Bool
    
    let productList: [Product] = [
        Product(type: .purchase, title: "God Mode", price: 2.99),
        Product(type: .purchase, title: "No Ads", price: 0.99),
        Product(type: .ad, title: "$100k", price: nil)
    ]
    
    var body: some View {
        ZStack {
            Color("mainWhite").ignoresSafeArea()
            
            VStack {
                Header
                                
                ItemList
                
                Spacer()

            }
            
        }
    }
    
    var ItemList: some View {
        ScrollView {
            ForEach(productList) { product in
                HStack {
                    
                    /*RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 1)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 72)*/
                    Text("🎪")
                        .font(Font.system(size: 72))
                    
                    Text(product.title)
                        .fontWeight(.light)
                        .font(.largeTitle)

                    Spacer()
                    
                    if let price = product.price {
                        Text("$" + String(price))
                            .fontWeight(.thin)
                            .font(.title)

                    }
                }
            }
        }
        .padding()
    }
    
    var Header: some View {
        ZStack {
            VStack(spacing: 8) {
                Text("Shop")
                    .fontWeight(.light)
                    .font(Font.system(size: 40))
                    .foregroundColor(Color("mainDarkGray"))
                
                Capsule()
                    .frame(width: .infinity, height: 1)
                    .foregroundColor(Color("mainDarkGray"))
            }
            .padding()
            
            VStack {
                HStack {
                    Image(systemName: "chevron.backward")
                        .font(Font.system(size: 32))
                        .foregroundColor(.red)
                        .onTapGesture {
                            showShop = false
                        }
                    
                    Spacer()
                }
                .padding()
                
                
            }
        }
    }
}

class Product: Identifiable {
    
    init(type: Types, title: String, price: Double?) {
        self.type = type
        self.title = title
        self.price = price
    }
    
    enum Types {
        case ad, purchase
    }
    
    var id: UUID = UUID()
    let type: Types
    let price: Double?
    let title: String
    
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView(showShop: .constant(true))
    }
}
