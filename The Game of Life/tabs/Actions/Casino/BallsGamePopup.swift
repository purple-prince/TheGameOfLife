//
//  BallsGamePopup.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/9/22.
//

import SwiftUI

struct BallsGamePopup: View {
    
    var numPegs: [[String]] = [["*"],
                               ["*", "*"],
                               ["*", "*", "*"],
                               [ "*", "*", "*", "*"],
                               [ "*", "*", "*", "*", "*"],
                               [ "*", "*", "*", "*", "*", "*"],
                               [ "*", "*", "*", "*", "*", "*", "*"]]
    
    var body: some View {
        ZStack {
            gameFrame
        }
    }
}

extension BallsGamePopup {
    
    func dropBall() -> Void {
        
    }
    
    var gameFrame: some View {
        ZStack {
            Color("mainDarkGray")
            VStack(spacing: 0) {
                Text("Balla Droppa")
                    .foregroundColor(.white)
                    .bold()
                    .underline(color: .red)
                    .font(Font.system(size: 50))
                    .padding(.top)
                    .onTapGesture {
                        dropBall()
                    }
                Spacer()
                pegArray
                boxes
                    .padding(.bottom)
            }
        }
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: 500)
        .padding()
    }
    
    var pegArray: some View {
        VStack {
            ForEach(numPegs, id: \.self) { num in
                HStack {
                    ForEach(num, id: \.self) { peg in
                        Circle()
                            .frame(width: 10.0, height: 10.0)
                            .foregroundColor(.white)
                            .padding(.vertical, 16.0)
                            .padding(.horizontal, 14.0)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 330)
        //.padding()
    }
    
    var boxes: some View {
        HStack(spacing: 7) {
            box(score: 5.0, color: Color.red)
            
            box(score: 2.0, color: Color.red)
            
            box(score: 1.0, color: Color.orange)
            
            box(score: 0.5, color: Color.yellow)
            box(score: 0.5, color: Color.yellow)
            
            box(score: 1.0, color: Color.orange)
            
            box(score: 2.0, color: Color.red)
            
            box(score: 5.0, color: Color.red)
        }
    }
    
    func box(score: Double, color: Color) -> some View {
        Text(String(score) + "x")
            .font(.caption)
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(color)
                    //.frame(maxWidth: 40, maxHeight: 20)
            )
    }
}

struct BallsGamePopup_Previews: PreviewProvider {
    static var previews: some View {
        BallsGamePopup()
    }
}
