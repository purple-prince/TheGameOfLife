//
//  RealEstateView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 4/5/22.
//

import SwiftUI

struct RealEstateView: View {
    
    @EnvironmentObject var player: Player
    
    @Binding var showOccupationMain: Bool
    @Binding var pShowRealEstateView: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RealEstateView_Previews: PreviewProvider {
    static var previews: some View {
        RealEstateView(showOccupationMain: .constant(false), pShowRealEstateView: .constant(true))
            .environmentObject(Player())
    }
}
