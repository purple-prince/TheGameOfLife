//
//  AssetTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

struct AssetTab: View {
    
    @State var showAssetsMain = true
    @State var showBankDetail = false
    @State var showRealEstateDetail = false
    @State var showCasinoView = false

    //BLEND MODE FOR BLUR OVERLAP

    var body: some View {
        
        ZStack {
            if showAssetsMain {
                AssetsMain(showAssetsMain: $showAssetsMain, showBankDetail: $showBankDetail, showRealEstateDetail: $showRealEstateDetail, showCasinoView: $showCasinoView)
            }
            if showBankDetail {
                BankDetail(showAssetsMain: $showAssetsMain, showBankDetail: $showBankDetail)
                    .transition(.scale)
            }
            if showRealEstateDetail {
                RealEstateDetail(showAssetsMain: $showAssetsMain, showRealEstateDetail: $showRealEstateDetail)
                    .transition(.scale)
            }
            if showCasinoView {
                CasinoView(showCasinoView: $showCasinoView, showMainView: $showAssetsMain)
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

