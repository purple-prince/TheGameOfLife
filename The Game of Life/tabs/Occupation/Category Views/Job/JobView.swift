//
//  JobView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/24/21.
//

import SwiftUI

struct JobView: View{
    
    @AppStorage("app_color_index") var colorCount: Int = 0
    
    var appColor: Color {
        colorOptions[colorCount]
    }
    
    @State var tempJob = hourlyJobs.randomElement()!
    
    @State var jobListMode = "Hourly"
        
    func jobList(_ jobListMode: String) -> some View {
        
        Group {
            switch jobListMode {
            case "Hourly":
                ScrollView {
                    ForEach(hourlyJobs, id: \.self) { job in
                        Button(action:{
                            //jobObject = hourlyJobs.filter({ return $0.jobTitle == job.jobTitle })
                            
                        }, label: {
                            HStack {
                                Text(job.jobTitle)
                                //Text(String(jobObject.count()))
                                Spacer()
                                Text(String("$\(job.salary)/month"))
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)
                        })

                    }
                }

            case "Career":
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
                            .foregroundColor(appColor)                        })
                    }
                }
            case "Other":
                ScrollView {
                    ForEach(otherJobs, id: \.self) { job in
                        Button(action:{}, label: {
                            HStack {
                                Text(job.jobTitle)
                                Spacer()
                                Text(String("$\(job.salary)/month"))
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)                        })
                    }
                }
            default:
                ScrollView {
                    ForEach(hourlyJobs, id: \.self) { job in
                        Button(action:{}, label: {
                            HStack {
                                Text(job.jobTitle)
                                Spacer()
                                Text(String("$\(job.salary)/month"))
                            }
                            .padding()
                            .font(.system(size: 20))
                            .foregroundColor(appColor)                        })
                    }
                }
            }
        }
    }
    
    var body: some View {
        
        VStack {
            
            banner
        
            modeButtons
            
            Divider()
            
            jobList(jobListMode)
            
        }
        .offset(y: 72)
        .ignoresSafeArea()
        //.navigationBarHidden(true)
    }
}

extension JobView {
    var banner: some View {
        VStack /*current job*/ {
            Text(tempJob.jobTitle)
                .bold()
                .font(.largeTitle)
            Text("$\(tempJob.salary)/month")
                .font(.title3)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("- 0.3⚡️")
                    .padding(1)
                Text("-0.5😀")
            }
            
            Spacer()
        }
        .font(Font.custom("mainFont", size: 20))
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(Color("neonGreen"))
        .foregroundColor(appColor)
        .cornerRadius(12)
        .shadow(radius: 12)
        .padding()
    }
    
    var modeButtons: some View {
        HStack /*job categories*/{
            Spacer()
            Button(action: {
                jobListMode = "Hourly"
            }, label: {
                Text("Hourly")
                    .padding()
                    .background(appColor)
                    .cornerRadius(12)
            })
            
            
            
            Spacer()
            Button(action: {
                jobListMode = "Career"
            }, label: {
                Text("Career")
                    .padding()
                    .background(appColor)
                    .cornerRadius(12)
            })
            
            
            
            Spacer()
            Button(action: {
                jobListMode = "Other"
            }, label: {
                Text("Other")
                    .padding()
                    .background(appColor)
                    .cornerRadius(12)
            })
            Spacer()
        }
        .foregroundColor(Color.black)
    }
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView()
    }
}
