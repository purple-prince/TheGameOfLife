//
//  AssetTab.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/11/21.
//

import SwiftUI

struct AssetTab: View {
    
    @State var showBankDetail = false

    //BLEND MODE FOR BLUR OVERLAP
    //BLEND MODE FOR BLUR OVERLAP
    //BLEND MODE FOR BLUR OVERLAP
    //BLEND MODE FOR BLUR OVERLAP
    //BLEND MODE FOR BLUR OVERLAP
    //BLEND MODE FOR BLUR OVERLAP

    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Button(action: {
                        showBankDetail = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 40)
                                .aspectRatio(3/2, contentMode: .fit)
                                .foregroundColor(.white)
                                .shadow(color: .gray, radius: 12, x: 0, y: 0)
                                .padding()
                            
                            VStack {
                                Text("Bank")
                                    .font(Font.system(size: 50))
                                    .fontWeight(.semibold)
                                    .padding()
                                
                                VStack(alignment: .trailing) {
                                    HStack {
                                        Text("Balance: $58,675")
                                            .padding(.top)
                                    }
                                    
                                    HStack {
                                        Text("Debt: $24,200")
                                            .padding(1)
                                    }
                                }
                            }
                        }
                    }
                    .foregroundColor(.black)
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 12)
                        .padding()
                        .frame(width: .infinity, height: 150)
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 12)
                        .padding()
                        .frame(width: .infinity, height: 150)
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 12)
                        .padding()
                        .frame(width: .infinity, height: 150)
                    
                    Spacer()
                }
                .blur(radius: showBankDetail ? 4 : 0)
                
                if showBankDetail {
                    BankDetail(showBankDetail: $showBankDetail)
                }
            }
        }
        .background(Color("mainWhite"))
    }
}

struct AssetTab_Previews: PreviewProvider {
    static var previews: some View {
        AssetTab()
    }
}

