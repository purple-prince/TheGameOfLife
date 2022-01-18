//
//  CasinoView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/5/22.
//

import SwiftUI

struct CasinoView: View {
    
    @Binding var showCasinoView: Bool
    @Binding var showMainView: Bool
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    @State var showLotteryPopup = false
    
    var body: some View {
        ZStack {
            userPreferences.appColor.ignoresSafeArea()
            
            VStack {
                
                header
                
                Spacer()
                
                Text("LOTTERY?!")
                    .foregroundColor(Color.white)
                    .padding()
                    .padding()
                    .background(Color.gray)
                    .onTapGesture {
                        showLotteryPopup = true
                    }
            }
            
            if showLotteryPopup {
                LotteryPopup(showLotteryPopup: $showLotteryPopup)
            }
        }
    }
}

extension CasinoView {
    var header: some View {
        HStack {
            Image(systemName: "chevron.backward")
                .foregroundColor(.white)
                .font(.largeTitle)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct CasinoView_Previews: PreviewProvider {
    static var previews: some View {
        CasinoView(showCasinoView: .constant(false), showMainView: .constant(false))
            .environmentObject(UserPreferences())
    }
}
