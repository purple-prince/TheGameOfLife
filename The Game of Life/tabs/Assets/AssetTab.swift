//
//  AssetTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

struct AssetTab: View {

    @State var showAssetsMain:       Bool = true
    @State var showBankDetail:       Bool = false
    @State var showRealEstateDetail: Bool = false
    @State var showCasinoView:       Bool = false
    @State var showStockMarketView:  Bool = false

    //BLEND MODE FOR BLUR OVERLAP

    var body: some View {
        
        ZStack {
            if showAssetsMain {
                AssetsMain(showAssetsMain: $showAssetsMain, showBankDetail: $showBankDetail, showRealEstateDetail: $showRealEstateDetail, showCasinoView: $showCasinoView, showStockMarketView: $showStockMarketView)
            }
            if showBankDetail {
                BankDetail(showAssetsMain: $showAssetsMain, showBankDetail: $showBankDetail)
                    .transition(.scale)
                    .frame(width: .infinity, height: .infinity)
                    .background(Color("mainWhite"))
            }
            if showRealEstateDetail {
                RealEstateDetail(showAssetsMain: $showAssetsMain, showRealEstateDetail: $showRealEstateDetail)
                    .transition(.scale)
                    .frame(width: .infinity, height: .infinity)
                    .background(Color("mainWhite"))
            }
            if showCasinoView {
                CasinoView(showCasinoView: $showCasinoView, showMainView: $showAssetsMain)
                    .frame(width: .infinity, height: .infinity)
                    .background(Color("mainWhite"))
            }
            if showStockMarketView {
                StockMarketView(showStockMarketView: $showStockMarketView, showAssetsMain: $showAssetsMain)
                    .frame(width: .infinity, height: .infinity)
                    .background(Color("mainWhite"))
            }
            
        }
    }
}

struct AssetTab_Previews: PreviewProvider {
    static var previews: some View {
        AssetTab()
            .environmentObject(Player())
            .environmentObject(UserPreferences())
    }
}

