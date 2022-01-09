//
//  ParentsDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 11/6/21.
//

import SwiftUI

//flirt, ask them out, propose, marry, have kids, divorce,
//spend time, trip, gift, sex, date, vacation, hurt
//breakup, cheat


//CHANGING THE ASPECT RATIOS TO A DOUBLE RESULTS IN A MEMORY LEAK IDK WHY

struct ParentsDetail: View {

    let mode: String
    
    @State var momStatus = CGFloat(tempParents.mom.status)
    @State var dadStatus = CGFloat(tempParents.dad.status)
    
    @AppStorage("life_health_status") var life_health_status = 0 {
        didSet {
            The_Game_of_Life.limitStatus()
        }
    }
    @AppStorage("life_happiness_status") var life_happiness_status = 0 {
        didSet {
            The_Game_of_Life.limitStatus()
        }
    }
    @AppStorage("life_energy_status") var life_energy_status = 0 {
        didSet {
            The_Game_of_Life.limitStatus()
        }
    }
    
    func limitStatus(_ parent: CGFloat) -> Void {
        if parent == momStatus {
            if momStatus < 0 {
                momStatus = 0
            }
            if momStatus > 100 {
                momStatus = 100
            }
        } else {
            if dadStatus < 0 {
                dadStatus = 0
            }
            if dadStatus > 100 {
                dadStatus = 100
            }
        }
    }
    
    func StatusBar(mode: String) -> some View {
        ZStack(alignment: .leading){
            
            //background bar
            RoundedRectangle(cornerRadius: 0)
                .frame(width: 100, height: 16)
                .foregroundColor(Color.gray)
            
            //foreground bar
            RoundedRectangle(cornerRadius: 0)
                .frame(width: CGFloat(mode == "Mom" ? momStatus : dadStatus), height: 16)
                .foregroundColor(Color.red)
        }
        .cornerRadius(8)
        .offset(y: -16)
    }
    
    func parentBanner() -> some View {
                
        Group {
            switch mode {
            case "Mom":
                VStack(alignment: .center){
                    Spacer()
                    
                    Text(tempParents.mom.name)
                        .font(.largeTitle)
                    Spacer()
                    Text(tempParents.mom.emoji)
                        .font(Font.system(size: 45))
                    StatusBar(mode: "Mom")
                    Spacer()
                }
                .font(Font.custom("mainFont", size: 20))
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(12)
                .shadow(radius: 12)
                .padding()
            case "Dad":
                VStack{
                    Spacer()
                    
                    Text(tempParents.dad.name)
                        .font(.largeTitle)
                    Spacer()
                    StatusBar(mode: "Dad")
                    Spacer()
                }
                .font(Font.custom("mainFont", size: 20))
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(12)
                .shadow(radius: 12)
                .padding()
            default:
                Text("")
            }
        }
    }
    
    var body: some View {
        let shadowRadius: CGFloat = 4
        
        VStack {
            
            parentBanner()
            
            Divider()
            
            VStack {
                HStack {
                    Button(action:{
                        if mode == "Mom" {
                            momStatus += 10
                            limitStatus(momStatus)
                        } else {
                            dadStatus += 10
                            limitStatus(dadStatus)
                        }
                        
                        life_happiness_status += 10
                        life_energy_status -= 2
                        
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
                        if mode == "Mom" {
                            momStatus += 20
                            limitStatus(momStatus)
                        } else {
                            dadStatus += 20
                            limitStatus(dadStatus)
                        }
                        
                        life_happiness_status += 20
                        life_energy_status -= 1
                        
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
                        if mode == "Mom" {
                            momStatus += 35
                            limitStatus(momStatus)
                        } else {
                            dadStatus += 35
                            limitStatus(dadStatus)
                        }
                        life_happiness_status += 5
                        
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
                        if mode == "Mom" {
                            momStatus += 75
                            limitStatus(momStatus)
                        } else {
                            dadStatus += 75
                            limitStatus(dadStatus)
                        }
                        life_happiness_status += 75
                        life_energy_status += 40
                        
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
                        if mode == "Mom" {
                            momStatus -= 75
                            limitStatus(momStatus)
                        } else {
                            dadStatus -= 75
                            limitStatus(dadStatus)
                        }
                        
                        life_happiness_status -= 70
                        life_energy_status -= 50
                        
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
                        if mode == "Mom" {
                            momStatus -= 10
                            limitStatus(momStatus)
                        } else {
                            dadStatus -= 10
                            limitStatus(dadStatus)
                        }
                        
                        life_happiness_status -= 2
                        
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

struct ParentsDetail_Previews: PreviewProvider {
    static var previews: some View {
        ParentsDetail(mode: "Mom")
    }
}
