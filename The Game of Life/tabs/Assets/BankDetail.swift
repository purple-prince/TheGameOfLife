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
    
    @Binding var showAssetsMain: Bool
    @Binding var showBankDetail: Bool
    
    //xmark.app.fill
    //xmark.circle
    //x.circle
    //x.squre
    //xmark

    
    var body: some View {
        ZStack {
            
            background
            
            VStack {
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        Text("🏦")
                            .font(Font.system(size: 108))
                            .fontWeight(.semibold)
                        
                        closeButton
                    }
                    .padding(.bottom, 4)
                    
                    Text("$58,675")
                        .font(Font.system(size: 24))
                        .padding(.bottom, 32)
                }
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        
                        BankButton(directDepositOn: $directDepositOn, location: .topLeading)
                        BankButton(directDepositOn: $directDepositOn, location: .topTrailing)
                        
                    }
                    
                    HStack(spacing: 20) {
                        
                        BankButton(directDepositOn: $directDepositOn, location: .bottomLeading)
                        BankButton(directDepositOn: $directDepositOn, location: .bottomTrailing)

                    }
                }
    
                Spacer()
            }
            .aspectRatio(155/200, contentMode: .fit)
        }
    }
}

struct BankButton:  View{
    
    @Binding var directDepositOn: Bool
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
            default:
                break
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 140, height: 140)
                    .foregroundColor(location == .bottomTrailing ? (directDepositOn ? .green : Color("mainDarkGrey")) : Color("mainDarkGrey"))
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
        }
    }
}
