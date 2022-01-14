//
//  CasinoIcon.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/5/22.
//

import SwiftUI

struct CasinoIcon: View {
    var body: some View {
        ZStack {
            iconBackground
            
            iconForeground
        }
    }
    
    var iconForeground: some View {
        VStack {
            Text("Casino")
                .foregroundColor(.white)
                .font(Font.system(size: 64))
                .fontWeight(.medium)
        }
    }
    
    var iconBackground: some View {
        RoundedRectangle(cornerRadius: 72)
            .fill(
                LinearGradient(
                    colors: [Color(red: 220/255, green: 25/255, blue: 18/255),
                             Color(red: 220/255, green: 107/255, blue: 30/255)],
                    startPoint: .topLeading,
                    endPoint: .bottom)
            )
            .aspectRatio(3/2, contentMode: .fit)
            .padding()
    }
}

struct CasinoIcon_Previews: PreviewProvider {
    static var previews: some View {
        CasinoIcon()
    }
}
