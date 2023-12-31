//
//  ExperimentView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/21/21.
//

import SwiftUI

struct ExperimentView: View {
    
    @State var cha = false
    
    var body: some View {

        ZStack (alignment: .leading) {

            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("mainDarkGray"), lineWidth: 4)
                .shadow(radius: 10)

            Rectangle()
                .fill(Color.pink)
                .frame(width: 0, height: 100)
                .clipped()


        }
        .clipShape(RoundedRectangle(cornerRadius: 16))       // << here !!
        .frame(width: 300, height: 100)
    }
}

struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
