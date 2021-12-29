//
//  ExperimentView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/21/21.
//

import SwiftUI



struct ExperimentView: View {
    
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"
    
    var body: some View {
        VStack {
            Picker("Please choose a color", selection: $selectedColor) {
                ForEach(colors, id: \.self) { color in
                    Text(".      .")
                        .foregroundColor(Color.red)
                        //.colorMultiply(Color.red)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Text("You selected: \(selectedColor)")
        }
    }
}

struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
