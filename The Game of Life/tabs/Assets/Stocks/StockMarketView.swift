//
//  StockMarketView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 3/15/22.
//

import SwiftUI

struct StockMarketView: View {
    
    @Binding var showStockMarketView: Bool
    @Binding var showAssetsMain: Bool
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var userPreferences: UserPreferences
    
    @State var buyMode: Bool = true
    @State var amountPercent: Double = 0.0
    @State var increaseAmountTextSize: Bool = false
    
    var canBuy: Bool { player.life_cash_balance > 0 }
    var canSell: Bool { player.stock_position_value > 0 }
    
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Title("Stonk Market")
                
                Text("Current Holdings: " + formatNum(player.stock_position_value))
                    .font(.title2)
                    .padding(.top, 8)
                                
                StockMarketViewGraph()
                    .padding()
                
                Buttons
                
                if (buyMode && canBuy) || (!buyMode && canSell) {
                    AmountPicker
                }
                
                Spacer()
                
                if (buyMode && canBuy) || (!buyMode && canSell) {
                    ConfirmButton
                } else if !buyMode && !canSell {
                    Text("Stockless... 🤔")
                        .font(.title)
                }
                Spacer()
                
            }
            
            BackButton
        }
    }
    
//    struct ConfirmStockButtonStyle: ButtonStyle {
//        func makeBody(configuration: Configuration) -> some View {
//            configuration.label
//                .offset(x: 0, y: configuration.isPressed ? 1 : 0)
//        }
//    }
    
    var ConfirmButton: some View {
        Button(action: {
            if buyMode {
                player.life_cash_balance -= Int(amountPercent)
                player.stock_position_value += Int(amountPercent)
            } else {
                player.life_cash_balance += Int(amountPercent)
                player.stock_position_value -= Int(amountPercent)
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(userPreferences.appColor, lineWidth: 2)
                    .aspectRatio(7/4, contentMode: .fit)
                    .frame(width: 112)
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color("mainDarkGray"))
                    .aspectRatio(7/4, contentMode: .fit)
                    .frame(width: 110)
                    .shadow(color: .gray, radius: 10, x: 0, y: 10)
                Text("Confirm")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        })
            //.buttonStyle(ConfirmStockButtonStyle())
    }
    
    var BackButton: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.red)
                    .font(Font.system(size: 32))
                    .onTapGesture {
                        showStockMarketView = false
                        showAssetsMain = true
                    }
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    /*
     RoundedRectangle(cornerRadius: 12)
         .foregroundColor(Color("mainDarkGray"))
         .aspectRatio(5/3, contentMode: .fit)
         .frame(width: 100)
     */
    
    var Buttons: some View {
        
        ZStack {
            
            HStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color("mainDarkGray"))
                    .aspectRatio(7/4, contentMode: .fit)
                    .frame(width: 110)
                    .offset(x: buyMode ? -65 : 65)//-65
            }
            
            
            HStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(Color("mainDarkGray"))
                    .onTapGesture {
                        if !buyMode {
                            withAnimation(.spring()) {
                                buyMode = true
                            }
                        }
                    }
                Rectangle()
                    .foregroundColor(.white)
                Rectangle()
                    .foregroundColor(Color("mainDarkGray"))
                    .onTapGesture {
                        if buyMode {
                            withAnimation(.spring()) {
                                buyMode = false
                            }
                        }
                    }
            }
            .offset(x: buyMode ? -60 : 60)
            .frame(width: 300, height: 64)
            .mask(
                HStack(spacing: 88) {
                    Text("Buy")
                        .fontWeight(.light)
                    Text("Sell")
                        .fontWeight(.light)
                }
                .font(.title)
            )
        }
    }
    
    
    var step: Double {
        if buyMode {
            return Double(player.life_cash_balance / 100)
        } else {
            return Double(player.stock_position_value / 100)
        }
    }
    
    var AmountPicker: some View {
        VStack {
            Slider(
                value: $amountPercent,
                in: 0.0...(Double(buyMode ? player.life_cash_balance : player.stock_position_value)),
                   step: step,
                onEditingChanged: {_ in increaseAmountTextSize.toggle()}
            )
            
                .padding()
            
            VStack {
                Spacer()
                Text(formatNum(Int(amountPercent)))
                    .font(Font.system(size: increaseAmountTextSize ? 32 : 28))
                Spacer()
            }
            .frame(width: .infinity, height: 40)
        }
    }
}

//screen: 844 tall, 390 wide
//with padding: 731 tall, 358

struct StockMarketViewGraph: View {
    
    @EnvironmentObject var player: Player
    
    var ggrr: Graph {Graph(stockPoints: player.stockPoints)}
        
    var body: some View {
        ZStack {
            GraphAxisBg()
                .stroke(Color.blue, lineWidth: 2)
            
            GraphLinesBg(numLines: 12)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            
            ggrr//Graph(player: player)
                .stroke(Color.green, lineWidth: 4)
        }
        .padding()
        .aspectRatio(6/5, contentMode: .fit)
    }
    
    struct GraphLinesBg: Shape {
        
        let numLines: Int
        
        func path(in rect: CGRect) -> Path {
            
            let segmentDistance = rect.height / CGFloat(numLines)
            
            var path = Path()
            
            for i in 0...numLines - 1 {
                path.move(to: CGPoint(x: rect.minX, y: rect.maxY - segmentDistance * CGFloat(i)))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - segmentDistance * CGFloat(i)))
            }
            
            return path
        }
    }
    
    struct GraphAxisBg: Shape {
        
        func path(in rect: CGRect) -> Path {
            
            var path = Path()
            
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            
            return path
        }
    }
    
    struct Graph: Shape {
                
        //let points: [CGPoint]
        let stockPoints: [Int]
        
        func path(in rect: CGRect) -> Path {
            
            let widthSegment = rect.width / 9
            
        var pt1:  CGPoint { CGPoint(x: rect.minX, y: rect.height / 100 * CGFloat(stockPoints[0])) }
        var pt2:  CGPoint { CGPoint(x: CGFloat(widthSegment)   ,  y: rect.height - (rect.height / 100 * CGFloat(stockPoints[1]))) }
        var pt3:  CGPoint { CGPoint(x: CGFloat(widthSegment * 2), y: rect.height - (rect.height / 100 * CGFloat(stockPoints[2]))) }
        var pt4:  CGPoint { CGPoint(x: CGFloat(widthSegment * 3), y: rect.height - (rect.height / 100 * CGFloat(stockPoints[3]))) }
        var pt5:  CGPoint { CGPoint(x: CGFloat(widthSegment * 4), y: rect.height - (rect.height / 100 * CGFloat(stockPoints[4]))) }
        var pt6:  CGPoint { CGPoint(x: CGFloat(widthSegment * 5), y: rect.height - (rect.height / 100 * CGFloat(stockPoints[5]))) }
        var pt7:  CGPoint { CGPoint(x: CGFloat(widthSegment * 6), y: rect.height - (rect.height / 100 * CGFloat(stockPoints[6]))) }
        var pt8:  CGPoint { CGPoint(x: CGFloat(widthSegment * 7), y: rect.height - (rect.height / 100 * CGFloat(stockPoints[7]))) }
        var pt9:  CGPoint { CGPoint(x: CGFloat(widthSegment * 8), y: rect.height - (rect.height / 100 * CGFloat(stockPoints[8]))) }
        var pt10: CGPoint { CGPoint(x: CGFloat(widthSegment * 9), y: rect.height - (rect.height / 100 * CGFloat(stockPoints[9]))) }
            
            var path = Path()
            path.move(to: pt1)
            path.addLine(to: pt2)
            path.addLine(to: pt2)
            path.addLine(to: pt3)
            path.addLine(to: pt4)
            path.addLine(to: pt5)
            path.addLine(to: pt6)
            path.addLine(to: pt7)
            path.addLine(to: pt8)
            path.addLine(to: pt9)
            path.addLine(to: pt10)
            
            return path
        }
    }
}



struct StockMarketGraph: Shape {
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x:  rect.minX,               y: rect.height / 3      )
        let pt1   = CGPoint(x:  rect.maxX / 6,           y: rect.height / 5      )
        let pt2   = CGPoint(x: (rect.maxX / 6) * 2,      y: rect.height / 2 - 15 )
        let pt3   = CGPoint(x: (rect.maxX / 6) * 3,      y: rect.height - 10     )
        let pt4   = CGPoint(x: (rect.maxX / 6) * 4,      y: rect.height / 3      )
        let pt5   = CGPoint(x: (rect.maxX / 6) * 5,      y: rect.height / 3      )
        let end   = CGPoint(x:  rect.maxX,               y: rect.minY            )
        
        var path = Path()
        path.move(to: start)
        path.addLine(to: pt1)
        path.addLine(to: pt2)
        path.addLine(to: pt3)
        path.addLine(to: pt4)
        path.addLine(to: pt5)
        path.addLine(to: end)
        
        return path
    }
}
struct StockMarketGraphBg: Shape {
    func path(in rect: CGRect) -> Path {
        
        var movementValue: CGFloat = 10.0
        let start = CGPoint(x: rect.minX, y: rect.minY)
        //let bottom = 0
        
        var path = Path()
        
        path.move(to: start)
        
        for _ in 0...6 {
            path.addLine(to: CGPoint(x: rect.minX, y: movementValue))
            path.move(to: CGPoint(x: rect.minX, y: movementValue + 10))
            movementValue += 20.0
        }
        
        movementValue = 10.0
        
        for _ in 0...14 {
            path.addLine(to: CGPoint(x: movementValue, y: 140))
            path.move(to: CGPoint(x: movementValue + 10, y: 140))
            movementValue += 20.0
        }
        
        /*path.move(to: CGPoint(x: rect.minX, y: 105))
        movementValue = 10.0
        
        for _ in 0...14 {
            path.addLine(to: CGPoint(x: movementValue, y: 105))
            path.move(to: CGPoint(x: movementValue + 10, y: 105))
            movementValue += 20.0
        }
        
        path.move(to: CGPoint(x: rect.minX, y: 70))
        movementValue = 10.0
        
        for _ in 0...14 {
            path.addLine(to: CGPoint(x: movementValue, y: 70))
            path.move(to: CGPoint(x: movementValue + 10, y: 70))
            movementValue += 20.0
        }
        
        path.move(to: CGPoint(x: rect.minX, y: 35))
        movementValue = 10.0
        
        for _ in 0...14 {
            path.addLine(to: CGPoint(x: movementValue, y: 35))
            path.move(to: CGPoint(x: movementValue + 10, y: 35))
            movementValue += 20.0
        }*/
        
        return path
    }
}

struct StockMarketIcon: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color("mainDarkGray"))
            
            VStack {
                Text("Stock Market")
                    .foregroundColor(.white)
                    .font(Font.system(size: 40))
                Spacer()
                
                ZStack {
                    StockMarketGraphBg()
                        .stroke(Color.green, lineWidth: 2)
                    StockMarketGraph()
                        .stroke(Color.green, lineWidth: 6)
                }
                .padding()
            }
            .padding()
        }
        .aspectRatio(3/2, contentMode: .fit)
        .padding()
    }
}

struct StockMarketView_Previews: PreviewProvider {
    static var previews: some View {
        StockMarketView(showStockMarketView: .constant(true), showAssetsMain: .constant(false))
            .environmentObject(Player())
            .environmentObject(UserPreferences())
        //StockMarketIcon()
    }
}
