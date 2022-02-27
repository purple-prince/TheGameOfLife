//
//  LoanPopup.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 2/24/22.
//

import SwiftUI

struct LoanPopup: View {
    
    @Binding var showLoanPopup: Bool
    
    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var player: Player
    
    @State var loanAmount: Double = 0.0
    @State var onLoanMenu: Bool = true
    @State var mode: LoanModes? = nil
    
    var maxLoanAmount: Int {
        
        if mode == .pay {
            
            if player.loan_debt > player.life_cash_balance {
                return player.life_cash_balance
            } else {
                return player.loan_debt
            }
            
        } else {
            return (player.getNetWorth() * 5) > 1_000_000_000_000_000 ? 1_000_000_000_000_000 : player.getNetWorth() * 5 - player.loan_taken
        }
    }
    
    enum LoanModes {
        case pay, take
    }
        
    var body: some View {
        VStack {
            
            Spacer()
            
            if onLoanMenu {
                LoanMenu
            } else {
                LoanSelect
            }
            
            Spacer()
            
            Spacer()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainWhite").blur(radius: 40))
    }
}

extension LoanPopup {
    
    var LoanMenu: some View {
        ZStack {
            background
            
            ZStack {
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .font(Font.system(size: 32))
                            //.padding(.bottom, 64)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                showLoanPopup = false
                            }
                    }
                    
                    Spacer()
                        .frame(width: 1, height: 166)
                }
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            onLoanMenu = false
                            mode = .pay
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color("mainDarkGray"))
                                
                                Text("Pay off")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            .aspectRatio(3/2, contentMode: .fit)
                        })
                        Button(action: {
                            onLoanMenu = false
                            mode = .take
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(Color("mainDarkGray"))
                                
                                Text("Take loan")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            .aspectRatio(3/2, contentMode: .fit)
                        })
                    }
                    .frame(width: .infinity, height: 100)
                    .padding()
                }
                .frame(maxHeight: 224)
            }
        }
        .padding(24)
    }
    
    var LoanSelect: some View {
        ZStack {
            
            background
            
            VStack {
                
                header
                
                //TODO: make all "new view" buttons get rid of the parent view to save having to render them
                
                Text(loanAmount == -1 ? "$0" : formatNum(Int(loanAmount)))
                    .foregroundColor(.red)
                
                //TODO: make slider logarithmic
                Slider(value: $loanAmount,
                       in: -1...Double(maxLoanAmount),
                       step: 1.0)
                    .accentColor(userPreferences.appColor)
                    .padding(.horizontal)
                
                confirmLoanButton
            }
        }
        .padding(24)
    }
    
    var background: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundColor(Color("mainWhite"))
            .frame(width: .infinity, height: 220)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(userPreferences.appColor, lineWidth: 2)
            )
            .shadow(color: .gray, radius: 12)
    }
    var header: some View {
        HStack {
            
            Spacer()
            
            Text("How much doe 🤔")
                .font(.title)
                
            
            Image(systemName: "xmark")
                .foregroundColor(.red)
                .font(Font.system(size: 32))
                .padding(.bottom, 64)
                .padding(.trailing, 10)
                .onTapGesture {
                    showLoanPopup = false
                }
        }
        .frame(width: .infinity, height: 20)
        .padding(.top, 32)
    }
    var confirmLoanButton: some View {
        Text("Confirm")
            .padding()
            .background(Color("mainDarkGray"))
            .foregroundColor(.white)
            .cornerRadius(12)
            .onTapGesture {
                
                if mode == .pay {
                    player.loan_debt -= (player.life_cash_balance > Int(loanAmount) ? Int(loanAmount) : player.life_cash_balance)//Int(loanAmount)
                    player.life_cash_balance -= Int(loanAmount)
                    player.loan_taken -= Int(loanAmount)
                } else {
                    player.loan_taken += Int(loanAmount)
                    player.life_cash_balance += Int(loanAmount)
                    player.loan_debt += Int(loanAmount)
                }
                
                showLoanPopup = false
            }
            
    }
}

struct LoanPopup_Previews: PreviewProvider {
    static var previews: some View {
        LoanPopup(showLoanPopup: .constant(true))
            .environmentObject(Player())
            .environmentObject(UserPreferences())
    }
}
