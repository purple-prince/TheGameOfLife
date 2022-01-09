//
//  LotteryPopup.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/5/22.
//

import SwiftUI
import RealModule

struct LotteryPopup: View {
    
    @State var resetUpcomingNums: Bool = false
    @AppStorage("lottery_jackpot") var lottery_jackpot: Int = Int.random(in: 750_000_000...1_500_000_000)
    
    @AppStorage("life_cash_balance") var life_cash_balance = 0
    @AppStorage("app_color_index") var colorCount: Int = 0

    var appColor: Color {
        colorOptions[colorCount]
    }
    
    @Binding var showLotteryPopup: Bool
    @State var amountWon: Int = 0
    @State var num1: String?
    @State var num2: String?
    @State var num3: String?
    @State var num4: String?
    @State var num5: String?
    @State var num6: String?
    @AppStorage("winning_1") var winning_1 = Int.random(in: 1...9)
    @AppStorage("winning_2") var winning_2 = Int.random(in: 1...9)
    @AppStorage("winning_3") var winning_3 = Int.random(in: 1...9)
    @AppStorage("winning_4") var winning_4 = Int.random(in: 1...9)
    @AppStorage("winning_5") var winning_5 = Int.random(in: 1...9)
    @AppStorage("winning_6") var winning_6 = Int.random(in: 1...9)
    @State var numsRight: Int = 0
    

        
    var body: some View {
        VStack {
            
            Spacer()
            
            ZStack {
                
                background
                
                VStack {
                    
                    header
                    
                    main
                    
                    Spacer()
                }
            }
            .frame(width: .infinity, height: (UIScreen.main.bounds.height * 2 / 3))
            .padding(24)
            
            Spacer()
            
            Spacer()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainWhite").blur(radius: 64))
        
    }
}

extension LotteryPopup {
    
    func resetWinningNums() {
        winning_1 = Int.random(in: 1...9)
        winning_2 = Int.random(in: 1...9)
        winning_3 = Int.random(in: 1...9)
        winning_4 = Int.random(in: 1...9)
        winning_5 = Int.random(in: 1...9)
        winning_6 = Int.random(in: 1...9)
    }
    
    func checkNums(amount: Int) -> Void {
        if Int(num1!) == winning_1 {
            if Int(num2!) == winning_2 {
                if Int(num3!) == winning_3 {
                    if Int(num4!) == winning_4 {
                        if Int(num5!) == winning_5 {
                            if Int(num6!) == winning_6 {
                                numsRight = 6
                                life_cash_balance += lottery_jackpot
                            } else {
                                numsRight = 5
                                amountWon += Int(pow(Double(lottery_jackpot), Double(1/2.0)) * Double(amount))
                                life_cash_balance += amountWon
                            }
                        } else {
                            numsRight = 4
                            amountWon = Int(pow(Double(lottery_jackpot), Double(1/3.0)) * Double(amount))
                            life_cash_balance += amountWon
                        }
                    } else {
                        numsRight = 3
                        amountWon = Int(pow(Double(lottery_jackpot), Double(1/4.0)) * Double(amount))
                        life_cash_balance += amountWon
                    }
                } else {
                    numsRight = 2
                    amountWon = Int(pow(Double(lottery_jackpot), Double(1/5.0)) * Double(amount))
                    life_cash_balance += amountWon
                }
            } else {
                numsRight = 1
                amountWon += Int(pow(Double(lottery_jackpot), Double(1/6.0)) * Double(amount))
                life_cash_balance += amountWon
            }
            resetUpcomingNums = true
        }
    }
    
    var background: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundColor(Color("mainWhite"))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(appColor, lineWidth: 2)
            )
            .shadow(color: .gray, radius: 12)
    }
    var header: some View {
        HStack {
        
        Spacer()
        
        Image(systemName: "xmark")
            .foregroundColor(.red)
            .font(Font.system(size: 32))
            //.padding(.bottom, 64)
            //.padding(.trailing, 10)
            .onTapGesture {
                showLotteryPopup = false
            }
    }
    .frame(width: .infinity, height: 20)
    //.padding(.top, 32)
    .padding()
}
    var winningNums: some View {
        VStack {
            
            Text("Winning Numbers...")
                .padding(.bottom, 1)
            
            HStack(spacing: 12) {
                Text(String(winning_1))
                    .fontWeight(.light)
                Text(String(winning_2))
                    .fontWeight(.light)
                Text(String(winning_3))
                    .fontWeight(.light)
                Text(String(winning_4))
                    .fontWeight(.light)
                Text(String(winning_5))
                    .fontWeight(.light)
                Text(String(winning_6))
                    .fontWeight(.light)
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.top)
    }
    func ticketNumBox(_ num: String?) -> some View {
        Text(num ?? "_")
            .padding(8)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(appColor, lineWidth: 2)
            )
            .cornerRadius(6)
    }
    var ticketView: some View {
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 24)
                    .fill(
                        RadialGradient(colors: [
                            Color(red: 147/255, green: 112/255 ,blue: 219/255),
                            Color(red: 138/255, green: 43/255, blue: 226/255)
                        ],
                                       center: .top,
                                       startRadius: 30,
                                       endRadius: geometry.size.height)
                    )
            }
            
            VStack {
                
                Text("MegaLotto")
                    .underline(color: .red)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding(.top, 8)
                                
                HStack {
                    
                    ticketNumBox(num1)
                        .foregroundColor(numsRight > 0 ? .green : nil)
                    
                    ticketNumBox(num2)
                        .foregroundColor(numsRight > 1 ? .green : nil)
                    
                    ticketNumBox(num3)
                        .foregroundColor(numsRight > 2 ? .green : nil)
                    
                    ticketNumBox(num4)
                        .foregroundColor(numsRight > 3 ? .green : nil)
                    
                    ticketNumBox(num5)
                        .foregroundColor(numsRight > 4 ? .green : nil)
                    
                    ticketNumBox(num6)
                        .foregroundColor(numsRight > 5 ? .green : nil)
                    
                }
                .font(Font.system(size: 35))
                
                if amountWon != 0 {
                    Text("+ " + formatNum(amountWon))
                        .foregroundColor(.green)
                        .font(.title2)
                        .fontWeight(.medium)
                }
                
                
                Spacer()
            }
            
            ZStack {
                Text("$")
                    .offset(x: -130, y: 100)
                    //.rotationEffect(Angle(degrees: Double.random(in: 0...360)))
                Text("$")
                    .offset(x: 120, y: 80)
                Text("$")
                    .offset(x: -40, y: 90)
                Image(systemName: "star.fill")
                    .offset(x: 115, y: -94)
                Image(systemName: "star.fill")
                    .offset(x: -115, y: -94)
                Image(systemName: "star.fill")
                    .offset(x: -90, y: 60)
                Image(systemName: "star.fill")
                    .offset(x: 80, y: 80)
                Image(systemName: "star.fill")
                    .offset(x: 10, y: 100)
            }
            .font(.largeTitle)
            .padding()
            .foregroundColor(.yellow)
        }
        .padding(.horizontal)
        
    }
    var main: some View {
        VStack {
            
            Text("Jackpot: " + formatNum(lottery_jackpot))
                .font(.largeTitle)
                        
            winningNums
            
            ticketView
            
            HStack {
                buyTicketButton(amount: 1)
                buyTicketButton(amount: 10)
            }
        }
    }
    func buyTicketButton(amount: Int) -> some View {
        Button(action: {
            
            if resetUpcomingNums {
                resetWinningNums()
                resetUpcomingNums = false
            }
            
            if life_cash_balance >= 10 * amount {
                numsRight = 0
                life_cash_balance -= 10 * amount
                
                num1 = String(Int.random(in: 1...9))
                num2 = String(Int.random(in: 1...9))
                num3 = String(Int.random(in: 1...9))
                num4 = String(Int.random(in: 1...9))
                num5 = String(Int.random(in: 1...9))
                num6 = String(Int.random(in: 1...9))
                
                amountWon = 0
                checkNums(amount: amount)
            }
            
        }, label: {
            Text("Buy \(amount) - $\(10 * amount)")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal, 12)
                .background(Color("mainDarkGray"))
                .overlay(life_cash_balance >= (amount * 10) ? nil : Color.gray.opacity(0.4))
                .cornerRadius(12)
                
        })
    }
}

struct LotteryPopup_Previews: PreviewProvider {
    static var previews: some View {
        LotteryPopup(showLotteryPopup: .constant(true))
    }
}
