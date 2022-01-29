//
//  ExperimentView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/21/21.
//

import SwiftUI

struct ExperimentView: View {
    
    var body: some View {
        
        VStack {
            Spacer()
            elShape()
                .stroke(lineWidth: 4)
            Spacer()
        }
    }
    
    
}


struct elShape: Shape {
    
    
    
//    var animatableData: CGFloat {
//        get {
//            
//        }
//        set {
//            
//        }
//    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX + 10, y: rect.midY),
                        radius: 10.0,
                        startAngle: Angle(degrees:180),
                        endAngle: Angle(degrees:0),
                        clockwise: false)
            path.move(to: CGPoint(x: rect.midX + 20, y: rect.midY - 3))
            path.addQuadCurve(to: CGPoint(x: rect.midX + 50, y: rect.midY + 8),
                              control: CGPoint(x: rect.midX + 20, y: rect.midY + 10))
            //path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            
        }
    }
}


struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
