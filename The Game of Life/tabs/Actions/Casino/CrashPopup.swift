//
//  CrashPopup.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 2/17/22.
//

import SwiftUI

struct CrashPopup: View {
    
    @Binding var showCasinoView: Bool
    @Binding var showCrashPopup: Bool
    
    var body: some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
            
            VStack {
                Header
                Spacer()
                CrashView()
                Spacer()
            }
            
            BackButton
        }
    }
}

struct CrashPopupAmountButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .brightness(configuration.isPressed ? 0.1 : 0.0)
    }
}

extension CrashPopup {
    
    var Header: some View {
        VStack(spacing: 8) {
            Text("Crash")
                .font(Font.system(size: 40))
            Capsule()
                .frame(width: .infinity, height: 2)
        }
        .padding()
        .foregroundColor(Color("mainDarkGray"))
    }
    
    var BackButton: some View {
        VStack {
            HStack {
                Button(action: {
                    showCrashPopup = false
                    showCasinoView = true
                }, label: {
                    Image(systemName: "chevron.backward")
                    .foregroundColor(Color("mainDarkGray"))
                    .font(Font.system(size: 40))
                })
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct CrashView: View {
    
    @EnvironmentObject var player: Player

    @State var markerOffset: Int = 0
    @State var multiplier: Double = 0.0
    @State var progress: Double = 0.0
    @State var timerOn: Bool = false
    @State var betPercent: Double = 0.0
    @State var betAmount: Int = 0
    
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common)
    
    func resetTimer() {
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
    }

    func setMultiplier() {
        let isGain: Bool = Bool.random()

        if isGain {

            var cap = 0
            let chance = Int.random(in: 1...128)
            if chance >= 64 {
                cap = Int.random(in: 1...2)
            } else if chance >= 32 {
                cap = Int.random(in: 2...4)
            } else if chance >= 16 {
                cap = Int.random(in: 4...8)
            } else if chance >= 8 {
                cap = Int.random(in: 8...16)
            } else if chance >= 4 {
                cap = Int.random(in: 16...32)
            } else if chance >= 2 {
                cap = Int.random(in: 32...64)
            } else if chance >= 1 {
                cap = Int.random(in: 64...128)
            }
            
//            let range = Double(cap) / 10.0
//            cap = Int.random(in: Int(Double(cap) - range)...Int(Double(cap) + range))

            multiplier = Double(cap)


        } else {
            multiplier = (Double.random(in: 0...1) * 100).rounded() / 100
        }
    }

    func progressIncrement(divisor: Int) -> Double {
        if progress <= 1.0 {
            return 1.0 / Double(divisor)
        } else if progress <= 2.0 {
            return 2.0 / Double(divisor)
        } else if progress <= 4.0 {
            return 4.0 / Double(divisor)
        } else if progress <= 8.0 {
            return 8.0 / Double(divisor)
        } else if progress <= 16.0 {
            return 16.0 / Double(divisor)
        }  else if progress <= 32.0 {
            return 32.0 / Double(divisor)
        } else if progress <= 64.0 {
            return 64.0 / Double(divisor)
        } else {
            return 128.0 / Double(divisor)
        }
    }
    
    func BetAmountButton(_ percent: Double) -> some View {
        return Button(action: {
            betPercent = percent
            
            betAmount = Int(Double(player.life_cash_balance) * betPercent)
            
            HapticManager.instance.playHaptic(type: .light)
            
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color("mainDarkGray"))
                Text(String(Int(percent * 100)) + "%")
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .frame(width: 90, height: 50)
        })
            //.buttonStyle(CrashPopupAmountButtonStyle())
    }
    
    var Graph: some View {
        ZStack {
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .frame(width: 250, height: 2)
                    .offset(x: -35)
                Rectangle()
                    .frame(width: 2, height: 200)
                    .offset(x: -35)
                Rectangle()
                    .frame(width: 2, height: 15)
                    .offset(x: CGFloat((200 - markerOffset > -34 ? Double((200 - markerOffset)) : -34.0)), y: 7)
                Rectangle()
                    .frame(width: 2, height: 15)
                    .offset(x: CGFloat((100 - markerOffset > -32 ? Double((100 - markerOffset)) : -32.0)), y: 7)
//                Rectangle()
//                    .frame(width: 2, height: 10)
            }
            .foregroundColor(Color("mainDarkGray"))
            
            GraphLine(lineIncrease: $progress)
                .stroke(Color.red, lineWidth: 5)
                .scaleEffect(0.65)
                .offset(x: -16, y: -4)
        }
        .offset(x: 30, y: 20)
    }

    var body: some View {
        VStack {
            Text("Bet Amount: " + formatNum(betAmount))
                .font(.title2)
                .onAppear {
                    betPercent = 0.1
                }
            
            HStack(spacing: 6) {
                BetAmountButton(0.1)
                BetAmountButton(0.25)
                BetAmountButton(0.5)
                BetAmountButton(1.00)
            }
            .padding()
            
            Spacer()
            
            Graph
            
            Text(String(format: "%.2f", progress) + "x")
                .fontWeight(.medium)
                .foregroundColor(timerOn ? .green : .red)
                .font(Font.system(size: 40))
            
            Text(String(timerOn))


            Button(action: {
                
                if betAmount > 0 {
                    if !timerOn {
                        setMultiplier()
                        progress = 0.0
                        resetTimer()
                        timer.connect()
                        timerOn = true
                        betAmount = Int(Double(player.life_cash_balance) * betPercent)
                        player.life_cash_balance -= betAmount
                    } else {
                        timer.connect().cancel()
                        timerOn = false
                        player.life_cash_balance += Int(Double(betAmount) * progress)
                        markerOffset = 0
                    }
                }
            }, label: {

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("mainDarkGray"))

                   Text(timerOn ? "Cash in" : "Burn my money!")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    if betAmount <= 0 && !timerOn{
                        Color.gray.opacity(0.5).cornerRadius(12)
                    }
                }
                .aspectRatio(3, contentMode: .fit)

            })
                .padding()
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.horizontal)
            
            Spacer()
        }
        .onReceive(timer, perform: { _ in

            progress += progressIncrement(divisor: 10) / 2
            markerOffset += Int(progress) / 2

            if progress >= multiplier {
                progress += Double(Int.random(in: 0...10)) * 0.01
                timer.connect().cancel()
                timerOn = false
                markerOffset = 0
//                end()
            }
        })
    }
}

struct GraphLine: Shape {
    
    @Binding var lineIncrease: Double
    var isBeginning: Bool {
        return lineIncrease < 2.0
    }
    var isEnding: Bool {
        return lineIncrease > 32.0
    }
    let beginningLineIncrease: Double = 10.0
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.maxY)
        let end = CGPoint(x: rect.maxX, y: rect.minY)
        
        var path = Path()
        //path.move(to: start)
        path.addArc(center: CGPoint(x: -15, y: -98), radius: 400.0, startAngle: Angle(degrees: 90 - (isBeginning ? 0.0 : isEnding ? 65.0 : 15.0) -
                                                                                      ((lineIncrease *
                                                                                        (isBeginning ? 10.0 : isEnding ? 0.25 : 2.0)))),
                    endAngle: Angle(degrees: 90), clockwise: false)
        return path
    }
}

struct CrashPopup_Previews: PreviewProvider {
    static var previews: some View {
        CrashPopup(showCasinoView: .constant(false), showCrashPopup: .constant(true))
            .environmentObject(Player())
    }
}
