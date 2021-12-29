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
    
    @AppStorage("life_job_title") var life_job_title: String?
    @AppStorage("life_job_salary") var life_job_salary: Int?// = 0
    @AppStorage("life_net_worth") var life_net_worth: Int = 0
        
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
    
    func jobOption(job: Job) -> some View {
        Button(action: {
            life_job_title = job.jobTitle
            life_job_salary = job.salary
        }, label: {
            HStack {
                Text(job.jobTitle)
                Spacer()
                Text(String("$\(job.salary)/month"))
            }
            .padding()
            .font(.system(size: 20))
            .foregroundColor(appColor)
        })
    }
    
    func jobList(_ jobListMode: String) -> some View {
        
        Group {
            switch jobListMode {
            case "Hourly":
                ScrollView {
                    VStack {
                        ForEach(hourlyJobs, id: \.self) { job in
                            jobOption(job: job)
                        }
                        
                        Spacer()
                            .frame(width: 0, height: 100)
                    }
                }

            case "Career":
                ScrollView {
                    VStack {
                        ForEach(careerJobs, id: \.self) { job in
                            jobOption(job: job)
                        }
                        
                        Spacer()
                            .frame(width: 0, height: 100)
                    }
                }
            case "Other":
                ScrollView {
                    VStack {
                        ForEach(otherJobs, id: \.self) { job in
                            jobOption(job: job)
                        }
                        
                        Spacer()
                            .frame(width: 0, height: 100)
                    }
                }
            default:
                ScrollView {
                    VStack {
                        ForEach(hourlyJobs, id: \.self) { job in
                            jobOption(job: job)
                        }
                        
                        Spacer()
                            .frame(width: 0, height: 100)
                    }
                }
            }
        }
    }
    
    /*var hourlyJobInfo: [HourlyJob] {
        return hourlyJobs.filter({ return $0.jobTitle == life_job_title })
    }
    
    var careerJobInfo: [CareerJob] {
        return careerJobs.filter({ return $0.jobTitle == life_job_title })
    }
    
    var otherJobInfo: [OtherJob] {
        return otherJobs.filter({ return $0.jobTitle == life_job_title })
    }*/
    
    //passas either HourlyJob, CareerJob, or OtherJob into currentJobInfo func
    func jobInfo/*<T: Occupation>*/() -> Job {
        if hourlyJobs.filter({ return $0.jobTitle == life_job_title }).count > 0 {
            return hourlyJobs.filter({ return $0.jobTitle == life_job_title })[0]
        } else if careerJobs.filter({ return $0.jobTitle == life_job_title }).count > 0 {
            return careerJobs.filter({ return $0.jobTitle == life_job_title })[0]
        } else {
            return otherJobs.filter({ return $0.jobTitle == life_job_title })[0]
        }
    }
    
    var banner: some View {
        VStack /*current job*/ {
            Text(life_job_title ?? "Unemployed")
                .font(.largeTitle)
                .fontWeight(.medium)
            
            if life_job_salary != nil {
                Text("$\(life_job_salary!)/month")
                    .font(.title3)
                    .fontWeight(.light)
            }
                        
            Spacer()
            
            
            Button(action: {
                
                life_net_worth += jobInfo().salary
                
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 12)
                    
                    /*VStack(alignment: .leading) {
                        Text("- 0.3⚡️")
                            .padding(1)
                        Text("-0.5😀")
                    }*/
                    Text("Work")
                        .font(.title)
                        .foregroundColor(.white)
                }
            })
                .padding(.bottom, 8)
        }
        .font(Font.custom("mainFont", size: 20))
        .frame(maxWidth: .infinity, maxHeight: 160)
        .background(Color.white)
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
        .foregroundColor(Color.white)
    }
    
    func formatNum(_ _num: Int) -> String {
            var num = _num
            let strNum = String(num)
            var digits: [String] = []
            var i = 1

            while num != 0 {
              digits.append(String(num % 10))
              num /= 10
              if i % 3 == 0 {
                  digits.append(",")
              }
              i += 1
            }
            digits.reverse()
            if strNum.count % 3 == 0 {
              digits.removeFirst(1)
            }

            return digits.joined()
    }
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView()
    }
}
