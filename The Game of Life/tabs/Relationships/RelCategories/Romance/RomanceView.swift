//
//  RomanceView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct RomanceView: View {
    var body: some View {
                
        NavigationView {
            VStack {
                VStack /*current job*/ {
                    Spacer()
                    
                    Text(String(allPartners.count))
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                    Text("-0.5/month")
                        .font(.title3)
                    
                    Spacer()
                }
                .font(Font.custom("mainFont", size: 20))
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(Color("neonGreen"))
                .foregroundColor(.black)
                .cornerRadius(12)
                .shadow(radius: 12)
                .padding()
                            
                Divider()
                
                VStack {
                    
                    ForEach(allPartners) { partner in
                        NavigationLink(destination: {
                            RomanceDetail(partner: tempPartner)
                        }, label: {
                            HStack {
                                Text(tempPartner.emoji! + " " + tempPartner.name)
                                Spacer()
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: 120, height: 12)
                                        .foregroundColor(Color.gray)
                                        
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: ParentsDetail(mode: "Mom").momStatus, height: 12)
                                        .foregroundColor(Color.green)
                                }
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        })
                    }
                    
                    
                    
                    /*NavigationLink(destination: {
                        RomanceDetail(partner: tempPartner)
                    }, label:{
                        HStack {
                            Text(tempPartner.emoji! + " " + tempPartner.name)
                            Spacer()
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 120, height: 12)
                                    .foregroundColor(Color.gray)
                                    
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: ParentsDetail(mode: "Mom").momStatus, height: 12)
                                    .foregroundColor(Color.green)
                            }
                        }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    })*/
                }
                Spacer()
            }
            .offset(y: 72)
        .ignoresSafeArea()
        }
        //.navigationBarHidden(true)
    }
}

struct RomanceView_Previews: PreviewProvider {
    static var previews: some View {
        RomanceView()
    }
}
