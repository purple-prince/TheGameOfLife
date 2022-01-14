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
    @State var showWithdrawPopup = false
    
    @Binding var showAssetsMain: Bool
    @Binding var showBankDetail: Bool
    
    @EnvironmentObject var player: Player
    
    
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
                DepositPopup(showDepositPopup: $showDepositPopup)
            }
            
            if showWithdrawPopup {
                WithdrawPopup(showWithdrawPopup: $showWithdrawPopup)
            }
        }
    }
}

struct BankButton:  View{
    
    @Binding var directDepositOn: Bool
    @Binding var showDepositPopup: Bool
    @Binding var showWithdrawPopup: Bool
    
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
                case .topTrailing:
                    showWithdrawPopup = true
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
                
                BankButton(directDepositOn: $directDepositOn, showDepositPopup: $showDepositPopup, showWithdrawPopup: $showWithdrawPopup, location: .topLeading)
                BankButton(directDepositOn: $directDepositOn, showDepositPopup: $showDepositPopup, showWithdrawPopup: $showWithdrawPopup, location: .topTrailing)
                
            }
            
            HStack(spacing: 20) {
                
                BankButton(directDepositOn: $directDepositOn, showDepositPopup: $showDepositPopup, showWithdrawPopup: $showWithdrawPopup, location: .bottomLeading)
                BankButton(directDepositOn: $directDepositOn, showDepositPopup: $showDepositPopup, showWithdrawPopup: $showWithdrawPopup, location: .bottomTrailing)

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
            
            Text(formatNum(player.life_bank_balance))
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
        Group {
            BankDetail(showAssetsMain: .constant(false), showBankDetail: .constant(true))
                .preferredColorScheme(.light)
                .environmentObject(Player())
        }
    }
}
