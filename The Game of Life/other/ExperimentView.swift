//
//  ExperimentView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/21/21.
//

import SwiftUI

struct ExperimentView: View {
    
    @State var x: CGFloat = 0
    
    var body: some View {
        Circle()
            .frame(width: 100, height: 100)
            .offset(x: x)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        x = value.translation.width
                    }
                    .onEnded { value in
                        
                        withAnimation(.linear) {
                        
                            if value.translation.width < -100 {
                                x = -250
                            } else {
                                x = 0
                            }
                        }
                    }
            )
    }
}


struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
