//
//  ExperimentView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/21/21.
//

import SwiftUI

struct ExperimentView: View {
    
    //@StateObject var test: Testt = Testt()
    @State var clicked: Bool = false
    @ObservedObject var counter: TestClass = TestClass()
    
    var body: some View {
//        VStack {
//            myShape(t: test)
//                .stroke(Color.red, lineWidth: 40)
//            Button(action: {test.count += 1}, label: {Text("Click me")})
//        }
        
        ZStack {
            MyShape(counter: counter)
                .stroke(Color.red, lineWidth: 200)
                .onTapGesture {
                    counter.count += 1
                }
            Text(String(counter.count))
        }
        
    }
}

class TestClass: ObservableObject {
    @Published var count = 0
}

struct MyShape: Shape {
    
    var counter: TestClass
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 100 + (counter.count * 10), y: 100 + (counter.count * 10)))
        return path
    }
}

//class Testt: ObservableObject {
//    var count: Int = 0 {
//        didSet {
//            value += 3
//        }
//    }
//    @Published var value: Int = 0
//
//}

//struct myShape: Shape {
//
//    var t: Testt
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: CGPoint(x: rect.midX - 100, y: rect.midY - CGFloat(t.value)))
//        path.addLine(to: CGPoint(x: rect.midX + 100, y: rect.midY - CGFloat(t.value)))
//
//        return path
//    }
//}


struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
