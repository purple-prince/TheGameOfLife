//
//  RealEstateDetail.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 12/11/21.
//

import SwiftUI

struct RealEstateDetail: View {
    
    @State var ownedMode = true
    
    @Binding var showAssetsMain: Bool
    @Binding var showRealEstateDetail: Bool
        
    func jobList() -> some View {
        
        Group {
            if ownedMode {
                ScrollView {
                    ForEach(hourlyJobs, id: \.self) { job in
                        Button(action:{
                        }, label: {
                            HStack {
                                Text(job.jobTitle)
                                Spacer()
                                Text(String("$\(job.salary)/month"))
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        })
                    }
                }
            } else {
                ScrollView {
                    ForEach(careerJobs, id: \.self) { job in
                        Button(action:{}, label: {
                            HStack {
                                Text(job.jobTitle)
                                Spacer()
                                Text(String("$\(job.salary)/month"))
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(.black)                        })
                    }
                }
            }
        }
    }
    
    var body: some View {
        
        VStack {
            ZStack {
                banner
                closeButton
            }
            
            modeButton
            Divider()
            jobList()
            
            
        }
    }
}

extension RealEstateDetail {
    var banner: some View {
        VStack /*current job*/ {
            Text("7 Properties")
                .bold()
                .font(.largeTitle)
            Text("$660/month")
                .font(.title3)
        }
        .font(Font.custom("mainFont", size: 20))
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(12)
        .shadow(radius: 12)
        .padding()
    }
    var closeButton: some View {
        Button(action: {
            showRealEstateDetail = false
            showAssetsMain = true
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(Color.red)
                .font(Font.system(size: 40, weight: .medium))
                .padding(.leading, 300)
                .padding(.bottom, 90)
        })
    }
    var modeButton: some View {
        Button(action: {
            ownedMode.toggle()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color("mainDarkGrey"))
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.white)
                        .font(Font.system(size: 24))
                        .padding(.vertical)
                    Text(ownedMode ? "Owned" : "Market")
                        .padding()
                        .foregroundColor(.white)
                        .font(Font.system(size: 32))
                }
            }
            .frame(width: .infinity, height: 80)
            .padding(.horizontal)
        })
    }
}

struct RealEstateDetail_Previews: PreviewProvider {
    static var previews: some View {
        RealEstateDetail(showAssetsMain: .constant(false), showRealEstateDetail: .constant(true))
    }
}


/*
buy
sell
rent 
 */
