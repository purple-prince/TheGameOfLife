//
//  SwiftUIView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 11/20/21.
//

import SwiftUI

enum ButtonLocation {
    case topLeading, topTrailing, bottomLeading, bottomTrailing
}

struct BankDetail: View {
        
    @State var directDepositOn = false
    @State var showDepositPopup = false
    
    @Binding var showAssetsMain: Bool
    @Binding var showBankDetail: Bool
    
    @AppStorage("life_bank_balance") var life_bank_balance = 0
    @AppStorage("life_cash_balance") var life_cash_balance = 0
    
    //xmark.app.fill
    //xmark.circle
    //x.circle
    //x.squre
    //xmark

    
    var body: some View {
        ZStack {
            
            background
            
            VStack {
                header
                
                buttonGrid
    
                Spacer()
            }
            .aspectRatio(155/200, contentMode: .fit)
            
            if showDepositPopup {
                depositPopup(showDepositPopup: $showDepositPopup)
            }
        }
    }
}

struct BankButton:  View{
    
    @Binding var directDepositOn: Bool
    @Binding var showDepositPopup: Bool
    
    var location: ButtonLocation
    
    func buttonText() -> String {
        switch location {
            case .topLeading:
                return "Deposit"
            case .topTrailing:
                return "Withdraw"
            case .bottomLeading:
                return "Loan"
            default:
                return "Direct\nDeposit"
        }
    }
    
    var body: some View {
        
        Button(action: {
            switch location {
            case .bottomTrailing:
                directDepositOn.toggle()
            case .topLeading:
                showDepositPopup = true
            default:
                break
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 140, height: 140)
                    .foregroundColor(location == .bottomTrailing ? (directDepositOn ? .green : Color("mainDarkGray")) : Color("mainDarkGray"))
                    .shadow(color: .gray, radius: 6)
                
                Text(buttonText())
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .foregroundColor(.white)
            }
        })
        
    }
}

extension BankDetail {
    var buttonGrid: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                
                BankButton(directDepositOn: $directDepositOn, showDepositPopup: $showDepositPopup, location: .topLeading)
                BankButton(directDepositOn: $directDepositOn, showDepositPopup: $showDepositPopup, location: .topTrailing)
                
            }
            
            HStack(spacing: 20) {
                
                BankButton(directDepositOn: $directDepositOn, showDepositPopup: $showDepositPopup, location: .bottomLeading)
                BankButton(directDepositOn: $directDepositOn, showDepositPopup: $showDepositPopup, location: .bottomTrailing)

            }
        }
    }
    var header: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Text("🏦")
                    .font(Font.system(size: 108))
                    .fontWeight(.semibold)
                
                closeButton
            }
            .padding(.bottom, 4)
            
            Text(formatNum(life_bank_balance))
                .font(Font.system(size: 24))
                .padding(.bottom, 32)
        }
    }
    var background: some View {
        RoundedRectangle(cornerRadius: 40)
            .aspectRatio(130/200, contentMode: .fit)
            .foregroundColor(.white)
            .shadow(color: .gray, radius: 12, x: 0, y: 0)
            .padding()
    }
    var closeButton: some View {
        Button(action: {
            showBankDetail = false
            showAssetsMain = true
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(Color.red)
                .font(Font.system(size: 40, weight: .medium))
        })
            .padding(.leading, 48)
            .padding(.trailing, 40)
            .padding(.bottom, 64)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        /*Group {
            BankDetail(showAssetsMain: .constant(false), showBankDetail: .constant(true))
                .preferredColorScheme(.light)
        }*/
        depositPopup(showDepositPopup: .constant(true))
    }
}

struct depositPopup: View {
    
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

extension depositPopup {
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

/*VStack {
    
    Spacer()
    
    ZStack {
        
        RoundedRectangle(cornerRadius: 24)
            .foregroundColor(Color.white)
            .frame(width: .infinity, height: 200)
            .shadow(color: .gray, radius: 12)
        
        VStack {
            
            Text("Are you sure you want to restart your life?")
                .padding()
                .multilineTextAlignment(.center)
                .font(.title2)
            
            Spacer()
            
            HStack {
                
                declineRestartButton
                
                confirmRestartButton
            }
            .padding(.bottom)
        }
        .frame(width: .infinity, height: 200)
    }
    .padding(24)
    
    Spacer()
    
    Spacer()
    
    Spacer()
}
.frame(maxWidth: .infinity, maxHeight: .infinity)
.background(Color("mainWhite").blur(radius: 40))*/
