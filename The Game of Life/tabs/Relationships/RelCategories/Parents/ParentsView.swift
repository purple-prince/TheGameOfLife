//
//  ParentsView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 10/30/21.
//

import SwiftUI

struct ParentsView: View {
        
    var body: some View {
                
        NavigationView {
            VStack {
                banner
                            
                Divider()
                
                VStack {
                    
                    NavigationLink(destination: {
                        ParentsDetail(mode: "Mom")
                    }, label:{
                        HStack {
                            Text(tempParents.mom.emoji + " " + tempParents.mom.name)
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
                    
                    NavigationLink(destination: {ParentsDetail(mode: "Dad")}, label: {
                        HStack {
                            Text(tempParents.dad.emoji + " " + tempParents.dad.name)
                            Spacer()
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 120, height: 12)
                                    .foregroundColor(Color.gray)
                                    
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: ParentsDetail(mode: "Dad").momStatus, height: 12)
                                    .foregroundColor(Color.green)
                            }
                        }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    })
                }
                Spacer()
            }
            .offset(y: 72)
        .ignoresSafeArea()
        }
    }
}

struct ParentLink: View {
    var body: some View {
        HStack {
            Text(tempParents.dad.emoji + " " + tempParents.dad.name)
        }
    }
}

extension ParentsView {
    var banner: some View {
        VStack /*current job*/ {
            Spacer()
            
            Text("Parents")
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
    }
    
    var parentLink: some View {
        Text("")
    }
}

struct ParentsView_Previews: PreviewProvider {
    static var previews: some View {
        ParentsView()
    }
}
