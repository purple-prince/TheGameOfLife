//
//  SwiftUIView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 11/20/21.
//

import SwiftUI

struct BankDetail: View {
        
    var shape: RoundedRectangle { RoundedRectangle(cornerRadius: 60) }
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
            RoundedRectangle(cornerRadius: 40)
                .aspectRatio(130/200, contentMode: .fit)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 12, x: 0, y: 0)
                .padding()
            
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        
                        Text("🏦")
                            .font(Font.system(size: 108))
                            .fontWeight(.semibold)
                        
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
                    .padding(.bottom, 4)
                    
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("$58,675")
                                .font(Font.system(size: 24))
                                .padding(.bottom, 32)
                        }
                    }
                }
                //withdraw deposit loan, direct deposit
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        
                        Button(action: {}, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 140, height: 140)
                                    //.foregroundColor(.white)
                                    .foregroundColor(Color("mainDarkGrey"))
                                    .shadow(color: .gray, radius: 6)
                                
                                Text("Deposit")
                                    .font(.title2)
                                    //.foregroundColor(.black)
                                    .foregroundColor(.white)
                            }
                        })
                        
                        Button(action: {}, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 140, height: 140)
                                    //.foregroundColor(.white)
                                    .foregroundColor(Color("mainDarkGrey"))
                                    .shadow(color: .gray, radius: 6)
                                
                                Text("Withdraw")
                                    .font(.title2)
                                    //.foregroundColor(.black)
                                    .foregroundColor(.white)
                            }
                        })
                            //.on

                        

                    }
                    
                    HStack(spacing: 20) {
                        
                        Button(action: {}, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 140, height: 140)
                                    //.foregroundColor(.white)
                                    .foregroundColor(Color("mainDarkGrey"))
                                    .shadow(color: .gray, radius: 6)
                                
                                Text("Loan")
                                    .font(.title2)
                                    //.foregroundColor(.black)
                                    .foregroundColor(.white)
                            }
                        })
                        Button(action: {
                            directDepositOn.toggle()
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 140, height: 140)
                                    //.foregroundColor(directDepositOn ? .green : .white)
                                    .foregroundColor(directDepositOn ? .green : Color("mainDarkGrey"))
                                    //.foregroundColor(Color("mainDarkGrey"))
                                    .shadow(color: .gray, radius: 6)
                                
                                Text("Direct \nDeposit")
                                    .multilineTextAlignment(.center)
                                    .font(.title3)
                                    //.foregroundColor(.black)
                                    .foregroundColor(.white)
                            }
                        })

                    }
                }
                
                Spacer()
            }
            .aspectRatio(155/200, contentMode: .fit)
        }
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
