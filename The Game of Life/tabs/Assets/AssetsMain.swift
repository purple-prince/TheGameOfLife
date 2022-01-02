//
//  AssetsMain.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/13/21.
//

import SwiftUI

struct AssetsMain: View {
    
    @AppStorage("life_bank_balance") var life_bank_balance = 0
    
    @Binding var showAssetsMain: Bool
    @Binding var showBankDetail: Bool
    @Binding var showRealEstateDetail: Bool
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    bankButton
                    
                    Spacer()
                    
                    realEstateButton                    
                    
                    Spacer()
                }
            }
        }
        .background(Color("mainWhite"))
    }
}

extension AssetsMain {
    var bankButton: some View {
        Button(action: {
            showBankDetail = true
            showAssetsMain = false
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .aspectRatio(3/2, contentMode: .fit)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 12, x: 0, y: 0)
                
                VStack {
                    Text("Bank")
                        .font(Font.system(size: 50))
                        .fontWeight(.semibold)
                        .padding()
                    
                    VStack(alignment: .trailing) {
                        Text("Balance: " + formatNum(life_bank_balance))
                            .padding(.top)
                        
                        Text("Debt: $0")
                            .padding(1)
                    }
                }
            }
            .padding()
        }
        .foregroundColor(.black)
    }
    var realEstateButton: some View {
        Button(action: {
            showRealEstateDetail = true
            showAssetsMain = false
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .aspectRatio(3/2, contentMode: .fit)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 12, x: 0, y: 0)
                    //.frame(width: 400, height: 100)
                
                VStack {
                    Text("Real Estate")
                        .font(Font.system(size: 50))
                        .fontWeight(.semibold)
                        .padding()
                    
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("7 Properties")
                                .padding(.top)
                        }
                        
                        HStack {
                            Text("$660/Month")
                                .padding(1)
                        }
                    }
                }
            }
            .padding()
        }
        .foregroundColor(.black)
    }
}

struct AssetsMain_Previews: PreviewProvider {
    static var previews: some View {
        AssetsMain(showAssetsMain: .constant(false), showBankDetail: .constant(false), showRealEstateDetail: .constant(false))
    }
}
