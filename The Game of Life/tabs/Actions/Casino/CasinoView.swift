//
//  CasinoView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/5/22.
//

import SwiftUI

struct CasinoView: View, ActionView {
    
    @Binding var showCasinoView: Bool
    @Binding var showMainView: Bool
    
    @AppStorage("app_color_index") var colorCount: Int = 0

    var appColor: Color {
        colorOptions[colorCount]
    }
    
    @State var showLotteryPopup = false
    
    var body: some View {
        ZStack {
            appColor.ignoresSafeArea()
            
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
    }
}
