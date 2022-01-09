//
//  DepositPopup.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 1/4/22.
//

import SwiftUI

struct DepositPopup: View {
    @AppStorage("app_color_index") var colorCount: Int = 0

    var appColor: Color {
        colorOptions[colorCount]
    }
    
    
    @AppStorage("life_cash_balance") var life_cash_balance = 0
    @AppStorage("life_bank_balance") var life_bank_balance = 0
    @Binding var showDepositPopup: Bool
    @State var depositAmount: Double = 0.0
    
    var maxSliderAmount: Double {
        
        if life_cash_balance <= 0 {
            return 0.0
        } else {
            return Double(life_cash_balance)
        }
    }
        
    var body: some View {
        VStack {
            
            Spacer()
            
            ZStack {
                
                background
                
                VStack {
                    
                    header
                    
                    
                    Text(depositAmount == -1 ? "$0" : formatNum(Int(depositAmount)))
                    
                    //TODO: make slider logarithmic
                    Slider(value: $depositAmount,
                           in: -1...maxSliderAmount,
                           step: 1.0)
                        .accentColor(appColor)
                        .padding(.horizontal)
                    
                    submitDepositButton
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

extension DepositPopup {
    var background: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundColor(Color("mainWhite"))
            .frame(width: .infinity, height: 220)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(appColor, lineWidth: 2)
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
                    showDepositPopup = false
                }
        }
        .frame(width: .infinity, height: 20)
        .padding(.top, 32)
    }
    var submitDepositButton: some View {
        Text("Confirm")
            .padding()
            .background(Color("mainDarkGray"))
            .foregroundColor(.white)
            .cornerRadius(12)
            .onTapGesture {
                life_cash_balance -= Int(depositAmount)
                life_bank_balance += Int(depositAmount)
                showDepositPopup = false
            }
            
    }
}

struct DepositPopup_Previews: PreviewProvider {
    static var previews: some View {
        DepositPopup(showDepositPopup: .constant(true))
    }
}
