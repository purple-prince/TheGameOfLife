//
//  RomanceDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/15/21.
//

//flirt, ask them out, propose, marry, have kids, divorce,
//spend time, trip, gift, sex, date, vacation, hurt
//breakup, cheat

import SwiftUI

struct RomanceDetail: View {
    
    // USE EVENTUALLY : let partner: Partner
    let partner: Partner
    
    @State var status = CGFloat(tempPartner.status)
    
    func limitStatus() -> Void {
        if status < 0 {
            status = 0
        }
        if status > 100 {
            status = 100
        }
    }
    
    func StatusBar() -> some View {
        ZStack(alignment: .leading){
            
            //background bar
            RoundedRectangle(cornerRadius: 0)
                .frame(width: 100, height: 16)
                .foregroundColor(Color.gray)
            
            //foreground bar
            RoundedRectangle(cornerRadius: 0)
                .frame(width: CGFloat(status), height: 16)
                .foregroundColor(Color.red)
        }
        .cornerRadius(8)
        .offset(y: -16)
    }
    
    func Banner() -> some View {
        
        VStack(alignment: .center){
            Spacer()
            
            Text(tempPartner.name.components(separatedBy: " ")[0])
                .font(.largeTitle)
            Spacer()
            Text(tempPartner.emoji!)
                .font(Font.system(size: 45))
            StatusBar()
            Spacer()
        }
        .font(Font.custom("mainFont", size: 20))
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(Color.yellow)
        .foregroundColor(.black)
        .cornerRadius(12)
        .shadow(radius: 12)
        .padding()
    }
    
    var body: some View {
        let shadowRadius: CGFloat = 4
        
        VStack {
            
            //Text(tempPartner().status)
            
            Banner()
            
            Divider()
            
            VStack {
                HStack {
                    Button(action:{
                        status += 10
                        limitStatus()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .aspectRatio(5/4, contentMode: .fit)
                                .shadow(color: Color.gray, radius: shadowRadius)
                            
                            VStack {
                                
                                Text("Visit Park")
                                    .foregroundColor(Color.black)
                                
                                
                                
                            }
                        }
                    })
                        .padding(.leading, 12)
                        .padding(.bottom, 6)
                        .padding(.top, 8)
                        .padding(.trailing, 4)
                    
                    Button(action:{
                        status += 20
                        limitStatus()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .aspectRatio(5/4, contentMode: .fit)
                                .shadow(color: Color.gray, radius: shadowRadius)
                            
                            VStack {
                                Text("Get Dinner")
                                    .foregroundColor(Color.black)
                            }
                        }
                    })
                        .padding(.leading, 4)
                        .padding(.bottom, 4)
                        .padding(.top, 6)
                        .padding(.trailing, 12)
                    
                }
                .foregroundColor(Color.white)
                
                HStack {
                    
                    Button(action:{
                        status += 35
                        limitStatus()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .aspectRatio(5/4, contentMode: .fit)
                                .shadow(color: Color.gray, radius: shadowRadius)
                            
                            Text("Give Gift")
                                .foregroundColor(Color.black)
                        }
                    })
                        .padding(.leading, 12)
                        .padding(.bottom, 8)
                        .padding(.top, 4)
                        .padding(.trailing, 4)
                    
                    Button(action:{
                        status += 75
                        limitStatus()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .aspectRatio(5/4, contentMode: .fit)
                                .shadow(color: Color.gray, radius: shadowRadius)
                            
                            Text("Take vacation")
                                .foregroundColor(Color.black)
                        }
                    })
                        .padding(.leading, 4)
                        .padding(.bottom, 8)
                        .padding(.top, 4)
                        .padding(.trailing, 12)
                }
                .foregroundColor(Color.white)
                
                HStack {
                    
                    Button(action:{
                        status -= 75
                        limitStatus()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .aspectRatio(5/4, contentMode: .fit)
                                .shadow(color: Color.gray, radius: shadowRadius)
                            
                            Text("Kill")
                                .foregroundColor(Color.black)
                        }
                    })
                        .padding(.leading, 12)
                        .padding(.bottom, 8)
                        .padding(.top, 4)
                        .padding(.trailing, 4)
                    
                    Button(action:{
                        status -= 10
                        limitStatus()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .aspectRatio(5/4, contentMode: .fit)
                                .shadow(color: Color.gray, radius: shadowRadius)
                            
                            Text("Ask for money")
                                .foregroundColor(Color.black)
                        }
                    })
                        .padding(.leading, 4)
                        .padding(.bottom, 8)
                        .padding(.top, 4)
                        .padding(.trailing, 12)
                }
                .foregroundColor(Color.white)
                
            }
            
            Spacer()
        }
        .offset(y: 72)
        .ignoresSafeArea()
    }
}

struct RomanceDetail_Previews: PreviewProvider {
    static var previews: some View {
        RomanceDetail(partner: tempPartner)
    }
}
