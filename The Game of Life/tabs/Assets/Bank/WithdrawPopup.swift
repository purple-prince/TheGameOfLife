//
//  WithdrawPopup.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/4/22.
//

import SwiftUI

struct WithdrawPopup: View {
    
    @Binding var showWithdrawPopup: Bool
    
    @EnvironmentObject var userPreferences: UserPreferences
    @EnvironmentObject var player: Player
    
    @State var withdrawAmount: Double = 0.0
    
    var maxSliderAmount: Double {
        
        if player.life_bank_balance <= 0 {
            return 0.0
        } else {
            return Double(player.life_bank_balance)
        }
    }
        
    var body: some View {
        VStack {
            
            Spacer()
            
            ZStack {
                
                background
                
                VStack {
                    
                    header
                    
                    
                    Text(withdrawAmount == -1 ? "$0" : formatNum(Int(withdrawAmount)))
                    
                    //TODO: make slider logarithmic
                    Slider(value: $withdrawAmount,
                           in: -1...maxSliderAmount,
                           step: 1.0)
                        .accentColor(userPreferences.appColor)
                        .padding(.horizontal)
                    
                    submitWithdrawButton
                }
            }
            .padding(24)
            
            Spacer()
            
            Spacer()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainWhite").blur(radius: 40))
    }
}

extension WithdrawPopup {
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
            
            Text("How much doe 😳")
                .font(.title)
                
            
            Image(systemName: "xmark")
                .foregroundColor(.red)
                .font(Font.system(size: 32))
                .padding(.bottom, 64)
                .padding(.trailing, 10)
                .onTapGesture {
                    showWithdrawPopup = false
                }
        }
        .frame(width: .infinity, height: 20)
        .padding(.top, 32)
    }
    var submitWithdrawButton: some View {
        Text("Confirm")
            .padding()
            .background(Color("mainDarkGray"))
            .foregroundColor(.white)
            .cornerRadius(12)
            .onTapGesture {
                player.life_cash_balance += Int(withdrawAmount)
                player.life_bank_balance -= Int(withdrawAmount)
                showWithdrawPopup = false
            }
            
    }
}

struct WithdrawPopup_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawPopup(showWithdrawPopup: .constant(true))
            .environmentObject(Player())
    }
}
