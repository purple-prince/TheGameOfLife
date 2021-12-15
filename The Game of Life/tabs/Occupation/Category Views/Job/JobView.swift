//
//  JobView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/24/21.
//

import SwiftUI

struct JobView: View{
    
    @State var tempJob = hourlyJobs.randomElement()!
    //@State var jobTitle = ""
    
    @State var jobListMode = "Hourly"
    //@State var jobObject: [HourlyJob] = []
        
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
                            .foregroundColor(.black)
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
                            .foregroundColor(.black)                        })
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
                            .foregroundColor(.black)                        })
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
                            .foregroundColor(.black)                        })
                    }
                }
            }
        }
    }
    
    var body: some View {
        
        VStack {
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
            .foregroundColor(.black)
            .cornerRadius(12)
            .shadow(radius: 12)
            .padding()
        
            
            HStack /*job categories*/{
                Spacer()
                Button(action: {
                    jobListMode = "Hourly"
                }, label: {
                    Text("Hourly")
                        .padding()
                        .background(Color("neonGreen"))
                        .cornerRadius(12)
                })
                
                
                
                Spacer()
                Button(action: {
                    jobListMode = "Career"
                }, label: {
                    Text("Career")
                        .padding()
                        .background(Color("neonGreen"))
                        .cornerRadius(12)
                })
                
                
                
                Spacer()
                Button(action: {
                    jobListMode = "Other"
                }, label: {
                    Text("Other")
                        .padding()
                        .background(Color("neonGreen"))
                        .cornerRadius(12)
                })
                Spacer()
            }
            .foregroundColor(Color.black)
            
            Divider()
            
            jobList(jobListMode)
            
        }
        .offset(y: 72)
        .ignoresSafeArea()
        //.navigationBarHidden(true)
    }
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView()
    }
}
