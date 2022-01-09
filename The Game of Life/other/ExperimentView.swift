//
//  ExperimentView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/21/21.
//

import SwiftUI



struct ExperimentView: View {
    
    var body: some View {
        RadialGradient(colors: [Color.red, Color.black], center: .center, startRadius: 10, endRadius: 150)
            .frame(width: 300, height: 300)
    }
}



/*
 1)
 2)
 3)
 4)
 5)
 6)
 7)
 */


struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
