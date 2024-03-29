//
//  JobView.swift
//  The Game of Life
//
//  Created by Charlie Reeder on 8/24/21.
//

import SwiftUI

struct JobView: View{
    
    @EnvironmentObject var userPreferences: UserPreferences
    
    @Binding var showOccupationMain: Bool
    @Binding var showJobView: Bool
    
    @State var jobListMode = "Hourly"
    @State var showApplyPopup = false
    @State var showMainView = true
    @State var jobTapped: Job? = nil
    
    @State var applyAccepted: Bool = false
    @State var applyRejected: Bool = false
    @State var rejectedReason: String = ""
    
    // = 0
    @EnvironmentObject var player: Player
        
    var body: some View {
        ZStack {
            
            if showMainView {
                ZStack {
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
                    
                    VStack {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.red)
                                .font(Font.system(size: 32))
                                .padding(.horizontal)
                                .onTapGesture {
                                    showOccupationMain = true
                                    showJobView = false
                                }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
                .blur(radius: applyAccepted || applyRejected || showApplyPopup ? 32 : 0)
                .disabled(applyAccepted || applyRejected || showApplyPopup)
            }
            
            if showApplyPopup {
                ApplyPopup(showApplyPopup: $showApplyPopup, showMainView: $showMainView, job: jobTapped!)
            }
            
            if applyAccepted {
                applyInfoPopup(accepted: true)
            } else if applyRejected {
                applyInfoPopup(accepted: false)
            }
        }
    }
}

extension JobView {
    
    //Color(hue: 1.0, saturation: 0.027, brightness: 0.356)
    
    func applyInfoPopup(accepted: Bool) -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color("mainDarkGray"))
            
            VStack {
                Spacer()
                Text("You've been " + (accepted ? "accepted 😄" : "rejected 😐"))
                    .fontWeight(.medium)
                    .font(.title)
                if !accepted {
                    
                    Spacer()
                    
                    Text("Reason: " + rejectedReason)
                        .fontWeight(.light)
                        .font(.title2)
                    
                    
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .font(Font.system(size: 40))
                        .onTapGesture {
                            applyAccepted = false
                            applyRejected = false
                            rejectedReason = ""
                        }
                }
                Spacer()
            }
            .padding()
        }
        .aspectRatio(3/2, contentMode: .fit)
        .padding()
    }
    
    func checkRequirements(job: Job) -> Bool {
        if let requirements = job.requirements {
            if player.education_elementary_progress < Education.ElementarySchool.monthsRequired {
                return false
            } else {
                if requirements.contains(.highSchool) {
                    if player.education_highSchool_progress < Education.HighSchool.monthsRequired {
                        return false
                    } else {
                        if requirements.contains(.college) {
                            if player.education_college_progress < Education.CollegeSchool.monthsRequired {
                                return false
                            } else {
                                return true
                            }
                        } else {
                            return true
                        }
                    }
                } else {
                    return true
                }
            }
        } else {
            return true
        }
    }
    
    func jobOption(job: Job) -> some View {
        Button(action: {
            
            if checkRequirements(job: job) {
                applyAccepted = true
                player.life_job_title = job.jobTitle
                player.life_job_salary = job.salary
            } else {
                applyRejected = true
                rejectedReason = "Not educated enough 🤦‍♂️"
            }
        }, label: {
            HStack {
                Text(job.jobTitle)
                    .onTapGesture {
                        showApplyPopup = true
                        jobTapped = job
                        HapticManager.instance.playHaptic(type: .soft)
                    }
                Spacer()
                if job.jobTitle == player.life_job_title {
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
                player.life_job_title == job.jobTitle ? userPreferences.appColor : Color("mainDarkGray")
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
        if hourlyJobs.filter({ return $0.jobTitle == player.life_job_title }).count > 0 {
            return hourlyJobs.filter({ return $0.jobTitle == player.life_job_title })[0]
        } else if careerJobs.filter({ return $0.jobTitle == player.life_job_title }).count > 0 {
            return careerJobs.filter({ return $0.jobTitle == player.life_job_title })[0]
        } else {
            return otherJobs.filter({ return $0.jobTitle == player.life_job_title })[0]
        }
    }
    
    var banner: some View {
        VStack /*current job*/ {
            Text(player.life_job_title ?? "Unemployed")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(Color("mainWhite"))
                .padding(.top)
            
            if player.life_job_salary != nil {
                HStack {
                    Text("$\(player.life_job_salary!)/month")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(Color("mainWhite"))
                }
            }
                        
            Spacer()
            
            
            Button(action: {
                
                if !(player.life_job_title == nil) {
                    player.life_cash_balance += jobInfo().salary
                    player.life_health_status += jobInfo().healthMod
                    player.life_happiness_status += jobInfo().hapMod
                    player.life_energy_status += jobInfo().energyMod
                    
                    HapticManager.instance.playHaptic(type: .rigid)
                    
                    player.months_old += 1
                }
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
    
    @EnvironmentObject var player: Player
    
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
                Spacer()
                Text(formatNum(job.salary) + "/month")
                    .fontWeight(.light)
            }
            HStack {
                Text("Requirements: ")
                    .fontWeight(.light)
                Spacer()
                HStack(spacing: 0) {
                    if let requirements = job.requirements {
                        if requirements.contains(.college) {
                            Text("College")
                                .fontWeight(.light)
                                .foregroundColor(player.education_college_progress >= Education.CollegeSchool.monthsRequired ? .green : .red)
                        } else if requirements.contains(.highSchool) {
                            Text("High School")
                                .fontWeight(.light)
                                .foregroundColor(player.education_highSchool_progress >= Education.HighSchool.monthsRequired ? .green : .red)
                        } else if requirements.contains(.elementary) {
                            Text("Elementary")
                                .fontWeight(.light)
                                .foregroundColor(player.education_elementary_progress >= Education.ElementarySchool.monthsRequired ? .green : .red)
                        }
                    } else {
                        Text("None")
                            .fontWeight(.light)
                    }
                }
            }
            HStack {
                Text("Affects: ")
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
        RoundedRectangle(cornerRadius: 24)
            .foregroundColor(Color("mainDarkGray"))
            .frame(width: .infinity, height: UIScreen.main.bounds.height / 2)
            .padding()
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
        JobView(showOccupationMain: .constant(false), showJobView: .constant(true))
            .environmentObject(UserPreferences())
            .environmentObject(Player())
        //ApplyPopup(showApplyPopup: .constant(false), showMainView: .constant(false), job: hourlyJobs.randomElement()!)
    }
}
