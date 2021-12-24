//
//  ExperimentView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/21/21.
//

import SwiftUI



struct ExperimentView: View {
    
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            ForEach(list) { thing in
                elview()
            }
        }
    }
}


struct elview: View {
    
    @State var offsetX: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    var body: some View {
        Text("yo")
            .padding(120)
            .background(Color.red)
            .offset(x: offsetX, y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offsetX = value.translation.width
                        offsetY = value.translation.height
                    }
                    
                    .onEnded { value in
                        withAnimation(.spring()) {
                            
                            offsetY = 0
                            
                            if abs(offsetX) < 120 {
                                offsetX = 0
                            } else {
                                if offsetX > 0 {
                                    offsetX = 400
                                } else {
                                    offsetX = -400
                                }
                                //index += 1
                            }
                        }
                    }
            )
    }
}

struct test: Identifiable {
    var id: UUID = UUID()
    var name: String
    var color: Color
}

var list = [
    test(name: "one", color: Color.red),
    test(name: "two", color: Color.green),
    test(name: "three", color: Color.blue),
    test(name: "four", color: Color.purple)
]

struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}



/*
 struct ExperimentView: View {
     
     @State var h = struct1()
     
     var body: some View {
         VStack {
             Button(action: {
                 h.num += 1
             }, label: {
                 Text("CLICK ME")
                     .padding()
                 
             })
             Text(String(h.num))
         }
     }
 }

 struct struct1 {
     var num = 1
 }
 */
