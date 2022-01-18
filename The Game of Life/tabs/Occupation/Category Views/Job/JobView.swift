//
//  JobView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/24/21.
//

import SwiftUI

struct JobView: View{
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    
    @State var jobListMode = "Hourly"
    @State var showApplyPopup = false
    @State var showMainView = true
    @State var jobTapped: Job? = nil
    
    @AppStorage("life_job_title") var life_job_title: String?
    @AppStorage("life_job_salary") var life_job_salary: Int?// = 0
    @EnvironmentObject var player: Player
        
    var body: some View {
        
        ZStack {
            
            if showMainView {
                VStack {
                    
                    banner
                        .padding(.top)
                
                    modeButtons
                    
                    Divider()
                    
                    jobList(jobListMode)
                    
                }
                .offset(y: 72)
                .background(Color("mainWhite"))
                .ignoresSafeArea()
            }
            
            if showApplyPopup {
                ApplyPopup(showApplyPopup: $showApplyPopup, showMainView: $showMainView, job: jobTapped!)
            }
        }
        //.navigationBarHidden(true)
    }
}

extension JobView {
    
    //Color(hue: 1.0, saturation: 0.027, brightness: 0.356)
    
    func jobOption(job: Job) -> some View {
        Button(action: {
            life_job_title = job.jobTitle
            life_job_salary = job.salary
        }, label: {
            HStack {
                Text(job.jobTitle)
                    .onTapGesture {
                        showApplyPopup = true
                        jobTapped = job
                        HapticManager.instance.playHaptic(type: .soft)
                    }
                Spacer()
                if job.jobTitle == life_job_title {
                    Text(formatNum(job.salary) + " / month")
                } else {
                    Text("Apply")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(12)
                        .padding(.horizontal)
                        .background(Color("mainDarkGray"))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            .font(.system(size: 20))
            .foregroundColor(
                life_job_title == job.jobTitle ? userPreferences.appColor : Color("mainDarkGray")
            )
            .frame(width: .infinity, height: 52)
        })
    }
    
    func jobList(_ jobListMode: String) -> some View {
        Group {
            switch jobListMode {
            case "Hourly":
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(hourlyJobs, id: \.self) { job in
                            jobOption(job: job)
                            
                        //Divider()
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
                .foregroundColor(Color("mainWhite"))
                .padding(.top)
            
            if life_job_salary != nil {
                HStack {
                    Text("$\(life_job_salary!)/month")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(Color("mainWhite"))
                }
            }
                        
            Spacer()
            
            
            Button(action: {
                
                player.life_cash_balance += jobInfo().salary
                player.life_health_status += jobInfo().healthMod
                player.life_happiness_status += jobInfo().hapMod
                player.life_energy_status += jobInfo().energyMod
                HapticManager.instance.playHaptic(type: .rigid)
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(userPreferences.appColor, lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 12)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.002, brightness: 0.298))
                        
                    
                    Text("Work")
                        .font(.title)
                        .foregroundColor(.white)
                }
            })
                .padding(.bottom, 8)
        }
        .font(Font.custom("mainFont", size: 20))
        .frame(maxWidth: .infinity, maxHeight: 175)
        .background(Color("mainDarkGray"))
        .cornerRadius(12)
        .shadow(radius: 12)
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    var modeButtons: some View {
        HStack /*job categories*/{
            Spacer()
            Button(action: {
                jobListMode = "Hourly"
                HapticManager.instance.playHaptic(type: .soft)
            }, label: {
                Text("Hourly")
                    .padding()
                    .background(Color("mainDarkGray"))
                    .cornerRadius(12)
            })
            
            
            
            Spacer()
            Button(action: {
                jobListMode = "Career"
                HapticManager.instance.playHaptic(type: .soft)
            }, label: {
                Text("Career")
                    .padding()
                    .background(Color("mainDarkGray"))
                    .cornerRadius(12)
            })
            
            
            
            Spacer()
            Button(action: {
                jobListMode = "Other"
                HapticManager.instance.playHaptic(type: .soft)
            }, label: {
                Text("Other")
                    .padding()
                    .background(Color("mainDarkGray"))
                    .cornerRadius(12)
            })
            Spacer()
        }
        .foregroundColor(Color.white)
    }
}

struct ApplyPopup: View {
    
    @Binding var showApplyPopup: Bool
    @Binding var showMainView: Bool
    
    var job: Job
    
    var body: some View {
        ZStack {
            
            background
            
            VStack(spacing: 0) {
                
                closeButton
                
                Text(job.jobTitle)
                    .font(.largeTitle)
                    .padding(.bottom, 2)
                
                Color.white
                    .clipShape(Capsule())
                    .frame(width: 128, height: 2)
                
                jobStats
                
                description
                
                Spacer()
            }
            .foregroundColor(.white)
            .frame(width: .infinity, height: UIScreen.main.bounds.height / 2)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension ApplyPopup {
    var description: some View {
        VStack {
            Text("Job Description: \n")
                .fontWeight(.light)
                .underline()
                .font(.title2)
            
            Text(job.description)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
    var jobStats: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Salary: ")
                    .fontWeight(.light)
                Spacer()
                Text(formatNum(job.salary) + "/month")
                    .fontWeight(.light)
            }
            HStack {
                Text("Requirements: ")
                    .fontWeight(.light)
                Spacer()
                Text("None")
                    .fontWeight(.light)
            }
            HStack {
                Text("Affects: ")
                    .fontWeight(.light)
                Spacer()
                VStack {
                    Text(String(job.hapMod) + " 😀")
                        .fontWeight(.light)
                    Text(String(job.energyMod) + " ⚡️")
                        .fontWeight(.light)
                }
            }
        }
        .padding()
        .font(.title2)
        .frame(width: UIScreen.main.bounds.width * 4 / 5)
    }
    var background: some View {
        ZStack {
            Color(UIColor.systemGray3)
                .opacity(0.9)
                .edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(Color("mainDarkGray"))
                //.background(Color("appMainWhite")).blur(radius: 10)
                .frame(width: .infinity, height: UIScreen.main.bounds.height / 2)
                .padding()
        }
    }
    var closeButton: some View {
        HStack {
            Spacer()
            Image(systemName: "xmark")
                .foregroundColor(.red)
                .padding(.horizontal)
                .padding(.top)
                .font(Font.system(size: 40))
                .onTapGesture {
                    withAnimation(.linear) {
                        showApplyPopup = false
                        showMainView = true
                    }
                }
        }

    }
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView()
            .environmentObject(UserPreferences())
            .environmentObject(Player())
        //ApplyPopup(showApplyPopup: .constant(false), showMainView: .constant(false), job: hourlyJobs.randomElement()!)
    }
}
