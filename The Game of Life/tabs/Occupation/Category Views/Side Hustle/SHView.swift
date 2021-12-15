//
//  SideHustleView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 9/5/21.
//

import SwiftUI

struct SHView: View {
    let tempSH = listOfSideHustles.randomElement()!
    
    var body: some View {
        VStack {
            VStack /*current job*/ {
                Text(tempSH.shTitle)
                    .bold()
                    .font(.largeTitle)
                Text("Level \(tempSH.level)")
                    .font(.title3)
                Text("$\(tempSH.salaryMin) - $\(tempSH.salaryMax)/month")
                    .font(.title3)

                
                Spacer()
                
                HStack {
                    Spacer()
                    Text("- 0.3⚡️")
                        .padding(1)
                    Spacer()
                    Text("-0.5😀")
                    Spacer()
                }
                
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
            
            ScrollView {
                ForEach(listOfSideHustles, id: \.self) { sh in
                    Button(action: {}, label: {
                        HStack {
                            Text(sh.shTitle)
                            Spacer()
                            Text("$\(tempSH.salaryMin) - $\(tempSH.salaryMax)/month")
                        }
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    })
                }
            }
        }
        //.navigationBarHidden(true)
    }
}

struct SHView_Previews: PreviewProvider {
    static var previews: some View {
        SHView()
    }
}

/*
 ScrollView {
     ForEach(hourlyJobs, id: \.self) { job in
         Button(action:{}, label: {
             HStack {
                 Text(job.jobTitle)
                 Spacer()
                 Text(String("$\(job.salary)/month"))
             }
             .padding()
         })
     }
 }
 */
